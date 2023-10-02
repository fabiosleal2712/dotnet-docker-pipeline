# Use the .NET SDK 8.0 as the base image
FROM mcr.microsoft.com/dotnet/sdk:8.0

# Set the working directory in the container to /app
WORKDIR /app

# Copy the app and dotnet directories to the container
COPY ./app /app
COPY ./dotnet /dotnet

# Create a symbolic link and set the command to run the application
CMD bash -c "ln -s /app/wwwroot/ /wwwroot && /dotnet/dotnet /app/Niu.Living.dll"
