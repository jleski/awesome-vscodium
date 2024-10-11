#!/bin/bash

extensions=(
    "aaron-bond.better-comments"
    "dqisme.sync-scroll"
    "eamodio.gitlens"
    "editorconfig.editorconfig"
    "esbenp.prettier-vscode"
    "formulahendry.code-runner"
    "golang.go"
    "gruntfuggly.todo-tree"
    "humao.rest-client"
    "mitchdenny.ecdc"
    "ms-dotnettools.vscode-dotnet-runtime"
    "robbowen.synthwave-vscode"
    "rust-lang.rust-analyzer"
    "seatonjiang.gitmoji-vscode"
    "sonarsource.sonarlint-vscode"
    "sourcegraph.cody-ai"
    "tamasfe.even-better-toml"
)

external_extensions=(
    "https://github.com/Azure/bicep/releases/latest/download/vscode-bicep.vsix|ms-azuretools.vscode-bicep.vsix"
)

show_usage() {
    echo "Usage: ./install-extensions.sh [-e|--external] [-r|--regular] [-a|--all]"
    echo ""
    echo "Options:"
    echo "  -e, --external  Install only external extensions"
    echo "  -r, --regular   Install only regular extensions"
    echo "  -a, --all       Install both external and regular extensions"
    echo ""
    echo "If no option is specified, usage information is displayed."
}

install_external_extensions() {
    for extension in "${external_extensions[@]}"; do
        IFS='|' read -r url filename <<< "$extension"
        curl -L "$url" -o "$filename"
        codium --install-extension "$filename"
        rm "$filename"
    done
    echo "External extensions have been installed successfully!"
}

install_regular_extensions() {
    for extension in "${extensions[@]}"; do
        codium --install-extension "$extension"
    done
    echo "Regular extensions have been installed successfully!"
}

if [[ $# -eq 0 ]]; then
    show_usage
elif [[ "$1" == "-e" || "$1" == "--external" ]]; then
    install_external_extensions
elif [[ "$1" == "-r" || "$1" == "--regular" ]]; then
    install_regular_extensions
elif [[ "$1" == "-a" || "$1" == "--all" ]]; then
    install_regular_extensions
    install_external_extensions
    echo "All extensions have been installed successfully!"
else
    show_usage
fi
