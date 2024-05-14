using JamFix.Filters;
using JamFix.Handler;
using JamFix.Model.Modeli;
using JamFix.Model.SearchObjects;
using JamFix.Services.Database;
using JamFix.Services.Interface;
using JamFix.Services.Service;
using Microsoft.AspNetCore.Authentication;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.AspNetCore.Hosting;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.IdentityModel.Tokens;
using Microsoft.OpenApi.Models;
using System.IdentityModel.Tokens.Jwt;
using System.Text;
using Stripe;
using RabbitMQ.Client.Events;
using RabbitMQ.Client;
using System.Text.Json;
using JamFix.Model.Requests;

var builder = WebApplication.CreateBuilder(args);

builder.Services.AddTransient<IService<Uloge, BaseSO>, BaseService<Uloge, Uloga, BaseSO>>();
builder.Services.AddTransient<IVrsteProizvodaService, VrsteProizvodaService>();
builder.Services.AddTransient<IStatusZahtjevaService, StatusZahtjevaService>();
builder.Services.AddTransient<IKorisnikUlogeService, KorisnikUlogeService>();
builder.Services.AddTransient<IUslugeStavkeService, UslugeStavkeService>();
builder.Services.AddTransient<IRadniNalogService, RadniNalogService>();
builder.Services.AddTransient<IIzvjestajiService, IzvjestajiService>();
builder.Services.AddTransient<IProizvodiService, ProizvodiService>();
builder.Services.AddTransient<IKorisniciService, KorisniciService>();
builder.Services.AddTransient<IPozicijaService, PozicijaService>();
builder.Services.AddTransient<IZahtjeviService, ZahtjeviService>();
builder.Services.AddTransient<INovostiService, NovostiService>();
builder.Services.AddTransient<IDrzaveService, DrzaveService>();
builder.Services.AddTransient<IUslugeService, UslugeService>();
builder.Services.AddTransient<IOcjeneService, OcjeneService>();
builder.Services.AddTransient<IUlogaService, UlogaService>();


var config = builder.Configuration;


builder.Services.AddAuthorization(options =>
{
    options.AddPolicy(Identity.AdminUserPolicyName, p =>
    p.RequireClaim(Identity.AdminUserClaimName, "true"));
});


builder.Services.AddControllers(x =>
{
    x.Filters.Add<ErrorFilter>();
});

builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen(c =>
{
    c.AddSecurityDefinition("basicAuth", new Microsoft.OpenApi.Models.OpenApiSecurityScheme()
    {
        Type = Microsoft.OpenApi.Models.SecuritySchemeType.Http,
        Scheme = "basic"
    });
    c.AddSecurityRequirement(new OpenApiSecurityRequirement()
    {
        {
            new OpenApiSecurityScheme
            {
                Reference = new OpenApiReference{Type = ReferenceType.SecurityScheme, Id="basicAuth"}
            },
            new string[]{}
        }
    });
});
builder.Services.AddAuthentication("BasicAuthentication")
    .AddScheme<AuthenticationSchemeOptions, BasicAuthenticationHandler>("BasicAuthentication", null);


builder.Services.AddAutoMapper(typeof(Program));
builder.Services.AddControllersWithViews();

builder.Services.AddScoped<UserService>();

var connectionString = builder.Configuration.GetConnectionString("DefaultConnection");
builder.Services.AddDbContext<Context>(options => 
        options.UseSqlServer(connectionString));

builder.Services.AddAutoMapper(typeof(IKorisniciService));



var app = builder.Build();

if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

app.UseHttpsRedirection();
app.UseAuthentication();
app.UseAuthorization();
app.MapControllers();

using (var scope = app.Services.CreateScope())
{
    var dataContext = scope.ServiceProvider.GetRequiredService<Context>();

    var conn = dataContext.Database.GetConnectionString();

    dataContext.Database.Migrate();

    dataContext.Database.EnsureCreated();
}



string hostname = Environment.GetEnvironmentVariable("RABBITMQ_HOST") ?? "";
string username = Environment.GetEnvironmentVariable("RABBITMQ_USERNAME") ?? "guest";
string password = Environment.GetEnvironmentVariable("RABBITMQ_PASSWORD") ?? "guest";
string virtualHost = Environment.GetEnvironmentVariable("RABBITMQ_VIRTUALHOST") ?? "/";

var factory = new ConnectionFactory
{
    HostName = hostname,
    UserName = username,
    Password = password,
    VirtualHost = virtualHost,
};

using var connection = factory.CreateConnection();
using var channel = connection.CreateModel();

channel.QueueDeclare(queue: "drzava",
                     durable: false,
                     exclusive: false,
                     autoDelete: true,
                     arguments: null);
Console.WriteLine(" [*] Waiting for messages.");
var consumer = new EventingBasicConsumer(channel);

consumer.Received += async (model, ea) =>
{
    var body = ea.Body.ToArray();
    var message = Encoding.UTF8.GetString(body);
    Console.WriteLine(message.ToString());
    var notification = JsonSerializer.Deserialize<DrzavaInsertRequest>(message);

    using (var scope = app.Services.CreateScope())
    {
        var notificationsService = scope.ServiceProvider.GetRequiredService<IDrzaveService>();
        if (notification != null)
        {
            try
            {
                await notificationsService.Insert(notification);
            }
            catch (Exception e)
            {
            }
        }
    }
    Console.WriteLine(Environment.GetEnvironmentVariable("Some"));
};
channel.BasicConsume(queue: "drzava",
                     autoAck: true,
                     consumer: consumer);

app.Run();
