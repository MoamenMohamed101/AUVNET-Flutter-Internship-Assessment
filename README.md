# 🌟 AUVNET Flutter Internship Assessment

This project — **Nawel** — is a food-related mobile application built using **Flutter**. It demonstrates best practices in app architecture, state management, local caching, and Firebase integration. This project was developed as part of the **AUVNET Flutter Internship Assessment**.

---

## 🚀 Project Setup & Installation

### ✅ Prerequisites

- [Flutter SDK](https://flutter.dev/docs/get-started/install)
- Dart SDK
- Android Studio or Visual Studio Code
- Firebase Project (with Firestore and Email/Password Auth enabled)

### 🛠 Steps

1. **Clone the Repository**

   ```bash
   git clone https://github.com/your-username/AUVNET-Flutter-Internship-Assessment.git
   cd AUVNET-Flutter-Internship-Assessment
   
2. **Install Dependencies**

   - Install all Flutter packages:
     ```bash
     flutter pub get
     ```

   - Generate Hive type adapters (if you have any models with `@HiveType`):
     ```bash
     flutter packages pub run build_runner build
     ```
3. **Add Firebase Config Files**

   - Download `google-services.json` from your Firebase Console and place it in:
     ```
     android/app/google-services.json
     ```

   - Download `GoogleService-Info.plist` from your Firebase Console and place it in:
     ```
     ios/Runner/GoogleService-Info.plist
     ```
 4. **Initialize Hive & Firebase in `main.dart`**

   Make sure `main()` in your `main.dart` file looks something like this:

   ```dart
   void main() async {
     WidgetsFlutterBinding.ensureInitialized();
     await Firebase.initializeApp(
       options: DefaultFirebaseOptions.currentPlatform,
     );
     await Hive.initFlutter();
     await Hive.openBox('settings');
     runApp(MyApp());
   }

## 🧱 Architectural Overview

This project follows the **Clean Architecture** approach with the following structure:

lib/
│
├── app/ → App entry point, themes, constants, routes
│
├── data/ → Data layer (Firebase service, Hive, DTOs, models)
│ ├── models/ → App data models (e.g., ServiceModel, RestaurantModel)
│ ├── data_sources/ → Firestore services, Hive local services
│ └── repository/ → Repository implementation (calls use cases)
│
├── domain/ → Business logic layer
│ ├── entities/ → Core business entities (optional)
│ ├── repository/ → Abstract repository interfaces
│ └── usecases/ → Application use cases (e.g., LoginUseCase, GetServicesUseCase)
│
├── presentation/ → UI layer
│ ├── views/ → Screens like SplashView, LoginView, OnboardingView
│ ├── blocs/ → BLoC logic (LoginBloc, OnboardingBloc, etc.)
│ ├── widgets/ → Reusable widgets
│ └── routes/ → GoRouter or Navigator setup
│
└── main.dart → App initialization and entry point
