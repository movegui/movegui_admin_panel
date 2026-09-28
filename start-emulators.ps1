# Starts the local Firebase emulators with the saved emulator data.
# Usage: .\start-emulators.ps1
#
# FUNCTIONS_DISCOVERY_TIMEOUT (seconds) raises the CLI's default 10s limit for
# loading the functions code, which a slow first start (antivirus scanning
# node_modules) can exceed.
# Auth is NOT emulated on purpose: the admin panel and the movegui client app
# share the production Firebase Auth users, so local functions read and write
# production Auth (using your `firebase login` credentials).

$env:FUNCTIONS_DISCOVERY_TIMEOUT = "60"

Set-Location $PSScriptRoot
firebase emulators:start --only firestore,storage,functions --import=./emulator-data --export-on-exit=./emulator-data
