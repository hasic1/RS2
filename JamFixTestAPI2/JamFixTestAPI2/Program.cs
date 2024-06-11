using JamFixTestAPI2;
using Microsoft.AspNetCore.Mvc;

var builder = WebApplication.CreateBuilder(args);
builder.Services.AddResponseCaching();

builder.Services.AddControllers();

builder.Services.Configure<ApiBehaviorOptions>(options =>
{
    options.SuppressModelStateInvalidFilter = true;
});
builder.Services.AddCors(options => options.AddPolicy(
                             name: "CorsPolicy",
                             builder => builder.AllowAnyOrigin().AllowAnyMethod().AllowAnyHeader()
                         ));

builder.Services.Configure<ApiBehaviorOptions>(options => options.SuppressModelStateInvalidFilter = true);
if (builder.Environment.IsDevelopment())
{
    builder.Services.AddSwaggerGen();
}
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();
builder.Services.AddCors(options => options.AddPolicy(
                             name: "CorsPolicy",
                             builder => builder.AllowAnyOrigin().AllowAnyMethod().AllowAnyHeader()
                         ));



builder.Services.Configure<ApiBehaviorOptions>(options => options.SuppressModelStateInvalidFilter = true);
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

app.Run();