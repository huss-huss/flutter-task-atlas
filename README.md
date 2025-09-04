# TaskAtlas - Offline-first Tasks, Notes & Habits

A comprehensive Flutter app that demonstrates all core Flutter concepts through a practical, offline-first productivity application.

## 🚀 Features

### MVP (Weeks 1-2)
- ✅ **Navigation & Deep Linking**: Bottom-tab shell with nested stacks using go_router
- ✅ **State Management**: Riverpod for testable, modular state management
- ✅ **Local Database**: Drift (SQLite) for robust offline data persistence
- ✅ **CRUD Operations**: Full task, note, and habit management with validation
- ✅ **Material 3 Theming**: Modern UI with light/dark mode support
- ✅ **Search & Filtering**: Advanced search and tag-based filtering
- ✅ **Responsive Design**: Beautiful UI that works on all screen sizes

### Plus (Week 3)
- 🔄 **Background Sync**: Periodic sync with Firestore when online
- 📍 **Geo-reminders**: Location-based notifications (optional)
- 🔔 **Smart Notifications**: Intelligent reminder scheduling

### Pro (Week 4)
- 📱 **Push Notifications**: FCM for habit streak nudges
- 🚀 **CI/CD**: GitHub Actions for automated testing and deployment
- 🌍 **Internationalization**: Multi-language support

## 🏗️ Architecture

```
lib/
├── app/                    # App configuration
│   ├── app.dart           # Main app widget
│   ├── router.dart        # Navigation configuration
│   └── theme.dart         # Material 3 theming
├── core/                   # Core functionality
│   ├── models/            # Data models (Freezed)
│   └── providers/         # Riverpod providers
├── features/               # Feature modules
│   ├── home/              # Home dashboard
│   ├── tasks/             # Task management
│   ├── notes/             # Note taking
│   ├── habits/            # Habit tracking
│   └── profile/           # User profile & settings
├── data/                   # Data layer
│   ├── local/             # Drift database & DAOs
│   ├── remote/            # Firestore & API clients
│   └── sync/              # Sync queue & conflict resolution
└── l10n/                  # Internationalization
```

## 🛠️ Tech Stack

- **Framework**: Flutter 3.0+
- **State Management**: Riverpod
- **Navigation**: go_router
- **Database**: Drift (SQLite)
- **Cloud Sync**: Firestore
- **Serialization**: Freezed + json_serializable
- **Background Work**: workmanager
- **Notifications**: flutter_local_notifications
- **Device Features**: camera, geolocator, permission_handler
- **Testing**: flutter_test, integration_test, mocktail
- **CI/CD**: GitHub Actions

## 📱 Screenshots

*Coming soon - app screenshots will be added here*

## 🚀 Getting Started

### Prerequisites

- Flutter SDK 3.0.0 or higher
- Dart SDK 3.0.0 or higher
- Android Studio / VS Code
- iOS Simulator / Android Emulator

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/yourusername/flutter-task-atlas.git
   cd flutter-task-atlas
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Generate code**
   ```bash
   flutter packages pub run build_runner build
   ```

4. **Run the app**
   ```bash
   flutter run
   ```

### Platform Setup

#### Android
- Ensure you have Android SDK installed
- The app will request necessary permissions at runtime

#### iOS
- Ensure you have Xcode installed
- The app will request necessary permissions at runtime

## 📊 Data Models

### Task
```dart
class Task {
  final String id;
  final String title;
  final String? noteId;
  final DateTime? dueAt;
  final bool isDone;
  final List<String> tags;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool isSynced;
}
```

### Note
```dart
class Note {
  final String id;
  final String title;
  final String content;
  final List<String> tags;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool isSynced;
}
```

### Habit
```dart
class Habit {
  final String id;
  final String name;
  final HabitCadence cadence;
  final int streak;
  final DateTime? lastTickAt;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool isSynced;
}
```

## 🔧 Configuration

### Environment Variables
Create a `.env` file in the root directory:
```env
FIREBASE_PROJECT_ID=your-project-id
FIREBASE_API_KEY=your-api-key
```

### Firebase Setup
1. Create a new Firebase project
2. Enable Firestore Database
3. Add your app to Firebase
4. Download and add configuration files

## 🧪 Testing

### Unit Tests
```bash
flutter test
```

### Widget Tests
```bash
flutter test test/widget_test/
```

### Integration Tests
```bash
flutter test integration_test/
```

## 📦 Building

### Android APK
```bash
flutter build apk --release
```

### iOS Archive
```bash
flutter build ios --release
```

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📝 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- Flutter team for the amazing framework
- Riverpod for excellent state management
- Drift for robust database operations
- The Flutter community for inspiration and support

## 📞 Support

If you have any questions or need help:
- Open an issue on GitHub
- Check the Flutter documentation
- Join the Flutter community on Discord

---

**Happy coding! 🎉**

This project demonstrates how to build a production-ready Flutter app with all the core concepts you'll need for any future Flutter project.