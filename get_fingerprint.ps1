Write-Host "==========================================" -ForegroundColor Cyan
Write-Host "Android App Link - SHA-256 Fingerprint" -ForegroundColor Cyan
Write-Host "==========================================" -ForegroundColor Cyan
Write-Host ""

# Find keytool
$keytoolPaths = @(
    "C:\Program Files\Java\jdk-11\bin\keytool.exe",
    "C:\Program Files\Android\Android Studio\jbr\bin\keytool.exe"
)

$keytool = $null
foreach ($path in $keytoolPaths) {
    if (Test-Path $path) {
        $keytool = $path
        break
    }
}

if (-not $keytool) {
    # Try to find keytool
    Write-Host "Searching for keytool..." -ForegroundColor Yellow
    $found = Get-ChildItem -Path "C:\Program Files\Java" -Recurse -Filter "keytool.exe" -ErrorAction SilentlyContinue | Select-Object -First 1
    if ($found) {
        $keytool = $found.FullName
    }
}

if (-not $keytool) {
    Write-Host "ERROR: keytool not found!" -ForegroundColor Red
    Write-Host "Please install Java JDK or Android Studio" -ForegroundColor Red
    exit 1
}

Write-Host "Using keytool: $keytool" -ForegroundColor Gray
Write-Host ""

Write-Host "1. Debug Keystore Fingerprint (for development):" -ForegroundColor Yellow
Write-Host "-------------------------------------------"

$debugKeystore = "$env:USERPROFILE\.android\debug.keystore"

if (Test-Path $debugKeystore) {
    $output = & $keytool -list -v -keystore $debugKeystore -alias androiddebugkey -storepass android -keypass android 2>$null
    $sha256Line = $output | Select-String "SHA256:"
    if ($sha256Line) {
        $fingerprintWithColons = $sha256Line.ToString() -replace '.*SHA256:\s*', ''
        $fingerprint = $fingerprintWithColons -replace ':', ''
        
        Write-Host ""
        Write-Host "SHA256 (with colons):" -ForegroundColor Gray
        Write-Host $fingerprintWithColons -ForegroundColor White
        Write-Host ""
        Write-Host "SHA256 (for assetlinks.json):" -ForegroundColor Green
        Write-Host $fingerprint -ForegroundColor Green -BackgroundColor DarkGreen
        Write-Host ""
    } else {
        Write-Host "Could not extract SHA256 fingerprint" -ForegroundColor Red
    }
} else {
    Write-Host "Debug keystore not found at: $debugKeystore" -ForegroundColor Red
    Write-Host "Run your Flutter app once to generate it: flutter run" -ForegroundColor Yellow
}

Write-Host ""
Write-Host "==========================================" -ForegroundColor Cyan
Write-Host "Next steps:" -ForegroundColor Yellow
Write-Host "1. Copy the fingerprint above (without colons)"
Write-Host "2. Update web/.well-known/assetlinks.json"
Write-Host "3. Deploy to Vercel:"
Write-Host "   git add ."
Write-Host "   git commit -m 'Update assetlinks.json fingerprint'"
Write-Host "   git push"
Write-Host "4. Wait for Vercel deployment to complete"
Write-Host "5. Verify at: https://poke-kou.vercel.app/.well-known/assetlinks.json"
Write-Host "6. Build and test app:"
Write-Host "   flutter clean"
Write-Host "   flutter build apk --debug"
Write-Host "   flutter install"
Write-Host "7. Test deep link:"
Write-Host "   adb shell am start -a android.intent.action.VIEW -d 'https://poke-kou.vercel.app/pokemon/4'"
Write-Host "==========================================" -ForegroundColor Cyan

