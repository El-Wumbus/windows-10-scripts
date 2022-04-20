<!--
Author: Aidan Neal <squidwardnose4507@gmail.com>
Maintainer: Aidan Neal 
Contact: https://discord.gg/8wBUFeGGYC (Discord)
License: (MIT)
-->

# Windows 10 Scripts

*CLI Programs to make windows a little more useable.*

## Installation

- Download latest release for your OS from the [releases page](https://github.com/El-Wumbus/windows-10-scripts/releases)

### File hashes

#### windows-10-scripts.setup.exe
md5: `fdcc227786ce2096b22d1fed493c1605`  
sha1: `5cfc74c4bd33f115511a52ed421540b9c4c49a8e`  
sha256: `8c6347cee48bf28017164a6bfafcbf95026f5c8577784b86fdea6d6745893906`  
sha512: `47c3988fe04098fd623fe58168151d3c9cf80bc52d40ba758721290a66e8c43e2e79c00052b1776a9294756ad909c88b2806c82865f50ec7e30ea075f007e24b`  

- Add the installation directory [installdir\bin] to PATH. The defualt installdir is `C:\Program Files (x86)\Windows-10-scripts`. This means you'd add `C:\Program Files (x86)\Windows-10-scripts\bin` to your path. For more information on this see [add-a-directory-to-path-environment-variable-in-windows-10](https://www.c-sharpcorner.com/article/add-a-directory-to-path-environment-variable-in-windows-10/)

## Tools

- `Remove-Empty` - Recursively delete empty directories.
- `Hello-World` - Prints 'Hello World'.
- `yes` - Just like the gnu tool, this program prints 'y' forever.
- `Touch-File` - A windows alternative for the gnu program `touch`.
- `Random-Number` - Print random numbers based on a seed that you provide.
- `Measure-InternetSpeed` - Simplified speedtest written in python.
- `Generate-Name` - Generate a random name.
- `Echo-Input` - A recreation of echo for no particular reason.
- `Get-File` - Like wget, but with way fewer features, it downloads a file using http/https.

## Usage

For help with usage, use the -h flag with most of the above commands.
