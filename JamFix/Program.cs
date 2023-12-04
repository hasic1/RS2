using JamFix.Filters;
using JamFix.Handler;
using JamFix.Model.Modeli;
using JamFix.Model.SearchObjects;
using JamFix.Services.Database;
using JamFix.Services.Interface;
using JamFix.Services.ProizvodiSM;
using JamFix.Services.Service;
using Microsoft.AspNetCore.Authentication;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.OpenApi.Models;

var builder = WebApplication.CreateBuilder(args);

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
// Add services to the container.
//Dodaj ovde dependency injection  
builder.Services.AddTransient<IVrsteProizvodaService, VrsteProizvodaService>();
builder.Services.AddTransient<IRadniNalogService, RadniNalogService>();
builder.Services.AddTransient<IIzvjestajiService, IzvjestajiService>();
builder.Services.AddTransient<IProizvodiService, ProizvodiService>();
builder.Services.AddTransient<IKorisniciService, KorisniciService>();
builder.Services.AddTransient<IZahtjeviService, ZahtjeviService>();
builder.Services.AddTransient<INovostiService, NovostiService>();
builder.Services.AddTransient<IUslugeService, UslugeService>();
builder.Services.AddTransient<IService<Uloge, BaseSO>, BaseService<Uloge, Uloga, BaseSO>>();

builder.Services.AddTransient<BaseState>();
builder.Services.AddTransient<InitialProductState>();
builder.Services.AddTransient<DraftProductState>();
builder.Services.AddTransient<ActiveProductState>();


builder.Services.AddAutoMapper(typeof(Program));
builder.Services.AddControllersWithViews();


// Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle


var connectionString = builder.Configuration.GetConnectionString("DefaultConnection");
builder.Services.AddDbContext<Context>(options => 
        options.UseSqlServer(connectionString));

builder.Services.AddAutoMapper(typeof(IKorisniciService));
builder.Services.AddAuthentication("BasicAuthentication")
    .AddScheme<AuthenticationSchemeOptions, BasicAuthenticationHandler>("BasicAuthentication", null);

var app = builder.Build();

// Configure the HTTP request pipeline.
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
    dataContext.Database.Migrate();
}
app.Run();
