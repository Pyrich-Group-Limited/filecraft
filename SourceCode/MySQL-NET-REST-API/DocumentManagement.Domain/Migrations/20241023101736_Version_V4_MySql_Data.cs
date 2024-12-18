﻿using Microsoft.EntityFrameworkCore.Migrations;
using System.IO;
using System.Linq;
using System.Reflection;
using System.Text.RegularExpressions;

#nullable disable

namespace DocumentManagement.Domain.Migrations
{
    /// <inheritdoc />
    public partial class Version_V4_MySql_Data : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            var assembly = Assembly.GetExecutingAssembly();
            var type = GetType();
            var regex = new Regex($@"{Regex.Escape(type.Namespace)}\.\d{{14}}_{Regex.Escape(type.Name)}\.sql");

            var resourceName = assembly.GetManifestResourceNames().FirstOrDefault(x => regex.IsMatch(x));
            using var stream = assembly.GetManifestResourceStream(resourceName);
            using var reader = new StreamReader(stream);
            var sqlResult = reader.ReadToEnd();
            migrationBuilder.Sql(sqlResult);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {

        }
    }
}
