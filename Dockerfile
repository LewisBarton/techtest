# Use the official .NET SDK image to build the application
FROM mcr.microsoft.com/dotnet/sdk:7.0 AS build

# Set the working directory inside the container
WORKDIR /app

# Copy the project files and restore dependencies
COPY UserManagement.Web/UserManagement.Web.csproj UserManagement.Web/
WORKDIR /app/UserManagement.Web
RUN dotnet restore

# Copy the rest of the application code
COPY . .

# Build the application
RUN dotnet build -c Release -o /app/build
