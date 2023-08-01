# Author: Maleick
# Date: 8/1/23
# Script: Encrypt_Lord.ps1

# Set the script version
$scriptVersion = "1.0"

# ASCII Art
Write-Host @"
___________                                        __       .____                       .___ 
\_   _____/  ____    ____ _______  ___.__.______ _/  |_     |    |     ____ _______   __| _/ 
 |    __)_  /    \ _/ ___\\_  __ \<   |  |\____ \\   __\    |    |    /  _ \\_  __ \ / __ |  
 |        \|   |  \\  \___ |  | \/ \___  ||  |_> >|  |      |    |___(  <_> )|  | \// /_/ |  
/_______  /|___|  / \___  >|__|    / ____||   __/ |__|      |_______ \\____/ |__|   \____ |  
        \/      \/      \/         \/     |__|                      \/                   \/  
                                                                                              
"@
Write-Host "Running script version $scriptVersion..."
Write-Host "`n"

$sourceFolder = "C:\source"
$outputFolder = "C:\destination"
$password = "Pass123!"

# Create a byte array for the password
$PasswordBytes = [System.Text.Encoding]::UTF8.GetBytes($password)
$PasswordBytes = [System.Security.Cryptography.SHA256]::Create().ComputeHash($PasswordBytes)

# Create the output folder if it doesn't exist
if (-not (Test-Path -Path $outputFolder)) {
    New-Item -Path $outputFolder -ItemType Directory | Out-Null
}

# Get all files in the source folder
$files = Get-ChildItem -Path $sourceFolder -File

foreach ($file in $files) {
    $outputFile = Join-Path -Path $outputFolder -ChildPath ($file.Name + ".encrypted")
    try {
        # Encrypt the file
        Write-Host "Encrypting file: $($file.FullName)"

        $AesObject = New-Object System.Security.Cryptography.AesCryptoServiceProvider
        $AesObject.Key = $PasswordBytes
        $AesObject.IV = $PasswordBytes[0..15]  # Use the first 16 bytes of the password as the IV

        $Encryptor = $AesObject.CreateEncryptor()
        
        $fsInput = New-Object System.IO.FileStream $file.FullName, 'Open', 'Read'
        $fsEncrypted = New-Object System.IO.FileStream $outputFile, 'Create', 'Write'
        $cs = New-Object System.Security.Cryptography.CryptoStream $fsEncrypted, $Encryptor, 'Write'
        
        [byte[]]$buffer = New-Object byte[](4096)
        $readCount = $fsInput.Read($buffer, 0, 4096)

        while ($readCount -gt 0) {
            $cs.Write($buffer, 0, $readCount)
            $readCount = $fsInput.Read($buffer, 0, 4096)
        }

        $fsInput.Close()
        $cs.Close()
        $fsEncrypted.Close()

        Write-Host "Encrypted file: $outputFile"
    }
    catch {
        Write-Host "Failed to encrypt file: $($file.Name)"
        Write-Host "Error: $($_.Exception.Message)"
    }
}

Write-Host "Encryption complete."
