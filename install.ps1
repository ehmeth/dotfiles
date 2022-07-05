# Install all essential tools for regular work and copy configuration files

# Chocolatey first
if ((Get-Command "choco" -ErrorAction SilentlyContinue) -eq $null) {
   # Taken form https://docs.chocolatey.org/en-us/choco/setup
   Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1')) 
}

# Now other essential tools
choco install 7zip ag git lightshot paint.net vim keepass putty python3 TotalCommander  -y

# Vim setup
$vimrc = "$env:USERPROFILE\_vimrc"
if (Test-Path $vimrc) {
   Copy-Item $vimrc -Destination "$vimrc.bak"
}
Copy-Item .\.vimrc -Destination $vimrc

# Install vim-plug: https://github.com/junegunn/vim-plug
iwr -useb https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim | ni "$env:USERPROFILE/vimfiles/autoload/plug.vim" -Force

# Install Source Code Pro: https://gist.github.com/anthonyeden/0088b07de8951403a643a8485af2709b
$fontDir = '.\font_temp'
git clone https://github.com/adobe-fonts/source-code-pro.git $fontDir

$Source      = "$fontDir\*"
$Destination = (New-Object -ComObject Shell.Application).Namespace(0x14)
$TempFolder  = "C:\Windows\Temp\Fonts"

New-Item $TempFolder -Type Directory -Force | Out-Null

Get-ChildItem -Path $Source -Include '*.otf' -Recurse | ForEach {
   If (-not(Test-Path "C:\Windows\Fonts\$($_.Name)")) {
      Write-Host "Installing font $($_.Name)"
         $Font = "$TempFolder\$($_.Name)"

         # Copy font to local temporary folder
         Copy-Item $($_.FullName) -Destination $TempFolder

         # Install font
         $Destination.CopyHere($Font,0x10)

         # Delete temporary copy of font
         Remove-Item $Font -Force
   } else {
      Write-Host "$($_.Name) already installed"
   }
}

Remove-Item -Recurse -Force $fontDir
