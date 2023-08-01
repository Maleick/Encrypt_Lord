# Encrypt_Lord

This PowerShell script, Encrypt_Lord, is designed to test detection for file encryption in an enterprise environment. By emulating the file encryption process typically used in ransomware attacks, it assists in the evaluation and enhancement of security measures against such threats.

## Features

- Encrypts files from a specified source directory, writing the encrypted files to a specified destination directory.
- Utilizes AES encryption for high security.
- Allows users to specify their password for the encryption.
- Handles errors gracefully, printing out a message in the case of encryption failure.

## Usage

1. Clone the repository: `git clone https://github.com/YourGithubUsername/Encrypt_Lord.git`
2. Navigate to the downloaded folder: `cd Encrypt_Lord`
3. Open the `Encrypt_Lord.ps1` script using a text editor.
4. Modify the `$sourceFolder`, `$outputFolder`, and `$password` variables as needed.
5. Save your changes and close the text editor.
6. Open a PowerShell terminal and navigate to the script's directory.
7. Run the script: `./Encrypt_Lord.ps1`

## Disclaimer

This script is provided as is, without any warranty. It's intended for use in testing and improving security measures against ransomware. Do not use this script maliciously or without proper permissions.

## License

The Unlicense

## Author

Maleick (2023)
