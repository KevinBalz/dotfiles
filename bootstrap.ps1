Clear-Host
$DirAtStart = Get-Location

Set-Location $PSScriptRoot
Write-Output "Downloading ruby.7z"
Invoke-WebRequest http://dl.bintray.com/oneclick/rubyinstaller/ruby-2.3.3-x64-mingw32.7z -OutFile ruby.7z
7z x ruby.7z

if(Test-Path -Path .ruby ) {
  Remove-Item -Recurse -Force .ruby
}
Rename-Item -path ruby-2.3.3-x64-mingw32 -newName .ruby

Remove-Item ruby.7z

$env:DOTFILES = $PSScriptRoot
./bin/bin/dotruby.ps1 bin/bin/dotfiles setup

Set-Location $DirAtStart
