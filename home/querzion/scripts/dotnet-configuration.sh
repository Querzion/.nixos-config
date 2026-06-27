#!/usr/bin/env bash
set -e

echo "=== Installing dotnet-ef ==="
dotnet tool install --global dotnet-ef || dotnet tool update --global dotnet-ef

echo ""
echo "=== Installing .NET templates ==="

templates=(
  "Umbraco.Templates"
  "Avalonia.Templates"
  "DotVVM.Templates"
  "Popov1024.HttpApi.Template.CSharp"
  "Robell.AksApi.Template"
  "GatewayProgrammingSchool.xUnit.CSharp"
  "eisk.webapi"
)

for t in "${templates[@]}"; do
  echo "--- Installing $t ---"
  dotnet new install "$t" || echo "Failed: $t (skipping)"
done

echo ""
echo "=== Done ==="
echo "dotnet-ef version: $(dotnet-ef --version 2>/dev/null || echo 'not found, check PATH for ~/.dotnet/tools')"
echo "Installed templates:"
dotnet new list
