# 🚀 TaskAtlas Deployment Guide

This guide will help you deploy TaskAtlas to all platforms: Web, Android, iOS, and Desktop.

## 📋 Prerequisites

- Flutter 3.29.3+ installed
- Git repository cloned
- All dependencies installed (`flutter pub get`)

## 🎯 Quick Deployment

### Option 1: Deploy All Platforms (Recommended)
```bash
# Make scripts executable (first time only)
chmod +x scripts/*.sh

# Deploy to all platforms
./scripts/deploy_all.sh
```

### Option 2: Deploy Individual Platforms
```bash
# Web only
./scripts/deploy_web.sh

# Android only
./scripts/deploy_android.sh

# iOS only (macOS only)
./scripts/deploy_ios.sh
```

## 🌐 Web Deployment

### Build for Web
```bash
flutter build web --release --web-renderer html
```

### Deploy to Hosting Services

#### Netlify
1. Build the app: `flutter build web --release`
2. Drag `build/web` folder to Netlify
3. Configure custom domain (optional)

#### Vercel
1. Install Vercel CLI: `npm i -g vercel`
2. Build the app: `flutter build web --release`
3. Deploy: `vercel build/web`

#### Firebase Hosting
1. Install Firebase CLI: `npm install -g firebase-tools`
2. Login: `firebase login`
3. Initialize: `firebase init hosting`
4. Build: `flutter build web --release`
5. Deploy: `firebase deploy`

#### GitHub Pages
1. Build: `flutter build web --release`
2. Push `build/web` contents to `gh-pages` branch
3. Enable GitHub Pages in repository settings

## 📱 Android Deployment

### Build APK (for direct installation)
```bash
flutter build apk --release
```
**Output**: `build/app/outputs/flutter-apk/app-release.apk`

### Build App Bundle (for Play Store)
```bash
flutter build appbundle --release
```
**Output**: `build/app/outputs/bundle/release/app-release.aab`

### Deploy to Google Play Store

1. **Create Developer Account**
   - Go to [Google Play Console](https://play.google.com/console)
   - Pay $25 one-time fee
   - Complete account setup

2. **Upload App Bundle**
   - Create new app in Play Console
   - Upload `.aab` file
   - Fill in store listing details
   - Set up pricing and distribution
   - Submit for review

3. **Testing**
   - Use internal testing track for initial testing
   - Use closed testing for beta users
   - Use open testing for public beta

### Direct APK Distribution
- Share APK file directly with users
- Host APK on your website
- Use services like Firebase App Distribution

## 🍎 iOS Deployment

### Prerequisites
- macOS computer
- Xcode installed
- Apple Developer Account ($99/year)

### Build for iOS
```bash
flutter build ios --release --no-codesign
```

### Deploy to App Store

1. **Open in Xcode**
   ```bash
   open ios/Runner.xcworkspace
   ```

2. **Configure Signing**
   - Select your team in Signing & Capabilities
   - Update Bundle Identifier if needed
   - Ensure provisioning profiles are set up

3. **Archive and Upload**
   - Product → Archive
   - Click "Distribute App"
   - Choose "App Store Connect"
   - Follow upload process

4. **App Store Connect**
   - Fill in app information
   - Upload screenshots and metadata
   - Submit for review

### TestFlight Distribution
- Upload build to App Store Connect
- Create TestFlight build
- Invite testers via email
- Test on real devices

## 💻 Desktop Deployment

### macOS
```bash
flutter build macos --release
```
**Output**: `build/macos/Build/Products/Release/`

### Linux
```bash
flutter build linux --release
```
**Output**: `build/linux/x64/release/bundle/`

### Windows
```bash
flutter build windows --release
```
**Output**: `build/windows/runner/Release/`

### Distribution Options
- **Direct**: Share executable files
- **DMG (macOS)**: Create disk image
- **Deb/RPM (Linux)**: Create packages
- **MSI (Windows)**: Create installer

## 🔧 Configuration

### App Icons
Update icons in:
- `android/app/src/main/res/` (Android)
- `ios/Runner/Assets.xcassets/` (iOS)
- `web/icons/` (Web)

### App Name
Update in:
- `android/app/src/main/AndroidManifest.xml`
- `ios/Runner/Info.plist`
- `web/manifest.json`

### Version
Update in `pubspec.yaml`:
```yaml
version: 1.0.0+1  # Format: version_name+version_code
```

## 📊 Monitoring & Analytics

### Firebase Analytics
1. Add Firebase to your project
2. Configure analytics in app
3. Monitor user behavior and crashes

### Crashlytics
1. Set up Firebase Crashlytics
2. Get crash reports and stack traces
3. Monitor app stability

## 🚨 Common Issues

### Build Failures
- Check Flutter version compatibility
- Ensure all dependencies are resolved
- Clean build: `flutter clean && flutter pub get`

### Signing Issues (iOS/Android)
- Verify certificates and provisioning profiles
- Check team selection in Xcode
- Ensure bundle identifier is unique

### Web Build Issues
- Clear browser cache
- Check for JavaScript errors in console
- Verify web renderer compatibility

## 📈 Post-Deployment

### Monitor Performance
- Use Firebase Performance Monitoring
- Monitor crash reports
- Track user engagement

### Update Strategy
- Plan regular update cycles
- Test updates thoroughly
- Use staged rollouts

### User Feedback
- Monitor app store reviews
- Collect user feedback
- Respond to user issues promptly

## 🎉 Success Checklist

- [ ] App builds successfully for all platforms
- [ ] App runs without crashes
- [ ] All features work as expected
- [ ] App store listings are complete
- [ ] Privacy policy and terms of service are ready
- [ ] Support contact information is provided
- [ ] App is tested on real devices
- [ ] Analytics and monitoring are set up

## 📞 Support

If you encounter issues during deployment:

1. Check Flutter documentation
2. Review platform-specific guides
3. Check GitHub issues for similar problems
4. Ask for help in Flutter community forums

---

**Happy Deploying! 🚀**

Your TaskAtlas app is ready to help users around the world stay productive!
