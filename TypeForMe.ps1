#
# Powershell script for Windows: TypeForMe.ps1
# MAR. 18, 2022, by Li-Ji Hong (洪李吉, hongliji@gmail.com)
# 
# After starting this script, it will go to next active window, and type for me, according to selected typing command text file.
#
# Typing command text file format's definition:
#
# Any line begin with '#' is a short pause (default 200ms)
# Windows special key strokes, refer to
# https://docs.microsoft.com/en-us/previous-versions/windows/it-pro/windows-powershell-1.0/ff731008(v=technet.10)?redirectedfrom=MSDN
# Others: type each printed characters.
#

param([string]$Filename=".\typing-commands.txt")

add-type -AssemblyName System.Windows.Forms

[System.Windows.Forms.SendKeys]::SendWait("%{TAB}")
Start-Sleep -milliseconds 100

$contents=Get-Content -encoding UTF8 $Filename

foreach ($line in $contents){

    if ($line -match '^#') {
        Start-Sleep -milliseconds 200
        continue
    }

    [System.Windows.Forms.SendKeys]::SendWait($line)
    [System.Windows.Forms.SendKeys]::SendWait("{ENTER}")
}
