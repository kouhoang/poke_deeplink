#!/bin/bash

echo "=========================================="
echo "Android App Link - SHA-256 Fingerprint"
echo "=========================================="
echo ""

echo "1. Debug Keystore Fingerprint (for development):"
echo "-------------------------------------------"
keytool -list -v -keystore ~/.android/debug.keystore -alias androiddebugkey -storepass android -keypass android 2>/dev/null | grep "SHA256:" | sed 's/.*SHA256: //' | tr -d ':'

echo ""
echo ""
echo "Copy the fingerprint above (without colons) and paste it into:"
echo "  web/.well-known/assetlinks.json"
echo ""
echo "=========================================="
echo ""

# Check if release keystore exists
if [ -f ~/poke-release-key.jks ]; then
    echo "2. Release Keystore Fingerprint (for production):"
    echo "-------------------------------------------"
    echo "Enter your release keystore password:"
    keytool -list -v -keystore ~/poke-release-key.jks -alias poke-key 2>/dev/null | grep "SHA256:" | sed 's/.*SHA256: //' | tr -d ':'
    echo ""
fi

echo "=========================================="
echo "Next steps:"
echo "1. Copy the fingerprint above"
echo "2. Update web/.well-known/assetlinks.json"
echo "3. Update android/app/src/main/AndroidManifest.xml with your Vercel domain"
echo "4. Deploy to Vercel"
echo "=========================================="
