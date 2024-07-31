# Use the official .NET SDK image to build the application
FROM mcr.microsoft.com/dotnet/sdk:7.0 AS build

# Set the working directory inside the container
WORKDIR /app

# Copy all project files and restore dependencies
COPY UserManagement.Web/UserManagement.Web.csproj UserManagement.Web/
COPY UserManagement.Data/UserManagement.Data.csproj UserManagement.Data/
COPY UserManagement.Services/UserManagement.Services.csproj UserManagement.Services/
WORKDIR /app
RUN dotnet restore

# Copy the rest of the source code
COPY . .

# Build the application
RUN dotnet build -c Release -o /app/build

# Publish the application
FROM build AS publish
RUN dotnet publish -c Release -o /app/publish

# Use the official .NET runtime image to run the application
FROM mcr.microsoft.com/dotnet/aspnet:7.0 AS final
WORKDIR /app

# Copy the published application from the previous stage
COPY --from=publish /app/publish .

# Expose the port the app will run on
EXPOSE 80

# Set the entry point for the application
ENTRYPOINT ["dotnet", "UserManagement.Web.dll"]
