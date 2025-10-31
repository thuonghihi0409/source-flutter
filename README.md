## Starter Base App (Flutter) — Hướng dẫn sử dụng (Tiếng Việt)

Base này giúp bạn khởi tạo dự án Flutter nhanh, theo Clean Architecture, có sẵn router, DI, BLoC, đa ngôn ngữ, HTTP service, UI common, và flow Splash → Login.

Nội dung dành cho người mới có thể bắt đầu ngay, và cũng đủ chi tiết cho senior mở rộng hệ thống.

---

### Công nghệ chính
- Flutter 3.x
- `go_router` (điều hướng), `flutter_bloc` (state), `get_it` (DI)
- `dio` (HTTP), `shared_preferences` (lưu local), `flutter_localizations` + `intl` (đa ngôn ngữ)
- `flutter_gen_runner` (quản lý assets)

---

## Cấu trúc thư mục (tổng quan)
- `lib/main.dart` — entry app, khởi tạo DI
- `lib/app.dart` — `MaterialApp.router`, theme, localization, router
- `lib/core/` — mã dùng chung
  - `di/` — `service_locator.dart` (đăng ký get_it)
  - `routing/` — `app_router.dart` (cấu hình go_router)
  - `services/` — `http_service.dart`, `language_service.dart`, `token_manager.dart`, ...
  - `theme/`, `style/` — theme và style
- `lib/features/` — module theo tính năng (Clean Architecture)
  - `auth/` — domain/data/presentation cho đăng nhập
  - `splash/` — màn hình splash
- `lib/widgets/` — các UI component dùng chung (common)
- `lib/l10n/` — file đa ngôn ngữ (.arb) và file generate
- `assets/` — ảnh/icons

---

## Bắt đầu chạy dự án
1) Cài Flutter và SDK nền tảng (Android/iOS/Web/Windows).
2) Tại thư mục dự án:
   - `flutter clean && flutter pub get`
   - Chạy app:
     - Android: `flutter run -d <deviceId>`
     - Windows: `flutter run -d windows`
     - Web: `flutter run -d chrome`

Khắc phục hot-reload/hot-restart mất kết nối:
- Nếu mất VM Service, dừng hết phiên đang chạy, rồi chạy lại `flutter run` lên đúng thiết bị.

---

## Build và Flavors
Trong `main.dart` có tham số flavor:
- `const flavor = String.fromEnvironment('FLAVOR', defaultValue: 'dev');`

Chạy/Build với flavor:
```bash
flutter run --dart-define=FLAVOR=dev
flutter build apk --dart-define=FLAVOR=prod
```

---

## Routing (go_router)
File: `lib/core/routing/app_router.dart`
- Route khởi chạy: `/` → `SplashScreen` (màu xanh + spinner)
- `/login` → `LoginScreen`

Điều hướng trong widget:
```dart
import 'package:go_router/go_router.dart';

context.go('/login');
```

Hàm tiện ích điều hướng đến login (dùng trong services):
```dart
import 'app_router.dart';

navigateToLogin(); // nội bộ gọi context.go('/login')
```

---

## Dependency Injection (get_it)
File: `lib/core/di/service_locator.dart`
- Đăng ký: `Dio`, `SharedPreferences`, `TokenManager`, `LanguageService`, `ThemeService`, `ThemeProvider`, `HttpService`, `FlexibleHttpService`
- Auth: `AuthRemoteDataSource`, `AuthRepository`, `LoginUseCase`
- `HttpService.onUnauthorized` và `onRefreshToken` sẽ xoá token và điều hướng về login.

Lấy service trong UI:
```dart
final loginUseCase = sl<LoginUseCase>();
```

---

## State management (flutter_bloc)
Ví dụ Auth:
- `lib/features/auth/presentation/bloc/auth_bloc.dart` có event `LoginSubmitted`
- Cách provide BLoC trong màn hình:
```dart
BlocProvider(
  create: (_) => AuthBloc(loginUseCase: sl()),
  child: const _LoginBody(),
)
```

---

## Đa ngôn ngữ (l10n)
Cấu hình trong `lib/app.dart`:
- Delegates: `AppLocalizations.delegate`, `GlobalMaterialLocalizations.delegate`, ...
- `LanguageService` điều khiển `locale` qua Provider.

Sử dụng trong UI:
```dart
import 'package:flutter_app/l10n/app_localizations.dart';

final t = AppLocalizations.of(context)!;
Text(t.loginTitle);
```

Đổi ngôn ngữ runtime:
- AppBar có nút `LanguageSelector` khi dùng `CommonAppBar(showLanguageSwitcher: true)`
- Toggle VI/EN qua `LanguageService` và app tự rebuild.

Thêm/chỉnh sửa chuỗi dịch:
1) Sửa `lib/l10n/app_en.arb` và `lib/l10n/app_vi.arb`
2) Chạy: `flutter gen-l10n`
3) Dùng: `AppLocalizations.of(context)!.yourKey`

Ví dụ ARB:
```json
// lib/l10n/app_en.arb
{
  "welcomeBack": "Welcome back"
}
// lib/l10n/app_vi.arb
{
  "welcomeBack": "Chào mừng trở lại"
}
```

---

## UI Common
Thư mục: `lib/widgets/`. Thành phần nổi bật:
- `CommonAppBar` (có `showLanguageSwitcher`)
- `CommonButton`
- `CommonTextField`
- `LanguageSelector` (dùng độc lập khi cần)

Ví dụ:
```dart
Scaffold(
  appBar: const CommonAppBar(
    title: '...',
    showLanguageSwitcher: true,
  ),
  body: Padding(
    padding: const EdgeInsets.all(16),
    child: Column(
      children: const [
        CommonTextField(label: 'Email'),
      ],
    ),
  ),
)
```

---

## HTTP Service
File: `lib/core/services/http_service.dart`
- Bọc `Dio`, tự đính kèm token từ `TokenManager`.
- Xử lý `onUnauthorized` và `onRefreshToken` (đăng ký tại DI).

Sử dụng:
```dart
final http = sl<HttpService>();
final response = await http.get('/path');
```

`FlexibleHttpService`: phục vụ thêm form-data/multipart.

Tuỳ biến base URL/headers: chỉnh lúc đăng ký `Dio` trong `service_locator.dart` hoặc mở rộng `HttpService`.

---

## Thêm tính năng mới (Clean Architecture)
Tạo module tại `lib/features/<feature>/` gồm 3 lớp:
- Domain: `entities/`, `repositories/` (abstract), `usecases/`
- Data: `datasources/`, `repositories/` (impl)
- Presentation: `bloc/`, `screens/`, `widgets/`

Các bước:
1) Domain
   - Khai báo repository abstract trong `domain/repositories/`
   - Viết use case trong `domain/usecases/`
2) Data
   - Implement datasource(s)
   - Implement repository dùng datasource(s)
3) Presentation
   - Tạo BLoC (events/states) dùng use case
   - Xây UI với common widgets
4) DI
   - Đăng ký các class mới trong `service_locator.dart`
5) Routing
   - Thêm route trong `app_router.dart`

Ví dụ tối giản (fetch list):
```dart
// domain/repositories/todo_repository.dart
abstract class TodoRepository { Future<List<Todo>> fetch(); }

// domain/usecases/fetch_todos.dart
class FetchTodos { final TodoRepository repo; FetchTodos(this.repo); Future<List<Todo>> call() => repo.fetch(); }

// data/repositories/todo_repository_impl.dart
class TodoRepositoryImpl implements TodoRepository {
  final HttpService http;
  TodoRepositoryImpl(this.http);
  @override
  Future<List<Todo>> fetch() async {
    final r = await http.get('/todos');
    return (r.data as List).map((e) => Todo.fromJson(e)).toList();
  }
}
```

---

## Tài sản (Assets), icon và app icon

### Thêm ảnh/SVG
1) Đặt file vào `assets/images/png` hoặc `assets/images/svg`
2) Đảm bảo `pubspec.yaml` đã khai báo thư mục cha trong `flutter/assets`
3) Generate accessor mạnh kiểu:
```bash
flutter pub run build_runner build --delete-conflicting-outputs
# hoặc dùng fluttergen nếu đã cấu hình
```
4) Dùng trong code:
```dart
import 'package:flutter_app/generated/assets.gen.dart';
Assets.images.png.viIcon.image();
Assets.images.svg.backIcon.svg();
```

### Thêm icon UI mới
1) Đặt SVG/PNG vào `assets/images/svg` hoặc `assets/images/png`
2) Chạy generator (như trên)
3) Dùng: `Assets.images.svg.yourIcon.svg(...)`

### Đổi app icon
Cấu hình trong `pubspec.yaml` với `flutter_launcher_icons`.
1) Thay file icon (ví dụ `assets/appicons/appstore.png`)
2) Chạy:
```bash
flutter pub run flutter_launcher_icons:main
```
3) `flutter clean` và build lại app.

---

## Theming
File: `lib/core/theme/app_theme.dart`, `lib/core/style/*`
- Tập trung quản lý màu sắc và typography.
- `AppTheme` được áp vào `MaterialApp.router` trong `lib/app.dart`.

---

## Flow Splash → Login
- `lib/features/splash/presentation/splash_screen.dart` — nền xanh + spinner, tự điều hướng sang `/login` sau ~900ms bằng `go_router`.
- `lib/features/auth/presentation/screens/login_screen.dart` — dùng common + l10n; nút đổi ngôn ngữ đặt trên AppBar.

---

## Ghi chú Android
- Lỗi Kotlin incremental cache: xoá `build/` rồi `flutter pub get` và build lại.
- Lỗi “Navigator.onGenerateRoute was null…”: hãy điều hướng bằng `go_router` (`context.go('/route')`) trong widget, không dùng Navigator.pushNamed.
- Lỗi JNI UTF-8 do plugin/native cũ: đảm bảo đã xoá tham chiếu module native không dùng và `flutter clean` trước khi build.

---

## Lệnh hữu ích
- Định dạng và phân tích:
```bash
dart format lib
flutter analyze
```

- Generate i18n và assets:
```bash
flutter gen-l10n
flutter pub run build_runner build --delete-conflicting-outputs
```

- Chạy app:
```bash
flutter run -d <deviceId> --debug
```

---

## FAQ
- Đổi ngôn ngữ nhưng text không thay?
  - Đảm bảo dùng `AppLocalizations.of(context)!` thay vì hard-code.
  - `LanguageService` được provide ở root trong `app.dart`.

- Thêm service mới ở đâu?
  - Tạo ở `lib/core/services/` và đăng ký trong `service_locator.dart`.

- Thêm màn hình mới thế nào?
  - Tạo screen + route trong `lib/core/routing/app_router.dart` bằng `GoRoute`.

---

Nếu thiếu nội dung hoặc cần bổ sung, vui lòng mở issue/PR cập nhật README.

---

## Thiết lập môi trường phát triển
- Cài Flutter SDK (ổn định): `flutter --version`
- Kiểm tra công cụ: `flutter doctor -v`
- Cài JDK 17+ cho Android, Android Studio (SDK/Platform-Tools), Xcode cho iOS (nếu phát triển iOS).
- Bật USB debugging (Android) hoặc dùng Wi‑Fi Debugging.

Mẹo:
- Nếu thiết bị không hiện: `flutter devices --device-timeout 20` và `adb devices`.
- Lỗi Gradle/Kotlin cache: `flutter clean`, xoá thư mục `android/.gradle` nếu cần rồi build lại.

---

## Đổi tên app và mã gói (Package/Bundle)
### Android
- Tên hiển thị: `android/app/src/main/AndroidManifest.xml` → `android:label="Tên App"`.
- applicationId (mã gói): `android/app/build.gradle` → `defaultConfig { applicationId "com.your.app" }`.
- Đổi package Kotlin nếu cần: cập nhật đường dẫn `android/app/src/main/kotlin/<package>/MainActivity.kt` cho khớp với `applicationId`.

### iOS (nếu dùng)
- Display name: Xcode → Runner → Info → Display Name.
- Bundle Identifier: Xcode → Runner → Signing & Capabilities → Bundle Identifier.

---

## Ký build Android (Release)
1) Tạo keystore:
```bash
keytool -genkey -v -keystore app-release.keystore -alias upload -keyalg RSA -keysize 2048 -validity 10000
```
2) Đặt file keystore vào `android/app/` và cấu hình `android/key.properties`:
```properties
storePassword=...
keyPassword=...
keyAlias=upload
storeFile=../app-release.keystore
```
3) `android/app/build.gradle` thêm signingConfigs `release` và dùng cho `buildTypes.release`.
4) Build: `flutter build apk --release` hoặc `flutter build appbundle`.

---

## Quy ước mã nguồn
- Format và lint trước commit: `dart format lib` và `flutter analyze`.
- Đặt tên biến/hàm rõ nghĩa; tránh viết tắt khó hiểu.
- UI không hardcode text; luôn dùng `AppLocalizations`.
- BLoC: sự kiện là động từ, state rõ ràng (loading/success/failure...).
- Service: không `print` trong production; dùng logger nếu cần.

---

## Quy ước i18n (đa ngôn ngữ)
- Đặt key theo ngữ cảnh: `loginTitle`, `welcomeBack`, `emailRequired`...
- Mỗi key có ở cả `app_en.arb` và `app_vi.arb`.
- Không chèn biến trực tiếp vào string; dùng tham số nếu cần (xem ví dụ `fileTooLarge`).
- Tuyệt đối không hardcode text trong widget.

---

## Quy ước HTTP/API
- Thêm/chỉnh base URL tại nơi đăng ký `Dio` (trong `service_locator.dart`).
- Tất cả call đi qua `HttpService`/`FlexibleHttpService` để tự gắn token và xử lý lỗi tập trung.
- Map lỗi về `Failure` (domain) để UI/BLoC xử lý nhất quán.
- Timeout/retry: cấu hình trong `Dio` Interceptors (có thể mở rộng theo nhu cầu).

---

## Bảo mật cấu hình
- Không commit secrets/keystore/token.
- Dùng `--dart-define` để truyền biến môi trường (ví dụ `BASE_URL`, `FLAVOR`).
- Có thể tạo wrapper script chạy kèm nhiều `--dart-define`.

---

## Route guard / Điều hướng có điều kiện
`go_router` hỗ trợ `redirect`/`refreshListenable` để chặn route theo trạng thái đăng nhập.
Ví dụ (giả sử có `TokenManager`):
```dart
final appRouter = GoRouter(
  initialLocation: '/',
  routes: [...],
  redirect: (context, state) {
    final loggedIn = sl<TokenManager>().hasValidTokensSync();
    final loggingIn = state.fullPath == '/login';
    if (!loggedIn && !loggingIn) return '/login';
    if (loggedIn && loggingIn) return '/';
    return null;
  },
);
```

---

## Tuỳ biến Splash
- File: `lib/features/splash/presentation/splash_screen.dart`.
- Đổi màu nền, thời gian chờ, hiệu ứng spinner theo ý muốn.
- Điều hướng dùng `context.go('/login')` (không dùng `Navigator.pushNamed`).

---

## Cập nhật phụ thuộc
- Kiểm tra phiên bản mới: `flutter pub outdated`.
- Cập nhật có kiểm soát; test lại build Android/Windows/Web sau khi nâng phiên bản.

---

## Dọn dẹp assets/icon không dùng
- Xoá file trong `assets/images/...`.
- Chạy lại generator để làm sạch accessor: `flutter pub run build_runner build --delete-conflicting-outputs`.
- Kiểm tra compile nếu còn tham chiếu cũ.

## Starter Base App (Flutter)

A clean, minimal Flutter base for starting new apps quickly. It ships with:
- Clean Architecture (Domain / Data / Presentation)
- Routing with `go_router`
- Dependency injection with `get_it`
- State management with `flutter_bloc`
- Localization (en/vi) with `flutter_localizations` and ARB files
- Asset management with `flutter_gen`
- Common UI kit (buttons, text fields, app bar, etc.)
- HTTP service with token handling and interceptors
- Green splash screen → login flow

This document teaches a new teammate how to build, customize, and extend this base.

---

### Tech stack
- Flutter 3.x
- go_router, flutter_bloc, get_it, shared_preferences, dio
- flutter_localizations, intl, flutter_gen

---

## Project structure (high level)
- `lib/main.dart` — app entry, DI bootstrap
- `lib/app.dart` — `MaterialApp.router`, theme, localization, router
- `lib/core/` — cross-cutting code
  - `di/` — `service_locator.dart` (get_it registrations)
  - `routing/` — `app_router.dart` (go_router config)
  - `services/` — `http_service.dart`, `language_service.dart`, `token_manager.dart`, etc.
  - `theme/` and `style/` — theming and styles
- `lib/features/` — features by module
  - `auth/` — domain/data/presentation for login
  - `splash/` — splash screen
- `lib/widgets/` — common components (buttons, app bar, text fields, etc.)
- `lib/l10n/` — localization ARB files and generated localizations
- `assets/` — images and icons

---

## Getting started
1) Install Flutter and platform SDKs.
2) From project root:
   - `flutter clean && flutter pub get`
   - Run on your target:
     - Android: `flutter run -d <deviceId>`
     - Windows: `flutter run -d windows`
     - Web: `flutter run -d chrome`

Troubleshooting hot-reload/hot-restart:
- If VM Service is lost, stop all running sessions and re-run `flutter run` on your device.

---

## Build and flavors
Default uses an inline `flavor` string in `main.dart`:
- `const flavor = String.fromEnvironment('FLAVOR', defaultValue: 'dev');`

Run with a flavor flag:
```bash
flutter run --dart-define=FLAVOR=dev
flutter build apk --dart-define=FLAVOR=prod
```

---

## Routing (go_router)
File: `lib/core/routing/app_router.dart`
- Initial route: `/` → green `SplashScreen`
- `/login` → `LoginScreen`

Example navigation from anywhere (via root navigator):
```dart
import 'package:go_router/go_router.dart';

context.go('/login');
```

Global helper to redirect to login from services:
```dart
import 'app_router.dart';

navigateToLogin(); // internally does context.go('/login')
```

---

## Dependency Injection (get_it)
File: `lib/core/di/service_locator.dart`
- Registers: `Dio`, `SharedPreferences`, `TokenManager`, `LanguageService`, `ThemeService`, `ThemeProvider`, `HttpService`, `FlexibleHttpService`
- Auth: `AuthRemoteDataSource`, `AuthRepository`, `LoginUseCase`
- `HttpService.onUnauthorized` and `onRefreshToken` clear tokens and navigate to login.

Usage in UI:
```dart
final loginUseCase = sl<LoginUseCase>();
```

---

## State management (flutter_bloc)
Auth example:
- `lib/features/auth/presentation/bloc/auth_bloc.dart` with `LoginSubmitted` event
- Provide BLoC in screen:
```dart
BlocProvider(
  create: (_) => AuthBloc(loginUseCase: sl()),
  child: const _LoginBody(),
)
```

---

## Localization (l10n)
Configured in `lib/app.dart`:
- Delegates: `AppLocalizations.delegate`, `GlobalMaterialLocalizations.delegate`, etc.
- `LanguageService` controls current locale via Provider.

Use in UI:
```dart
import 'package:flutter_app/l10n/app_localizations.dart';

final t = AppLocalizations.of(context)!;
Text(t.loginTitle);
```

Change language at runtime:
- App bar includes `LanguageSelector` when `CommonAppBar(showLanguageSwitcher: true)`
- It toggles VI/EN using `LanguageService` and rebuilds app.

Add/modify strings:
1) Edit `lib/l10n/app_en.arb` and `lib/l10n/app_vi.arb`
2) Run: `flutter gen-l10n`
3) Use `AppLocalizations.of(context)!.yourKey`

Example ARB entries:
```json
// lib/l10n/app_en.arb
{
  "welcomeBack": "Welcome back"
}
// lib/l10n/app_vi.arb
{
  "welcomeBack": "Chào mừng trở lại"
}
```

---

## Common UI components
Located in `lib/widgets/`. Notable components:
- `CommonAppBar` (supports `showLanguageSwitcher`)
- `CommonButton`
- `CommonTextField`
- `LanguageSelector` (standalone when needed)

Example:
```dart
Scaffold(
  appBar: const CommonAppBar(
    title: '...',
    showLanguageSwitcher: true,
  ),
  body: Padding(
    padding: const EdgeInsets.all(16),
    child: Column(
      children: const [
        CommonTextField(label: 'Email'),
      ],
    ),
  ),
)
```

---

## HTTP service
File: `lib/core/services/http_service.dart`
- Wraps `Dio`, injects tokens from `TokenManager`.
- Handles `onUnauthorized` and `onRefreshToken` via callbacks registered in DI.

Usage:
```dart
final http = sl<HttpService>();
final response = await http.get('/path');
```

Flexible variant: `FlexibleHttpService` for form-data/multipart special cases.

Add base URL/headers: extend `HttpService` or set options in `service_locator.dart` when registering `Dio`.

---

## Implementing a new feature (Clean Architecture)
Create a folder under `lib/features/<feature>/` with three layers:
- Domain: `entities/`, `repositories/` (abstract), `usecases/`
- Data: `datasources/`, `repositories/` (impl)
- Presentation: `bloc/`, `screens/`, `widgets/`

Steps:
1) Domain
   - Define abstract repository in `domain/repositories/`
   - Add use cases in `domain/usecases/`
2) Data
   - Implement remote/local datasource(s)
   - Implement repository that depends on datasource(s)
3) Presentation
   - Create `Bloc` with events/states using the use cases
   - Build screens with common components
4) DI
   - Register all new classes in `service_locator.dart`
5) Routing
   - Add route in `app_router.dart`

Example: minimal fetch use case
```dart
// domain/repositories/todo_repository.dart
abstract class TodoRepository { Future<List<Todo>> fetch(); }

// domain/usecases/fetch_todos.dart
class FetchTodos { final TodoRepository repo; FetchTodos(this.repo); Future<List<Todo>> call() => repo.fetch(); }

// data/repositories/todo_repository_impl.dart
class TodoRepositoryImpl implements TodoRepository { final HttpService http; TodoRepositoryImpl(this.http); @override Future<List<Todo>> fetch() async { final r = await http.get('/todos'); return (r.data as List).map((e) => Todo.fromJson(e)).toList(); }}
```

---

## Assets, icons, and app icon

### Adding images/SVGs
1) Place assets under `assets/images/png` or `assets/images/svg`
2) Ensure `pubspec.yaml` includes the parent folders in `flutter/assets:`
3) Generate strongly-typed accessors:
```bash
flutter pub run build_runner build --delete-conflicting-outputs
# or `fluttergen` if configured
```
4) Use in code:
```dart
import 'package:flutter_app/generated/assets.gen.dart';
Assets.images.png.viIcon.image();
Assets.images.svg.backIcon.svg();
```

### Adding a new icon to the UI
1) Put SVG/PNG in `assets/images/svg` or `assets/images/png`
2) Re-run generators (above)
3) Use via `Assets.images.svg.yourIcon.svg(...)`

### Changing the app icon
Configured in `pubspec.yaml` with `flutter_launcher_icons`.
1) Replace the icon file (e.g. `assets/appicons/appstore.png`)
2) Run:
```bash
flutter pub run flutter_launcher_icons:main
```
3) Clean and rebuild the app.

---

## Theming
File: `lib/core/theme/app_theme.dart`, `lib/core/style/*`
- Centralized colors and text styles.
- `AppTheme` applied in `MaterialApp.router` in `lib/app.dart`.

---

## Splash → Login flow
- `lib/features/splash/presentation/splash_screen.dart` — green background with a centered spinner, auto-navigates to `/login` after a short delay using `go_router`.
- `lib/features/auth/presentation/screens/login_screen.dart` — uses common components and localization; language toggle is on the app bar.

---

## Android notes
- If Kotlin incremental cache errors occur, remove `build/` and re-run `flutter pub get`.
- If “Navigator.onGenerateRoute was null…” appears, ensure navigation uses `go_router` (`context.go('/route')`) from widgets.
- If you see JNI modified UTF-8 errors from old camera/scanner code, ensure removed native modules are not referenced and rebuild after `flutter clean`.

---

## Useful commands
- Analyze and format:
```bash
dart format lib
flutter analyze
```

- Run generators:
```bash
flutter gen-l10n
flutter pub run build_runner build --delete-conflicting-outputs
```

- Run app:
```bash
flutter run -d <deviceId> --debug
```

---

## FAQ
- Strings don’t change when toggling language?
  - Ensure widgets read from `AppLocalizations.of(context)!` and not hard-coded.
  - `LanguageService` is provided at app root in `app.dart`.

- Where to add new services?
  - Put in `lib/core/services/` and register in `service_locator.dart`.

- Where to add a new screen route?
  - Add to `lib/core/routing/app_router.dart` using `GoRoute`.

---

If something is missing or unclear, please open an issue or update this README.
