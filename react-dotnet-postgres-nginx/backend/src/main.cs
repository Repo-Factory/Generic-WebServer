WebApplication setupApp()
{
    var builder = WebApplication.CreateBuilder(args);
    builder.Services.AddEndpointsApiExplorer();
    builder.Services.AddSwaggerGen();
    return builder.Build();
}

void setupHttpPipeline(WebApplication app)
{
    if (app.Environment.IsDevelopment())
    {
        app.UseSwagger();
        app.UseSwaggerUI();
    }
    app.UseHttpsRedirection();
} 

void setupEndpoints(WebApplication app)
{
    Endpoints.Expose.IntegerEndpoint(app);
}

void startServer()
{
    var app = setupApp();
    setupHttpPipeline(app);
    setupEndpoints(app);
    app.Run();
}

startServer();