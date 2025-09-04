#!/bin/bash

# TaskAtlas Android Deployment Script
echo "🚀 Deploying TaskAtlas to Android..."

# Build APK
echo "📦 Building APK..."
flutter build apk --release

# Check if APK build was successful
if [ $? -eq 0 ]; then
    echo "✅ APK build successful!"
    
    # Build App Bundle (for Play Store)
    echo "📦 Building App Bundle..."
    flutter build appbundle --release
    
    if [ $? -eq 0 ]; then
        echo "✅ App Bundle build successful!"
        
        # Create deployment directory
        DEPLOY_DIR="deploy/android"
        mkdir -p $DEPLOY_DIR
        
        # Copy built files
        echo "📁 Copying built files..."
        cp build/app/outputs/flutter-apk/app-release.apk $DEPLOY_DIR/
        cp build/app/outputs/bundle/release/app-release.aab $DEPLOY_DIR/
        
        echo "🎉 Android deployment ready!"
        echo "📂 Files are in: $DEPLOY_DIR"
        echo ""
        echo "📋 Next steps:"
        echo "1. APK (app-release.apk): Install directly on Android devices"
        echo "2. App Bundle (app-release.aab): Upload to Google Play Console"
        echo ""
        echo "📱 To install APK on device:"
        echo "   adb install $DEPLOY_DIR/app-release.apk"
        
    else
        echo "❌ App Bundle build failed!"
        exit 1
    fi
    
else
    echo "❌ APK build failed!"
    exit 1
fi
