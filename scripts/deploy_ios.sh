#!/bin/bash

# TaskAtlas iOS Deployment Script
echo "🚀 Deploying TaskAtlas to iOS..."

# Check if running on macOS
if [[ "$OSTYPE" != "darwin"* ]]; then
    echo "❌ iOS deployment requires macOS"
    exit 1
fi

# Check if Xcode is installed
if ! command -v xcodebuild &> /dev/null; then
    echo "❌ Xcode is not installed. Please install Xcode from the App Store."
    exit 1
fi

# Build iOS app
echo "📦 Building iOS app..."
flutter build ios --release --no-codesign

# Check if build was successful
if [ $? -eq 0 ]; then
    echo "✅ iOS build successful!"
    
    # Create deployment directory
    DEPLOY_DIR="deploy/ios"
    mkdir -p $DEPLOY_DIR
    
    echo "🎉 iOS build ready!"
    echo "📂 Build files are in: build/ios/iphoneos"
    echo ""
    echo "📋 Next steps:"
    echo "1. Open the project in Xcode:"
    echo "   open ios/Runner.xcworkspace"
    echo ""
    echo "2. In Xcode:"
    echo "   - Select your team in Signing & Capabilities"
    echo "   - Update Bundle Identifier if needed"
    echo "   - Archive the project (Product > Archive)"
    echo "   - Upload to App Store Connect"
    echo ""
    echo "📱 For development testing:"
    echo "   flutter run -d ios"
    
else
    echo "❌ iOS build failed!"
    exit 1
fi
