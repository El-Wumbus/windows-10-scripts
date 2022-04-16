<!--
Author: Aidan Neal <squidwardnose4507@gmail.com>
Maintainer: Aidan Neal 
Contact: https://discord.gg/8wBUFeGGYC (Discord)
-->

# Windows 10 Scripts

*Shell scripts to make windows semi-useable*

> Some powershell scripts are cross platform.

## Installation

```powershell
git clone 'https://github.com/el-wumbus/windows-10-scripts'
cd '.\windows-10-scripts\src\bin' # Use a forwardslash `/` for unix-like operating systems [Linux, MacOS, BSD, etc...]
cp .\* [Any directory in $PATH] # Copy the files to somewhere in your $PATH or just run them from here
```

## Tools

- `Remove-Empty` - Recursively delete empty directoriess.

## Usage

### `Remove-Empty`

```powershell
Remove-Empty [Directory]
```
example

```powershell
Remove-Empty C:\Users
```
