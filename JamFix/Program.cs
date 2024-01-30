using JamFix.Filters;
using JamFix.Handler;
using JamFix.Model.Modeli;
using JamFix.Model.SearchObjects;
using JamFix.Services.Database;
using JamFix.Services.Interface;
using JamFix.Services.ProizvodiSM;
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
//StripeConfiguration.ApiKey = "sk_test_51OYqyiFJavMmN9lEHYOinCIgUffaB493XjhUGTvXmXgHizTZMQyfiBDD2gwT3ooovIwGBU91gXRwAEytsmByPcbc00V5LeI9dl";

var builder = WebApplication.CreateBuilder(args);
var config = builder.Configuration;
builder.Services.AddAuthentication(x =>
{
    x.DefaultAuthenticateScheme = JwtBearerDefaults.AuthenticationScheme;
    x.DefaultChallengeScheme = JwtBearerDefaults.AuthenticationScheme;
    x.DefaultScheme = JwtBearerDefaults.AuthenticationScheme;
}).AddJwtBearer(x =>
{
    x.TokenValidationParameters = new TokenValidationParameters
    {
        ValidIssuer = config["Jwt:Issuer"],
        ValidAudience = config["Jwt:Audience"],
        IssuerSigningKey = new SymmetricSecurityKey
        (Encoding.UTF8.GetBytes(config["Jwt:Key"]!)),
        ValidateIssuer = true,
        ValidateAudience = true,
        ValidateLifetime = true,
        ValidateIssuerSigningKey = true
    };
});

builder.Services.AddAuthorization(options =>
{
    options.AddPolicy(Identity.AdminUserPolicyName, p =>
    p.RequireClaim(Identity.AdminUserClaimName, "true"));
});


//builder.Services.AddControllers(x => 
//{ 
//    x.Filters.Add<ErrorFilter>();
//});

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
builder.Services.AddTransient<IService<Uloge, BaseSO>, BaseService<Uloge, Uloga, BaseSO>>();
builder.Services.AddTransient<IVrsteProizvodaService, VrsteProizvodaService>();
builder.Services.AddTransient<IStatusZahtjevaService, StatusZahtjevaService>();
builder.Services.AddTransient<IKorisnikUlogeService, KorisnikUlogeService>();
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


builder.Services.AddTransient<BaseState>();
builder.Services.AddTransient<InitialProductState>();
builder.Services.AddTransient<DraftProductState>();
builder.Services.AddTransient<ActiveProductState>();

builder.Services.AddAutoMapper(typeof(Program));
builder.Services.AddControllersWithViews();

builder.Services.AddScoped<UserService>();

// Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle

var connectionString = builder.Configuration.GetConnectionString("DefaultConnection");
builder.Services.AddDbContext<Context>(options => 
        options.UseSqlServer(connectionString));

builder.Services.AddAutoMapper(typeof(IKorisniciService));
//builder.Services.AddAuthentication("BasicAuthentication")
//    .AddScheme<AuthenticationSchemeOptions, BasicAuthenticationHandler>("BasicAuthentication", null);

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
