param (
    [switch]$External,
    [switch]$Regular,
    [switch]$All,
    [switch]$Help
)

$extensions = @(
    "aaron-bond.better-comments",
    "dqisme.sync-scroll",
    "eamodio.gitlens",
    "editorconfig.editorconfig",
    "esbenp.prettier-vscode",
    "formulahendry.code-runner",
    "golang.go",
    "gruntfuggly.todo-tree",
    "humao.rest-client",
    "mitchdenny.ecdc",
    "ms-dotnettools.vscode-dotnet-runtime",
    "robbowen.synthwave-vscode",
    "rust-lang.rust-analyzer",
    "seatonjiang.gitmoji-vscode",
    "sonarsource.sonarlint-vscode",
    "sourcegraph.cody-ai",
    "tamasfe.even-better-toml"
)

$externalExtensions = @(
    @{
        url = "https://github.com/Azure/bicep/releases/latest/download/vscode-bicep.vsix"
        filename = "ms-azuretools.vscode-bicep.vsix"
    }
)

function Show-Usage {
    Write-Host "Usage: .\install-extensions.ps1 [-External] [-Regular] [-All]"
    Write-Host ""
    Write-Host "Options:"
    Write-Host "  -External  Install only external extensions"
    Write-Host "  -Regular   Install only regular extensions"
    Write-Host "  -All       Install both external and regular extensions"
    Write-Host ""
    Write-Host "If no option is specified, usage information is displayed."
}

function Install-ExternalExtensions {
    foreach ($extension in $externalExtensions) {
        $extensionUrl = $extension.url
        $extensionPath = $extension.filename

        Invoke-WebRequest -Uri $extensionUrl -OutFile $extensionPath

        codium --install-extension $extensionPath
        Remove-Item $extensionPath
    }
    Write-Host "External extensions have been installed successfully!"
}

function Install-RegularExtensions {
    foreach ($extension in $extensions) {
        codium --install-extension $extension
    }
    Write-Host "Regular extensions have been installed successfully!"
}

if ($Help) {
    Show-Usage
}
elseif ($External) {
    Install-ExternalExtensions
}
elseif ($Regular) {
    Install-RegularExtensions
}
else {
    Install-RegularExtensions
    Install-ExternalExtensions
    Write-Host "All extensions have been installed successfully!"
}