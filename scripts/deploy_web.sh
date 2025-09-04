#!/bin/bash

# TaskAtlas Web Deployment Script
echo "🚀 Deploying TaskAtlas to Web..."

# Build the web app
echo "📦 Building web app..."
flutter build web --release

# Check if build was successful
if [ $? -eq 0 ]; then
    echo "✅ Web build successful!"
    
    # Create deployment directory
    DEPLOY_DIR="deploy/web"
    mkdir -p $DEPLOY_DIR
    
    # Copy built files
    echo "📁 Copying built files..."
    cp -r build/web/* $DEPLOY_DIR/
    
    echo "🎉 Web deployment ready!"
    echo "📂 Files are in: $DEPLOY_DIR"
    echo "🌐 You can now upload these files to your web hosting service"
    echo ""
    echo "📋 Next steps:"
    echo "1. Upload contents of $DEPLOY_DIR to your web server"
    echo "2. Configure your domain to point to the uploaded files"
    echo "3. Test the app at your domain"
    
else
    echo "❌ Web build failed!"
    exit 1
fi
