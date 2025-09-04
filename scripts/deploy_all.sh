#!/bin/bash

# TaskAtlas Complete Deployment Script
echo "🚀 TaskAtlas - Complete Deployment Script"
echo "=========================================="

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to print colored output
print_status() {
    echo -e "${GREEN}✅ $1${NC}"
}

print_warning() {
    echo -e "${YELLOW}⚠️  $1${NC}"
}

print_error() {
    echo -e "${RED}❌ $1${NC}"
}

print_info() {
    echo -e "${BLUE}ℹ️  $1${NC}"
}

# Check if Flutter is installed
if ! command -v flutter &> /dev/null; then
    print_error "Flutter is not installed or not in PATH"
    exit 1
fi

# Get Flutter version
FLUTTER_VERSION=$(flutter --version | head -n 1)
print_info "Using $FLUTTER_VERSION"

# Check Flutter doctor
echo ""
print_info "Running Flutter doctor..."
flutter doctor

echo ""
print_info "Starting deployment process..."

# Create deployment directory
DEPLOY_DIR="deploy"
mkdir -p $DEPLOY_DIR

# 1. Web Deployment
echo ""
print_info "Building for Web..."
flutter build web --release
if [ $? -eq 0 ]; then
    print_status "Web build successful!"
    mkdir -p $DEPLOY_DIR/web
    cp -r build/web/* $DEPLOY_DIR/web/
    print_status "Web files copied to $DEPLOY_DIR/web"
else
    print_error "Web build failed!"
    exit 1
fi

# 2. Android Deployment
echo ""
print_info "Building for Android..."
flutter build apk --release
if [ $? -eq 0 ]; then
    print_status "Android APK build successful!"
    mkdir -p $DEPLOY_DIR/android
    cp build/app/outputs/flutter-apk/app-release.apk $DEPLOY_DIR/android/
    
    # Try to build App Bundle
    flutter build appbundle --release
    if [ $? -eq 0 ]; then
        print_status "Android App Bundle build successful!"
        cp build/app/outputs/bundle/release/app-release.aab $DEPLOY_DIR/android/
    else
        print_warning "Android App Bundle build failed (APK still available)"
    fi
else
    print_error "Android build failed!"
fi

# 3. iOS Deployment (macOS only)
if [[ "$OSTYPE" == "darwin"* ]]; then
    echo ""
    print_info "Building for iOS..."
    
    # Check if Xcode is available
    if command -v xcodebuild &> /dev/null; then
        flutter build ios --release --no-codesign
        if [ $? -eq 0 ]; then
            print_status "iOS build successful!"
            mkdir -p $DEPLOY_DIR/ios
            print_status "iOS build files are in build/ios/iphoneos"
            print_info "Open ios/Runner.xcworkspace in Xcode to archive and upload"
        else
            print_error "iOS build failed!"
        fi
    else
        print_warning "Xcode not found. iOS build skipped."
        print_info "Install Xcode from App Store to build for iOS"
    fi
else
    print_warning "iOS deployment skipped (requires macOS)"
fi

# 4. Desktop Deployment
echo ""
print_info "Building for Desktop..."

# macOS
if [[ "$OSTYPE" == "darwin"* ]]; then
    flutter build macos --release
    if [ $? -eq 0 ]; then
        print_status "macOS build successful!"
        mkdir -p $DEPLOY_DIR/macos
        cp -r build/macos/Build/Products/Release/ $DEPLOY_DIR/macos/
    else
        print_warning "macOS build failed"
    fi
fi

# Linux
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    flutter build linux --release
    if [ $? -eq 0 ]; then
        print_status "Linux build successful!"
        mkdir -p $DEPLOY_DIR/linux
        cp -r build/linux/x64/release/bundle/ $DEPLOY_DIR/linux/
    else
        print_warning "Linux build failed"
    fi
fi

# Windows
if [[ "$OSTYPE" == "msys" ]] || [[ "$OSTYPE" == "cygwin" ]]; then
    flutter build windows --release
    if [ $? -eq 0 ]; then
        print_status "Windows build successful!"
        mkdir -p $DEPLOY_DIR/windows
        cp -r build/windows/runner/Release/ $DEPLOY_DIR/windows/
    else
        print_warning "Windows build failed"
    fi
fi

# Summary
echo ""
echo "🎉 Deployment Complete!"
echo "======================"
echo "📂 All build files are in: $DEPLOY_DIR"
echo ""

# Show what was built
echo "📋 Build Summary:"
if [ -d "$DEPLOY_DIR/web" ]; then
    echo "  🌐 Web: $DEPLOY_DIR/web"
fi
if [ -d "$DEPLOY_DIR/android" ]; then
    echo "  📱 Android: $DEPLOY_DIR/android"
fi
if [ -d "$DEPLOY_DIR/ios" ]; then
    echo "  🍎 iOS: $DEPLOY_DIR/ios"
fi
if [ -d "$DEPLOY_DIR/macos" ]; then
    echo "  💻 macOS: $DEPLOY_DIR/macos"
fi
if [ -d "$DEPLOY_DIR/linux" ]; then
    echo "  🐧 Linux: $DEPLOY_DIR/linux"
fi
if [ -d "$DEPLOY_DIR/windows" ]; then
    echo "  🪟 Windows: $DEPLOY_DIR/windows"
fi

echo ""
echo "🚀 Next Steps:"
echo "  1. Web: Upload web/ folder to your hosting service"
echo "  2. Android: Upload .aab to Google Play Console"
echo "  3. iOS: Archive in Xcode and upload to App Store Connect"
echo "  4. Desktop: Distribute the built executables"

echo ""
print_status "TaskAtlas is ready for deployment! 🎊"
