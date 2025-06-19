using Core.Service;
using DataAccess.Models;
using FluentAssertions;

namespace Core.Test.Service
{
    public class ConectionStringBuilderServiceTests
    {
        private readonly ConectionStringBuilderService _service;

        public ConectionStringBuilderServiceTests()
        {
            _service = new ConectionStringBuilderService();
        }

        [Fact]
        public void BuildConnectionString_ShouldReturnSqlServerConnectionString_WhenDatabaseTypeIsSqlServer()
        {
            // Arrange
            var conexion = new ONAConexion
            {
                OrigenDatos = "SQLSERVER",
                Host = "localhost",
                BaseDatos = "MiBase",
                Usuario = "admin",
                Contrasenia = "1234",
                Puerto = 1433
            };

            var expected = "Server=localhost;Database=MiBase;User Id=admin;Password=1234;TrustServerCertificate=True;";

            // Act
            var result = _service.BuildConnectionString(conexion);

            // Assert
            result.Should().Be(expected);
        }

        [Fact]
        public void BuildConnectionString_ShouldReturnMySqlConnectionString_WhenDatabaseTypeIsMysql()
        {
            // Arrange
            var conexion = new ONAConexion
            {
                OrigenDatos = "MYSQL",
                Host = "127.0.0.1",
                BaseDatos = "testdb",
                Usuario = "root",
                Contrasenia = "rootpass",
                Puerto = 3306
            };

            var expected = "Server=127.0.0.1;Database=testdb;Uid=root;Pwd=rootpass;Port=3306;SslMode=None;";

            // Act
            var result = _service.BuildConnectionString(conexion);

            // Assert
            result.Should().Be(expected);
        }

        [Fact]
        public void BuildConnectionString_ShouldReturnPostgresConnectionString_WhenDatabaseTypeIsPostgres()
        {
            // Arrange
            var conexion = new ONAConexion
            {
                OrigenDatos = "POSTGRES",
                Host = "localhost",
                BaseDatos = "postgresdb",
                Usuario = "postgres",
                Contrasenia = "secret",
                Puerto = 5432
            };

            var expected = "Host=localhost;Port=5432;Database=postgresdb;Username=postgres;Password=secret;";

            // Act
            var result = _service.BuildConnectionString(conexion);

            // Assert
            result.Should().Be(expected);
        }

        [Fact]
        public void BuildConnectionString_ShouldReturnSqliteConnectionString_WhenDatabaseTypeIsSqlite()
        {
            // Arrange
            var conexion = new ONAConexion
            {
                OrigenDatos = "SQLLITE",
                BaseDatos = "data.db"
            };

            var expected = "data source=data.db";

            // Act
            var result = _service.BuildConnectionString(conexion);

            // Assert
            result.Should().Be(expected);
        }

        [Fact]
        public void BuildConnectionString_ShouldFallbackToSqlServer_WhenOrigenDatosIsInvalid()
        {
            // Arrange
            var conexion = new ONAConexion
            {
                OrigenDatos = "INVALID",
                Host = "localhost",
                BaseDatos = "defaultdb",
                Usuario = "user",
                Contrasenia = "pass",
                Puerto = 1433
            };

            var expected = "Server=localhost;Database=defaultdb;User Id=user;Password=pass;TrustServerCertificate=True;";

            // Act
            var result = _service.BuildConnectionString(conexion);

            // Assert
            result.Should().Be(expected);
        }
    }
}
