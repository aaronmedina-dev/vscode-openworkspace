# [VS-OW] VSCode OpenWorkspace v1.0

Aaron Medina | [GitHub](https://github.com/aaronmedina-dev) | [Linkedin](https://www.linkedin.com/in/aamedina/)

## VSCode Workspace Selector

For developers who prefer to have Visual Studio Code focused on a single project at a time, this tool can be incredibly useful. It ensures that only files related to your current work are visible, avoiding distractions from unrelated projects. As you add new projects to the configured workspaces in the configuration file, the tool dynamically includes them as options, streamlining your workflow.

While there are extensions available for Visual Studio Code that provide robust project management features, this script offers a unique approach. By dynamically loading workspace configurations from a configuration file and listing all subdirectories in the configured workspaces, it ensures that only files related to your current work are visible. This minimizes distractions and keeps your focus on the task at hand.

## Features

- Dynamically loads workspace configurations from a configuration file.
- Lists all subdirectories in the configured workspaces.
- Provides a simple terminal-based selection interface.
- Opens the selected folder in Visual Studio Code.

## Prerequisites

- **Bash**: Ensure you have a Bash shell environment available.
- **Visual Studio Code**: Make sure VS Code is installed and available in your system's PATH.
- **Configuration File**: A configuration file named `vscode_openworkspaces.conf` must be placed in the same directory as the script.

## Configuration File Format

The configuration file should be in a JSON-like format. Each key-value pair represents a workspace name and its corresponding directory path.

```plaintext
{
  "Workspace1": "~/path/to/workspace1",
  "Workspace2": "~/path/to/workspace2"
}
```

- Replace `~/path/to/workspace1` and `~/path/to/workspace2` with the absolute or relative paths to your workspace directories.
- Use the tilde (`~`) to denote the home directory.

## Usage

1. Clone or copy the script to a directory of your choice.
2. Ensure the script is executable:
   ```bash
   chmod +x vs-openworkspace.sh
   ```
3. Run the script from the terminal:
   ```bash
   ./vs-openworkspace.sh
   ```
4. Follow the on-screen prompts to select a folder from the available options.
5. The selected folder will be opened in Visual Studio Code.

## Example Workflow

1. The script will load the workspace configuration file and display the available folders:

   ```plaintext
   Select a folder from Workspace1 (/path/to/workspace1):
   [1] Project1
   [2] Project2

   Select a folder from Workspace2 (/path/to/workspace2):
   [3] ProjectA
   [4] ProjectB
   ```

2. Enter the number corresponding to the folder you wish to open. For example, entering `2` will open `Project2` in VS Code.

3. The script validates your input and opens the selected folder:

   ```plaintext
   Opening folder: /path/to/workspace1/Project2 from workspace Workspace1
   ```

## Error Handling

- If the configuration file is missing or malformed, the script will terminate with an error message.
- If no folders are found in the configured workspaces, the script will notify you and exit.
- Invalid input during folder selection will prompt an appropriate error message and exit the script.

## Customization

- **Colors**: The script uses ANSI color codes to enhance readability. You can modify the color codes by changing the variables defined in the script (`RED`, `GREEN`, `BLUE`, etc.).
- **Workspace Configuration**: Update `vscode_openworkspaces.conf` to add or modify workspaces.

## Troubleshooting

- **VS Code Command Not Found**: Ensure `code` is available in your system PATH. Refer to [VS Code documentation](https://code.visualstudio.com/docs/setup/mac#_launching-from-the-command-line) for instructions.
- **Directory Permissions**: Verify that the script has read permissions for the workspace directories.

## License

This script is distributed under the MIT License. Feel free to use, modify, and distribute it as needed.

