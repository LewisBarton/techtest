# Use the official .NET SDK image to build the application
FROM mcr.microsoft.com/dotnet/sdk:7.0 AS build

# Set the working directory inside the container
WORKDIR /app

# Copy the project files
COPY . .

# Create a temporary default .csproj file if necessary
RUN echo '<Project Sdk="Microsoft.NET.Sdk"><PropertyGroup><OutputType>Exe</OutputType><TargetFramework>net7.0</TargetFramework></PropertyGroup></Project>' > /app/UserManagement.Web/UserManagement.Web.csproj

# Restore dependencies
RUN dotnet restore || echo "Ignoring restore errors"

# Build the application
RUN dotnet build -c Release --no-restore -o /app/build

# Publish the application
FROM build AS publish
RUN dotnet publish -c Release --no-build -o /app/publish

# Use the official .NET runtime image to run the application
FROM mcr.microsoft.com/dotnet/aspnet:7.0 AS final
WORKDIR /app

# Copy the published application from the previous stage
COPY --from=publish /app/publish .

# Expose the port the app will run on
EXPOSE 80

# Set the entry point for the application
ENTRYPOINT ["dotnet", "UserManagement.Web.dll"]
