# Otel-Azure-PoC

This repository contains the reproduction of an issue identified with Azure App Service and OpenTelemetry when enabling CORS.

## Issue
When running an Azure App Service with CORS enabled and an OpenTelemetry enabled .NET 8 application deployed the app will not generate traces to the App Service's Console even when the `OpenTelemetry.Exporters.ConsoleExporter` is added. 
If the CORS policy is disabled the traces will be generated as expected.

## Steps to reproduce
1. Clone the repository
1. Open `infra/app-service-with-cors.bicep` and modify the resource names to unique values
1. Create an Azure App Service using the `infra/app-service-with-cors.bicep`
1. Open `infra/app-service-without-cors.bicep` and modify the resource names to unique values
1. Create an Azure App Service using the `infra/app-service-without-cors.bicep`
1. Deploy the `Otel-Azure-PoC` project to both App Services
1. Access the App Service without CORS enabled on `/WeatherForecast` and check the console logs
    1. **Expected**: The console log shows traces for the http.route `WeatherForecast` every time the endpoint is accessed
1. Access the App Service with CORS enabled on `/WeatherForecast` and check the console logs
    1. **Expected**: The console log shows no traces for the http.route `WeatherForecast`
