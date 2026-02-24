# Family Health & Kids Growth Tracker

A complete Flutter production app for tracking family health and child growth.

## 🏗️ Architecture
- **Clean Architecture** with Feature-based folder structure
- **GetX** for State Management, Routing, and Dependency Injection
- **Firebase** for Auth, Firestore, Storage, Messaging, Functions

## 🚀 Quick Start

### 1. Prerequisites
```bash
flutter --version   # Requires Flutter 3.x+
dart --version      # Requires Dart 3.x+
```

### 2. Install Dependencies
```bash
flutter pub get
```

### 3. Configure Firebase

**Option A - FlutterFire CLI (Recommended):**
```bash
dart pub global activate flutterfire_cli
flutterfire configure
```

**Option B - Manual:**
- Create a Firebase project at https://console.firebase.google.com
- Enable Authentication (Email/Password, Google)
- Enable Cloud Firestore
- Enable Firebase Storage
- Enable Firebase Cloud Messaging
- Download `google-services.json` → `android/app/`
- Download `GoogleService-Info.plist` → `ios/Runner/`
- Update `lib/firebase_options.dart` with your config values

### 4. Configure AdMob
- Create an AdMob account at https://admob.google.com
- Create a new app, get your App ID
- Replace the test IDs in:
  - `android/app/src/main/AndroidManifest.xml` - `com.google.android.gms.ads.APPLICATION_ID`
  - `ios/Runner/Info.plist` - `GADApplicationIdentifier`
  - `lib/core/constants/app_constants.dart` - `bannerAdUnitId`, `nativeAdUnitId`

### 5. Configure In-App Purchases
- Set up products in Google Play Console and Apple App Store Connect
- Product IDs: `family_health_premium_monthly` and `family_health_premium_yearly`
- Update `lib/core/constants/app_constants.dart` if using different IDs

### 6. Add Assets
Place the following in `assets/`:
```
assets/
  images/     - App images
  icons/      - App icons  
  animations/ - Lottie JSON files
  fonts/      - Poppins font files (download from Google Fonts)
```

Download Poppins from: https://fonts.google.com/specimen/Poppins
Extract: Regular (400), Medium (500), SemiBold (600), Bold (700)

### 7. Run the App
```bash
# Android
flutter run --debug

# iOS (requires Xcode and macOS)
flutter run --debug --target-platform darwin-arm64

# Release build
flutter build apk --release
flutter build ipa --release
```

## 📁 Project Structure

```
lib/
├── core/
│   ├── constants/     - AppColors, AppConstants
│   ├── theme/         - AppTheme (light & dark)
│   ├── routes/        - AppPages, Routes
│   ├── bindings/      - GetX DI bindings
│   ├── services/      - AdService, NotificationService, StorageService
│   └── widgets/       - Reusable UI components
└── features/
    ├── auth/          - Login, Signup, Forgot Password
    ├── onboarding/    - 4-slide onboarding flow
    ├── dashboard/     - Home screen with child cards
    ├── child/         - Child profile CRUD
    ├── growth/        - Growth tracking with fl_chart
    ├── sleep/         - Sleep timeline tracker
    ├── activities/    - Activity & routine logs
    ├── medical/       - Medical history, vaccines, documents
    ├── ai_insights/   - Chat-based AI health assistant
    ├── reports/       - PDF export (premium)
    ├── subscription/  - Paywall + IAP integration
    ├── settings/      - User preferences, logout
    └── notifications/ - Push notification history
```

## 🔥 Firebase Collections Structure

```
users/{uid}
  - email, displayName, photoUrl
  - isPremium, subscriptionPlan, subscriptionExpiry

children/{childId}
  - name, dateOfBirth, gender, bloodGroup
  - photoUrl, allergies, notes, userId

growth_records/{recordId}
  - childId, weight, height, headCircumference
  - recordedAt, notes

sleep_records/{recordId}
  - childId, startTime, endTime, quality, notes

medical_records/{recordId}
  - childId, type, doctor, reason, date, notes
```

## 💰 Monetization

### Free Tier
- 1 child profile
- Basic growth & sleep tracking
- Banner ads via AdMob

### Premium (\$4.99/mo or \$29.99/yr)
- Unlimited children
- AI health insights
- PDF report export
- Advanced charts
- No ads

## 🧪 Testing
```bash
flutter test                    # Run all tests
flutter test --coverage         # With coverage
```

## 🔒 Security
- Firestore rules in `firestore.rules` - deploy with `firebase deploy --only firestore:rules`
- All user data is scoped by `userId`
- Premium features validated server-side via Firestore

## 📱 Supported Platforms
- Android (minSdk 23 / Android 6.0+)
- iOS (iOS 12+)
