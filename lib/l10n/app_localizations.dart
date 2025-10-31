import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_vi.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('vi'),
  ];

  /// Title for login page
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get loginTitle;

  /// Company field label
  ///
  /// In en, this message translates to:
  /// **'Company'**
  String get companyField;

  /// Company field hint
  ///
  /// In en, this message translates to:
  /// **'Company'**
  String get companyHint;

  /// Username field label
  ///
  /// In en, this message translates to:
  /// **'Username'**
  String get usernameField;

  /// Password field label
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get passwordField;

  /// Login button text
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get loginButton;

  /// Register link text
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account? Register'**
  String get registerLink;

  /// Company validation error
  ///
  /// In en, this message translates to:
  /// **'Company name is required'**
  String get companyRequired;

  /// Username validation error
  ///
  /// In en, this message translates to:
  /// **'Username is required'**
  String get usernameRequired;

  /// Password validation error
  ///
  /// In en, this message translates to:
  /// **'Password is required'**
  String get passwordRequired;

  /// Invalid credentials error
  ///
  /// In en, this message translates to:
  /// **'Invalid username or password.'**
  String get invalidCredentials;

  /// Domain not registered error
  ///
  /// In en, this message translates to:
  /// **'You are not registered with us. Please click register below'**
  String get domainNotRegistered;

  /// Wrong username error
  ///
  /// In en, this message translates to:
  /// **'Wrong username'**
  String get wrongUsername;

  /// Wrong password error
  ///
  /// In en, this message translates to:
  /// **'Wrong password'**
  String get wrongPassword;

  /// Network error message
  ///
  /// In en, this message translates to:
  /// **'Cannot connect to server. Please check your company name or network connection.'**
  String get networkError;

  /// Unknown error message
  ///
  /// In en, this message translates to:
  /// **'An unexpected error occurred'**
  String get unknownError;

  /// Sunday day name
  ///
  /// In en, this message translates to:
  /// **'Sunday'**
  String get sunday;

  /// Monday day name
  ///
  /// In en, this message translates to:
  /// **'Monday'**
  String get monday;

  /// Tuesday day name
  ///
  /// In en, this message translates to:
  /// **'Tuesday'**
  String get tuesday;

  /// Wednesday day name
  ///
  /// In en, this message translates to:
  /// **'Wednesday'**
  String get wednesday;

  /// Thursday day name
  ///
  /// In en, this message translates to:
  /// **'Thursday'**
  String get thursday;

  /// Friday day name
  ///
  /// In en, this message translates to:
  /// **'Friday'**
  String get friday;

  /// Saturday day name
  ///
  /// In en, this message translates to:
  /// **'Saturday'**
  String get saturday;

  /// Day label for date format
  ///
  /// In en, this message translates to:
  /// **'day'**
  String get day;

  /// Logout title
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logoutTitle;

  /// Logout confirmation message
  ///
  /// In en, this message translates to:
  /// **'Logout from your account?'**
  String get logoutConfirm;

  /// Logout button text
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logoutButton;

  /// Cancel button text
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancelButton;

  /// Logout success message
  ///
  /// In en, this message translates to:
  /// **'Logout successful'**
  String get logoutSuccess;

  /// Logout error prefix
  ///
  /// In en, this message translates to:
  /// **'Logout error'**
  String get logoutError;

  /// Profile title
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profileTitle;

  /// User name label
  ///
  /// In en, this message translates to:
  /// **'User Name'**
  String get userName;

  /// Menu button text
  ///
  /// In en, this message translates to:
  /// **'Menu'**
  String get menuButton;

  /// Home button text
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get homeButton;

  /// Notification button text
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notificationButton;

  /// Profile button text
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profileButton;

  /// Create application button text
  ///
  /// In en, this message translates to:
  /// **'Create Application'**
  String get createApplicationButton;

  /// Language selection title
  ///
  /// In en, this message translates to:
  /// **'Select Language'**
  String get languageTitle;

  /// Vietnamese language name
  ///
  /// In en, this message translates to:
  /// **'Tiếng Việt'**
  String get vietnamese;

  /// English language name
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get english;

  /// Change password page title
  ///
  /// In en, this message translates to:
  /// **'Change Password'**
  String get changePasswordTitle;

  /// Change password button text
  ///
  /// In en, this message translates to:
  /// **'Change Password'**
  String get changePasswordButton;

  /// Suggest password button text
  ///
  /// In en, this message translates to:
  /// **'Suggest'**
  String get suggestButton;

  /// Password generation success message
  ///
  /// In en, this message translates to:
  /// **'New password generated'**
  String get passwordGenerated;

  /// Notifications page title
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notificationsTitle;

  /// HRM page title
  ///
  /// In en, this message translates to:
  /// **'HRM'**
  String get hrmTitle;

  /// Home page title
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get homeTitle;

  /// Register page title
  ///
  /// In en, this message translates to:
  /// **'Register HRM'**
  String get registerTitle;

  /// Register button text
  ///
  /// In en, this message translates to:
  /// **'Register'**
  String get registerButton;

  /// Registration success message
  ///
  /// In en, this message translates to:
  /// **'Registration successful!'**
  String get registerSuccess;

  /// Domain not registered dialog title
  ///
  /// In en, this message translates to:
  /// **'Domain not registered'**
  String get domainNotRegisteredTitle;

  /// Contact support message
  ///
  /// In en, this message translates to:
  /// **'Please contact support:'**
  String get contactSupport;

  /// Email field label
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get emailLabel;

  /// Phone label
  ///
  /// In en, this message translates to:
  /// **'Phone:'**
  String get phoneLabel;

  /// Close button text
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get closeButton;

  /// Session expired dialog title
  ///
  /// In en, this message translates to:
  /// **'Session expired'**
  String get sessionExpiredTitle;

  /// Login again button text
  ///
  /// In en, this message translates to:
  /// **'Login again'**
  String get loginAgainButton;

  /// Current password field hint
  ///
  /// In en, this message translates to:
  /// **'Current password'**
  String get currentPasswordHint;

  /// New password field hint
  ///
  /// In en, this message translates to:
  /// **'Enter new password'**
  String get newPasswordHint;

  /// Confirm password field hint
  ///
  /// In en, this message translates to:
  /// **'Re-enter password'**
  String get confirmPasswordHint;

  /// Current password validation error
  ///
  /// In en, this message translates to:
  /// **'Please enter current password'**
  String get currentPasswordRequired;

  /// New password validation error
  ///
  /// In en, this message translates to:
  /// **'Please enter password'**
  String get newPasswordRequired;

  /// Password minimum length validation error
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 8 characters'**
  String get passwordMinLength;

  /// Password must be different validation error
  ///
  /// In en, this message translates to:
  /// **'New password must be different from current password'**
  String get passwordMustBeDifferent;

  /// Confirm password validation error
  ///
  /// In en, this message translates to:
  /// **'Please confirm password'**
  String get confirmPasswordRequired;

  /// Password mismatch validation error
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match'**
  String get passwordsDoNotMatch;

  /// Company name validation error
  ///
  /// In en, this message translates to:
  /// **'Please enter company name'**
  String get companyNameRequired;

  /// ERPNext URL validation error
  ///
  /// In en, this message translates to:
  /// **'Please enter ERPNext URL'**
  String get erpnextUrlRequired;

  /// Country validation error
  ///
  /// In en, this message translates to:
  /// **'Please enter country'**
  String get countryRequired;

  /// Name validation error
  ///
  /// In en, this message translates to:
  /// **'Please enter name'**
  String get nameRequired;

  /// Email validation error
  ///
  /// In en, this message translates to:
  /// **'Please enter email'**
  String get emailRequired;

  /// Email format validation error
  ///
  /// In en, this message translates to:
  /// **'Invalid email format'**
  String get emailInvalid;

  /// Phone number validation error
  ///
  /// In en, this message translates to:
  /// **'Please enter phone number'**
  String get phoneRequired;

  /// Employee ID label
  ///
  /// In en, this message translates to:
  /// **'Employee ID'**
  String get employeeId;

  /// Date of joining label
  ///
  /// In en, this message translates to:
  /// **'Date of Joining'**
  String get dateOfJoining;

  /// Date of birth label
  ///
  /// In en, this message translates to:
  /// **'Date of Birth'**
  String get dateOfBirth;

  /// Gender label
  ///
  /// In en, this message translates to:
  /// **'Gender'**
  String get gender;

  /// Email label
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// Company label
  ///
  /// In en, this message translates to:
  /// **'Company'**
  String get company;

  /// Status label
  ///
  /// In en, this message translates to:
  /// **'Status'**
  String get status;

  /// No description provided for @passwordMinLengthMessage.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 8 characters'**
  String get passwordMinLengthMessage;

  /// No description provided for @passwordUppercaseMessage.
  ///
  /// In en, this message translates to:
  /// **'Password must contain at least one uppercase letter'**
  String get passwordUppercaseMessage;

  /// No description provided for @passwordLowercaseMessage.
  ///
  /// In en, this message translates to:
  /// **'Password must contain at least one lowercase letter'**
  String get passwordLowercaseMessage;

  /// No description provided for @passwordNumberMessage.
  ///
  /// In en, this message translates to:
  /// **'Password must contain at least one number'**
  String get passwordNumberMessage;

  /// No description provided for @passwordSpecialCharMessage.
  ///
  /// In en, this message translates to:
  /// **'Password must contain at least one special character'**
  String get passwordSpecialCharMessage;

  /// No description provided for @passwordStrongMessage.
  ///
  /// In en, this message translates to:
  /// **'Strong password!'**
  String get passwordStrongMessage;

  /// Welcome back message on login screen
  ///
  /// In en, this message translates to:
  /// **'Welcome back'**
  String get welcomeBack;

  /// Username field hint text
  ///
  /// In en, this message translates to:
  /// **'Enter username'**
  String get usernameHint;

  /// Password field hint text
  ///
  /// In en, this message translates to:
  /// **'Enter password'**
  String get passwordHint;

  /// Forgot password link text
  ///
  /// In en, this message translates to:
  /// **'Forgot password'**
  String get forgotPassword;

  /// Google login button text
  ///
  /// In en, this message translates to:
  /// **'Login with Google'**
  String get loginWithGoogle;

  /// Divider text for login options
  ///
  /// In en, this message translates to:
  /// **'Or login with'**
  String get orLoginWith;

  /// Register link prefix text
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account? '**
  String get dontHaveAccount;

  /// Register link text
  ///
  /// In en, this message translates to:
  /// **'Register'**
  String get register;

  /// Login success message
  ///
  /// In en, this message translates to:
  /// **'Login successful!'**
  String get loginSuccess;

  /// Password minimum 6 characters validation error
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 6 characters'**
  String get passwordMinLength6;

  /// Google token error message
  ///
  /// In en, this message translates to:
  /// **'Cannot get access token from Google'**
  String get cannotGetGoogleToken;

  /// Google login failure message
  ///
  /// In en, this message translates to:
  /// **'Google login failed'**
  String get googleLoginFailed;

  /// Error prefix
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get error;

  /// Try again button text
  ///
  /// In en, this message translates to:
  /// **'Try again'**
  String get tryAgain;

  /// Search field hint text
  ///
  /// In en, this message translates to:
  /// **'Search...'**
  String get searchHint;

  /// Upload file button text
  ///
  /// In en, this message translates to:
  /// **'Upload file'**
  String get uploadFile;

  /// Photo library option
  ///
  /// In en, this message translates to:
  /// **'Photo Library'**
  String get photoLibrary;

  /// Select from library subtitle
  ///
  /// In en, this message translates to:
  /// **'Select from library'**
  String get selectFromLibrary;

  /// Take photo/video option
  ///
  /// In en, this message translates to:
  /// **'Take photo/video'**
  String get takePhotoVideo;

  /// Take new photo/video subtitle
  ///
  /// In en, this message translates to:
  /// **'Take new photo or video'**
  String get takeNewPhotoVideo;

  /// Select file option
  ///
  /// In en, this message translates to:
  /// **'Select file'**
  String get selectFile;

  /// Select file from device subtitle
  ///
  /// In en, this message translates to:
  /// **'Select file from device'**
  String get selectFileFromDevice;

  /// Cannot select image from library error
  ///
  /// In en, this message translates to:
  /// **'Cannot select image from library'**
  String get cannotSelectImageFromLibrary;

  /// File too large error message
  ///
  /// In en, this message translates to:
  /// **'File {fileName} is too large. Maximum size: {maxSize}'**
  String fileTooLarge(String fileName, String maxSize);

  /// Cannot select file error
  ///
  /// In en, this message translates to:
  /// **'Cannot select file'**
  String get cannotSelectFile;

  /// Upload image button text
  ///
  /// In en, this message translates to:
  /// **'Upload image'**
  String get uploadImage;

  /// Upload document button text
  ///
  /// In en, this message translates to:
  /// **'Upload document'**
  String get uploadDocument;

  /// Upload receipt button text
  ///
  /// In en, this message translates to:
  /// **'Upload receipt'**
  String get uploadReceipt;

  /// Document detected message
  ///
  /// In en, this message translates to:
  /// **'Document detected!'**
  String get documentDetected;

  /// Align document instruction
  ///
  /// In en, this message translates to:
  /// **'Align document'**
  String get alignDocument;

  /// Auto capturing message
  ///
  /// In en, this message translates to:
  /// **'Auto capturing...'**
  String get autoCapturing;

  /// Document alignment instructions
  ///
  /// In en, this message translates to:
  /// **'Place ID card/CCCD or Passport in frame and ensure:\n• All 4 corners are in frame\n• Document is flat, not wrinkled\n• Text is clear, not blurred\n\n🤖 System will auto capture when document is detected'**
  String get documentInstructions;

  /// Document detected auto capture message
  ///
  /// In en, this message translates to:
  /// **'Document detected! Auto capturing...'**
  String get documentDetectedAutoCapture;

  /// Align document in frame message
  ///
  /// In en, this message translates to:
  /// **'📷 Align document in camera frame'**
  String get alignDocumentInFrame;

  /// Initializing camera message
  ///
  /// In en, this message translates to:
  /// **'Initializing camera...'**
  String get initializingCamera;

  /// Cannot take photo error
  ///
  /// In en, this message translates to:
  /// **'Cannot take photo'**
  String get cannotTakePhoto;

  /// Camera permission error
  ///
  /// In en, this message translates to:
  /// **'Please grant camera access in settings'**
  String get pleaseGrantCameraPermission;

  /// Cannot access camera error
  ///
  /// In en, this message translates to:
  /// **'Cannot access camera'**
  String get cannotAccessCamera;

  /// No camera found error
  ///
  /// In en, this message translates to:
  /// **'No camera found on device'**
  String get noCameraFound;

  /// Cannot select image error
  ///
  /// In en, this message translates to:
  /// **'Cannot select image'**
  String get cannotSelectImage;

  /// Select image from library button text
  ///
  /// In en, this message translates to:
  /// **'Select image from library'**
  String get selectImageFromLibrary;

  /// Register account title
  ///
  /// In en, this message translates to:
  /// **'Register Account'**
  String get registerAccount;

  /// Full name label
  ///
  /// In en, this message translates to:
  /// **'Full Name'**
  String get fullName;

  /// Full name field hint
  ///
  /// In en, this message translates to:
  /// **'Enter full name'**
  String get fullNameHint;

  /// Full name validation error
  ///
  /// In en, this message translates to:
  /// **'Please enter full name'**
  String get fullNameRequired;

  /// Email field hint for password recovery
  ///
  /// In en, this message translates to:
  /// **'Enter linked email'**
  String get emailHint;

  /// Email format validation error
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid email'**
  String get emailInvalidFormat;

  /// Confirm password field label
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get confirmPassword;

  /// Login link prefix text
  ///
  /// In en, this message translates to:
  /// **'Already have an account? '**
  String get alreadyHaveAccount;

  /// Forgot password page title
  ///
  /// In en, this message translates to:
  /// **'Forgot Password'**
  String get forgotPasswordTitle;

  /// Password recovery title
  ///
  /// In en, this message translates to:
  /// **'Password Recovery'**
  String get passwordRecoveryTitle;

  /// Captcha code field label
  ///
  /// In en, this message translates to:
  /// **'Captcha Code'**
  String get captchaCode;

  /// Captcha code field hint
  ///
  /// In en, this message translates to:
  /// **'Enter captcha code'**
  String get captchaCodeHint;

  /// Captcha code validation error
  ///
  /// In en, this message translates to:
  /// **'Please enter captcha code'**
  String get captchaCodeRequired;

  /// Send OTP button text
  ///
  /// In en, this message translates to:
  /// **'Send OTP'**
  String get sendOtp;

  /// Cannot load captcha error
  ///
  /// In en, this message translates to:
  /// **'Cannot load captcha'**
  String get cannotLoadCaptcha;

  /// Please reload captcha error
  ///
  /// In en, this message translates to:
  /// **'Please reload captcha'**
  String get pleaseReloadCaptcha;

  /// OTP verification page title
  ///
  /// In en, this message translates to:
  /// **'OTP Verification'**
  String get otpVerificationTitle;

  /// OTP instruction text
  ///
  /// In en, this message translates to:
  /// **'Enter the 6-digit code sent to your email:'**
  String get enterOtpSentToEmail;

  /// OTP code field label
  ///
  /// In en, this message translates to:
  /// **'OTP Code'**
  String get otpCode;

  /// OTP validation error
  ///
  /// In en, this message translates to:
  /// **'OTP must be 6 digits'**
  String get otpMustBe6Digits;

  /// New password field label
  ///
  /// In en, this message translates to:
  /// **'New Password'**
  String get newPassword;

  /// Confirm new password field label
  ///
  /// In en, this message translates to:
  /// **'Confirm New Password'**
  String get confirmNewPassword;

  /// Confirm new password field hint
  ///
  /// In en, this message translates to:
  /// **'Re-enter new password'**
  String get confirmNewPasswordHint;

  /// Confirm new password validation error
  ///
  /// In en, this message translates to:
  /// **'Please confirm password'**
  String get confirmNewPasswordRequired;

  /// Confirm button text
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get confirm;

  /// Full OTP validation error
  ///
  /// In en, this message translates to:
  /// **'Please enter all 6 OTP digits'**
  String get pleaseEnterFullOtp;

  /// OTP sent to email message
  ///
  /// In en, this message translates to:
  /// **'Verification code has been sent to your email'**
  String get otpSentToEmail;

  /// Password recovery email sent message
  ///
  /// In en, this message translates to:
  /// **'Password recovery email has been sent to your inbox'**
  String get passwordRecoveryEmailSent;

  /// OTP verification success message
  ///
  /// In en, this message translates to:
  /// **'Verification successful'**
  String get otpVerificationSuccess;

  /// Password reset success message
  ///
  /// In en, this message translates to:
  /// **'Password has been reset successfully'**
  String get passwordResetSuccess;

  /// Resend OTP button text
  ///
  /// In en, this message translates to:
  /// **'Resend OTP'**
  String get resendOtp;

  /// Get OTP button text
  ///
  /// In en, this message translates to:
  /// **'Get OTP'**
  String get getOtp;

  /// Deposit token transaction type
  ///
  /// In en, this message translates to:
  /// **'Deposit Token'**
  String get depositToken;

  /// Banking method
  ///
  /// In en, this message translates to:
  /// **'Banking'**
  String get banking;

  /// Bank deposit title
  ///
  /// In en, this message translates to:
  /// **'Bank Deposit'**
  String get bankDeposit;

  /// Expiration time label
  ///
  /// In en, this message translates to:
  /// **'Expiration Time'**
  String get expirationTime;

  /// Minute unit
  ///
  /// In en, this message translates to:
  /// **'minute'**
  String get minute;

  /// Second unit
  ///
  /// In en, this message translates to:
  /// **'second'**
  String get second;

  /// Account number field label
  ///
  /// In en, this message translates to:
  /// **'Account Number'**
  String get accountNumber;

  /// Beneficiary label
  ///
  /// In en, this message translates to:
  /// **'Beneficiary'**
  String get beneficiary;

  /// Amount label
  ///
  /// In en, this message translates to:
  /// **'Amount'**
  String get amount;

  /// Content field label
  ///
  /// In en, this message translates to:
  /// **'Content'**
  String get content;

  /// Done button text
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get done;

  /// No token support banking deposit message
  ///
  /// In en, this message translates to:
  /// **'No tokens support banking deposit'**
  String get noTokenSupportBankingDeposit;

  /// Select token dropdown title
  ///
  /// In en, this message translates to:
  /// **'Select Token'**
  String get selectToken;

  /// Deposit amount label
  ///
  /// In en, this message translates to:
  /// **'Deposit Amount'**
  String get depositAmount;

  /// Enter amount VND label
  ///
  /// In en, this message translates to:
  /// **'Enter Amount (VND)'**
  String get enterAmountVND;

  /// Enter amount hint
  ///
  /// In en, this message translates to:
  /// **'Enter Amount'**
  String get enterAmount;

  /// Error occurred message
  ///
  /// In en, this message translates to:
  /// **'Error occurred'**
  String get errorOccurred;

  /// Select network label
  ///
  /// In en, this message translates to:
  /// **'Select Network'**
  String get selectNetwork;

  /// Deposit address label
  ///
  /// In en, this message translates to:
  /// **'Deposit Address'**
  String get depositAddress;

  /// Please select token first message
  ///
  /// In en, this message translates to:
  /// **'Please select token first'**
  String get pleaseSelectTokenFirst;

  /// Address copied to clipboard message
  ///
  /// In en, this message translates to:
  /// **'Address copied to clipboard'**
  String get addressCopiedToClipboard;

  /// QR code downloaded message
  ///
  /// In en, this message translates to:
  /// **'QR code downloaded'**
  String get qrCodeDownloaded;

  /// Download button text
  ///
  /// In en, this message translates to:
  /// **'Download'**
  String get download;

  /// Failed to load deposit data error
  ///
  /// In en, this message translates to:
  /// **'Failed to load deposit data'**
  String get failedToLoadDepositData;

  /// Unexpected error occurred message
  ///
  /// In en, this message translates to:
  /// **'An unexpected error occurred'**
  String get unexpectedErrorOccurred;

  /// Failed to generate deposit address error
  ///
  /// In en, this message translates to:
  /// **'Failed to generate deposit address'**
  String get failedToGenerateDepositAddress;

  /// Failed to submit deposit request error
  ///
  /// In en, this message translates to:
  /// **'Failed to submit deposit request'**
  String get failedToSubmitDepositRequest;

  /// Failed to load deposit history error
  ///
  /// In en, this message translates to:
  /// **'Failed to load deposit history'**
  String get failedToLoadDepositHistory;

  /// Continue button text
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continueText;

  /// Address label
  ///
  /// In en, this message translates to:
  /// **'Address'**
  String get address;

  /// Error loading data message
  ///
  /// In en, this message translates to:
  /// **'Error loading data'**
  String get errorLoadingData;

  /// History title
  ///
  /// In en, this message translates to:
  /// **'History'**
  String get history;

  /// Loading text
  ///
  /// In en, this message translates to:
  /// **'Loading...'**
  String get loading;

  /// Error loading transactions message
  ///
  /// In en, this message translates to:
  /// **'Error loading transactions'**
  String get errorLoadingTransactions;

  /// Retry button text
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retry;

  /// No transactions found message
  ///
  /// In en, this message translates to:
  /// **'No transactions found'**
  String get noTransactionsFound;

  /// Transaction history placeholder message
  ///
  /// In en, this message translates to:
  /// **'Your transaction history will appear here'**
  String get transactionHistoryWillAppearHere;

  /// All transactions displayed message
  ///
  /// In en, this message translates to:
  /// **'All transactions displayed'**
  String get allTransactionsDisplayed;

  /// Filters label
  ///
  /// In en, this message translates to:
  /// **'Filters'**
  String get filters;

  /// Clear filters button text
  ///
  /// In en, this message translates to:
  /// **'Clear filters'**
  String get clearFilters;

  /// Transaction type label
  ///
  /// In en, this message translates to:
  /// **'Transaction Type'**
  String get transactionType;

  /// All option
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get all;

  /// From date label
  ///
  /// In en, this message translates to:
  /// **'From Date'**
  String get fromDate;

  /// To date label
  ///
  /// In en, this message translates to:
  /// **'To Date'**
  String get toDate;

  /// Select date hint
  ///
  /// In en, this message translates to:
  /// **'Select Date'**
  String get selectDate;

  /// Stake token option
  ///
  /// In en, this message translates to:
  /// **'Stake Token'**
  String get stakeToken;

  /// Unstake token option
  ///
  /// In en, this message translates to:
  /// **'Unstake Token'**
  String get unstakeToken;

  /// Claim rewards option
  ///
  /// In en, this message translates to:
  /// **'Claim Rewards'**
  String get claimRewards;

  /// Pending status
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get pending;

  /// Confirmed status
  ///
  /// In en, this message translates to:
  /// **'Confirmed'**
  String get confirmed;

  /// Cancelled status
  ///
  /// In en, this message translates to:
  /// **'Cancelled'**
  String get cancelled;

  /// Rejected status
  ///
  /// In en, this message translates to:
  /// **'Rejected'**
  String get rejected;

  /// Expired status
  ///
  /// In en, this message translates to:
  /// **'Expired'**
  String get expired;

  /// Transaction ID label
  ///
  /// In en, this message translates to:
  /// **'TXID'**
  String get txid;

  /// Time label
  ///
  /// In en, this message translates to:
  /// **'Time'**
  String get time;

  /// Type label
  ///
  /// In en, this message translates to:
  /// **'Type'**
  String get type;

  /// Detail link text
  ///
  /// In en, this message translates to:
  /// **'Detail'**
  String get detail;

  /// Action label
  ///
  /// In en, this message translates to:
  /// **'Action'**
  String get action;

  /// Verify button text
  ///
  /// In en, this message translates to:
  /// **'Verify'**
  String get verify;

  /// Staking/Reward label
  ///
  /// In en, this message translates to:
  /// **'Staking/Reward'**
  String get stakingReward;

  /// Balance label
  ///
  /// In en, this message translates to:
  /// **'Balance'**
  String get balance;

  /// Withdraw token transaction type
  ///
  /// In en, this message translates to:
  /// **'Withdraw Token'**
  String get withdrawToken;

  /// Select account title
  ///
  /// In en, this message translates to:
  /// **'Select Account'**
  String get selectAccount;

  /// Assets section title
  ///
  /// In en, this message translates to:
  /// **'Assets'**
  String get assets;

  /// Services section title
  ///
  /// In en, this message translates to:
  /// **'Services'**
  String get services;

  /// Support service label
  ///
  /// In en, this message translates to:
  /// **'Support'**
  String get support;

  /// Scan QR service label
  ///
  /// In en, this message translates to:
  /// **'Scan QR'**
  String get scanQR;

  /// Scan QR code page title
  ///
  /// In en, this message translates to:
  /// **'Scan QR Code'**
  String get scanQrCodeTitle;

  /// Message when no bank images are available
  ///
  /// In en, this message translates to:
  /// **'No images available'**
  String get noImagesAvailable;

  /// Error message for invalid QR code
  ///
  /// In en, this message translates to:
  /// **'QR code is invalid or not supported'**
  String get invalidQrCode;

  /// Voucher service label
  ///
  /// In en, this message translates to:
  /// **'Voucher'**
  String get voucher;

  /// Overnight interest service label
  ///
  /// In en, this message translates to:
  /// **'Overnight Interest'**
  String get overnightInterest;

  /// Payment history section title
  ///
  /// In en, this message translates to:
  /// **'Payment History'**
  String get paymentHistory;

  /// View all button text
  ///
  /// In en, this message translates to:
  /// **'View All'**
  String get viewAll;

  /// Buy voucher title
  ///
  /// In en, this message translates to:
  /// **'BUY VOUCHER'**
  String get buyVoucher;

  /// Go now button text
  ///
  /// In en, this message translates to:
  /// **'Go Now'**
  String get goNow;

  /// Buy voucher description text
  ///
  /// In en, this message translates to:
  /// **'Buy electronic vouchers easily, quickly and conveniently'**
  String get buyVoucherDescription;

  /// Failed status
  ///
  /// In en, this message translates to:
  /// **'Failed'**
  String get failed;

  /// KYC title
  ///
  /// In en, this message translates to:
  /// **'KYC'**
  String get kyc;

  /// Document type label
  ///
  /// In en, this message translates to:
  /// **'Document Type'**
  String get documentType;

  /// ID Card option
  ///
  /// In en, this message translates to:
  /// **'ID Card'**
  String get idCard;

  /// Passport option
  ///
  /// In en, this message translates to:
  /// **'Passport'**
  String get passport;

  /// Current address label
  ///
  /// In en, this message translates to:
  /// **'Current Address'**
  String get currentAddress;

  /// City label
  ///
  /// In en, this message translates to:
  /// **'City'**
  String get city;

  /// Select city hint
  ///
  /// In en, this message translates to:
  /// **'Select City'**
  String get selectCity;

  /// Ward label
  ///
  /// In en, this message translates to:
  /// **'Ward/Commune'**
  String get ward;

  /// Please select city first message
  ///
  /// In en, this message translates to:
  /// **'Please select city first'**
  String get pleaseSelectCityFirst;

  /// Select ward hint
  ///
  /// In en, this message translates to:
  /// **'Select Ward/Commune'**
  String get selectWard;

  /// Enter address hint
  ///
  /// In en, this message translates to:
  /// **'Enter address...'**
  String get enterAddress;

  /// Please enter address validation
  ///
  /// In en, this message translates to:
  /// **'Please enter address'**
  String get pleaseEnterAddress;

  /// Please select validation message
  ///
  /// In en, this message translates to:
  /// **'Please select {label}'**
  String pleaseSelect(String label);

  /// Submit KYC button
  ///
  /// In en, this message translates to:
  /// **'Submit KYC'**
  String get submitKYC;

  /// Cannot initialize camera error
  ///
  /// In en, this message translates to:
  /// **'Cannot initialize camera'**
  String get cannotInitializeCamera;

  /// Camera not ready error
  ///
  /// In en, this message translates to:
  /// **'Camera not ready'**
  String get cameraNotReady;

  /// Recording video instruction
  ///
  /// In en, this message translates to:
  /// **'Recording video - Look straight at camera'**
  String get recordingVideoLookStraight;

  /// Cannot start video recording error
  ///
  /// In en, this message translates to:
  /// **'Cannot start video recording'**
  String get cannotStartVideoRecording;

  /// File not video error
  ///
  /// In en, this message translates to:
  /// **'Error: File is not a video. Please try again.'**
  String get errorFileNotVideo;

  /// Video and face images saved success message
  ///
  /// In en, this message translates to:
  /// **'Video and face images saved successfully!'**
  String get videoAndFaceImagesSavedSuccessfully;

  /// Error stopping video recording message
  ///
  /// In en, this message translates to:
  /// **'Error stopping video recording'**
  String get errorStoppingVideoRecording;

  /// Please enter full name validation
  ///
  /// In en, this message translates to:
  /// **'Please enter full name'**
  String get pleaseEnterFullName;

  /// Please select date of birth validation
  ///
  /// In en, this message translates to:
  /// **'Please select date of birth'**
  String get pleaseSelectDateOfBirth;

  /// Please select city validation
  ///
  /// In en, this message translates to:
  /// **'Please select city'**
  String get pleaseSelectCity;

  /// Please select ward validation
  ///
  /// In en, this message translates to:
  /// **'Please select ward/commune'**
  String get pleaseSelectWard;

  /// Please enter ID number validation
  ///
  /// In en, this message translates to:
  /// **'Please enter ID number'**
  String get pleaseEnterIdNumber;

  /// Please upload front image validation
  ///
  /// In en, this message translates to:
  /// **'Please upload front image'**
  String get pleaseUploadFrontImage;

  /// Please upload back image validation
  ///
  /// In en, this message translates to:
  /// **'Please upload back image'**
  String get pleaseUploadBackImage;

  /// Please record verification video validation
  ///
  /// In en, this message translates to:
  /// **'Please record verification video'**
  String get pleaseRecordVerificationVideo;

  /// Verification video invalid validation
  ///
  /// In en, this message translates to:
  /// **'Verification video is invalid'**
  String get verificationVideoInvalid;

  /// No face images validation
  ///
  /// In en, this message translates to:
  /// **'No face images. Please record video again.'**
  String get noFaceImagesPleaseRecordAgain;

  /// Please select country validation
  ///
  /// In en, this message translates to:
  /// **'Please select country'**
  String get pleaseSelectCountry;

  /// Please enter passport number validation
  ///
  /// In en, this message translates to:
  /// **'Please enter passport number'**
  String get pleaseEnterPassportNumber;

  /// Please upload passport image validation
  ///
  /// In en, this message translates to:
  /// **'Please upload passport image'**
  String get pleaseUploadPassportImage;

  /// Processing KYC message
  ///
  /// In en, this message translates to:
  /// **'Processing KYC...'**
  String get processingKYC;

  /// KYC submitted successfully message
  ///
  /// In en, this message translates to:
  /// **'KYC submitted successfully!'**
  String get kycSubmittedSuccessfully;

  /// Message when opening native camera
  ///
  /// In en, this message translates to:
  /// **'Opening Native Camera'**
  String get openingNativeCamera;

  /// Success message for native camera recording
  ///
  /// In en, this message translates to:
  /// **'Video recorded successfully with native camera'**
  String get videoRecordedSuccessfullyWithNativeCamera;

  /// Error message for failed video recording
  ///
  /// In en, this message translates to:
  /// **'Video recording failed, please try again'**
  String get videoRecordingFailedPleaseTryAgain;

  /// Camera error title
  ///
  /// In en, this message translates to:
  /// **'Camera Error'**
  String get cameraError;

  /// Record verification video title
  ///
  /// In en, this message translates to:
  /// **'Record Verification Video'**
  String get recordVerificationVideo;

  /// Record video instruction
  ///
  /// In en, this message translates to:
  /// **'Record video 30 seconds and capture 3 face angles automatically (straight, left, right)'**
  String get recordVideo30SecondsAndCapture3FaceAngles;

  /// Video recorded successfully status
  ///
  /// In en, this message translates to:
  /// **'Video recorded successfully'**
  String get videoRecordedSuccessfully;

  /// Message when all face angles are captured
  ///
  /// In en, this message translates to:
  /// **'Captured all 3 face angles'**
  String get capturedAll3FaceAngles;

  /// Button text to record video again
  ///
  /// In en, this message translates to:
  /// **'Record Video Again'**
  String get recordVideoAgain;

  /// Button text to start recording video
  ///
  /// In en, this message translates to:
  /// **'Start Recording Video'**
  String get startRecordingVideo;

  /// Instructions label
  ///
  /// In en, this message translates to:
  /// **'Instructions'**
  String get instructions;

  /// Instructions for video recording
  ///
  /// In en, this message translates to:
  /// **'Position your face in the camera frame and tap to start recording. The video will be recorded for verification purposes.'**
  String get videoRecordingInstructions;

  /// Error loading cities message
  ///
  /// In en, this message translates to:
  /// **'Error loading cities list'**
  String get errorLoadingCities;

  /// Error loading wards message
  ///
  /// In en, this message translates to:
  /// **'Error loading wards list'**
  String get errorLoadingWards;

  /// Error loading countries message
  ///
  /// In en, this message translates to:
  /// **'Error loading countries list'**
  String get errorLoadingCountries;

  /// Personal information label
  ///
  /// In en, this message translates to:
  /// **'Personal Information'**
  String get personalInformation;

  /// Enter your name hint
  ///
  /// In en, this message translates to:
  /// **'Enter your name'**
  String get enterYourName;

  /// Select date of birth hint
  ///
  /// In en, this message translates to:
  /// **'Select date of birth'**
  String get selectDateOfBirth;

  /// Personal documents label
  ///
  /// In en, this message translates to:
  /// **'Personal Documents'**
  String get personalDocuments;

  /// Front side label
  ///
  /// In en, this message translates to:
  /// **'Front Side'**
  String get frontSide;

  /// Back side label
  ///
  /// In en, this message translates to:
  /// **'Back Side'**
  String get backSide;

  /// Enter ID number hint
  ///
  /// In en, this message translates to:
  /// **'Enter ID number'**
  String get enterIdNumber;

  /// Invalid ID number validation
  ///
  /// In en, this message translates to:
  /// **'Invalid ID number'**
  String get invalidIdNumber;

  /// Upload button text
  ///
  /// In en, this message translates to:
  /// **'Upload'**
  String get upload;

  /// Open camera button text
  ///
  /// In en, this message translates to:
  /// **'Open Camera'**
  String get openCamera;

  /// Message when there is no overnight interest data
  ///
  /// In en, this message translates to:
  /// **'No overnight interest'**
  String get noOvernightInterest;

  /// Instruction message for holding DNPAY to receive daily interest
  ///
  /// In en, this message translates to:
  /// **'Hold DNPAY to receive daily interest'**
  String get holdDnpayToReceiveDailyInterest;

  /// Reward label
  ///
  /// In en, this message translates to:
  /// **'Reward'**
  String get reward;

  /// Penalty label
  ///
  /// In en, this message translates to:
  /// **'Penalty'**
  String get penalty;

  /// Error message when loading overnight interest data fails
  ///
  /// In en, this message translates to:
  /// **'Error loading overnight interest data'**
  String get errorLoadingOvernightInterest;

  /// Error message when refreshing data fails
  ///
  /// In en, this message translates to:
  /// **'Error refreshing data'**
  String get errorRefreshingData;

  /// Error message when loading more data fails
  ///
  /// In en, this message translates to:
  /// **'Error loading more data'**
  String get errorLoadingMoreData;

  /// Profile title
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// Transaction limit label
  ///
  /// In en, this message translates to:
  /// **'Transaction Limit'**
  String get transactionLimit;

  /// Your voucher menu item
  ///
  /// In en, this message translates to:
  /// **'Your Voucher'**
  String get yourVoucher;

  /// Logout confirmation message
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to logout?'**
  String get confirmLogout;

  /// Current password label
  ///
  /// In en, this message translates to:
  /// **'Current Password'**
  String get currentPassword;

  /// Current password validation message
  ///
  /// In en, this message translates to:
  /// **'Please enter current password'**
  String get pleaseEnterCurrentPassword;

  /// New password validation message
  ///
  /// In en, this message translates to:
  /// **'Please enter new password'**
  String get pleaseEnterNewPassword;

  /// Password length validation message
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 6 characters'**
  String get passwordMustBeAtLeast6Characters;

  /// Password confirmation validation message
  ///
  /// In en, this message translates to:
  /// **'Please confirm password'**
  String get pleaseConfirmPassword;

  /// Password confirmation mismatch message
  ///
  /// In en, this message translates to:
  /// **'Password confirmation does not match'**
  String get passwordConfirmationDoesNotMatch;

  /// Password change success message
  ///
  /// In en, this message translates to:
  /// **'Password changed successfully'**
  String get passwordChangedSuccessfully;

  /// New password validation message
  ///
  /// In en, this message translates to:
  /// **'New password must be different from current password'**
  String get newPasswordMustBeDifferentFromCurrent;

  /// Select language title
  ///
  /// In en, this message translates to:
  /// **'Select Language'**
  String get selectLanguageTitle;

  /// Select voucher title
  ///
  /// In en, this message translates to:
  /// **'Select Voucher'**
  String get selectVoucher;

  /// Apply location title
  ///
  /// In en, this message translates to:
  /// **'Apply Location'**
  String get applyLocation;

  /// Description title
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get description;

  /// Note title
  ///
  /// In en, this message translates to:
  /// **'Note'**
  String get note;

  /// Exchange voucher title
  ///
  /// In en, this message translates to:
  /// **'Exchange Voucher'**
  String get exchangeVoucher;

  /// Error message when loading checkout info fails
  ///
  /// In en, this message translates to:
  /// **'Error loading checkout information. Please try again later.'**
  String get errorLoadingCheckoutInfo;

  /// Brand name label
  ///
  /// In en, this message translates to:
  /// **'Brand Name'**
  String get brandName;

  /// Search by brand name hint
  ///
  /// In en, this message translates to:
  /// **'Search by brand name'**
  String get searchByBrandName;

  /// Category label
  ///
  /// In en, this message translates to:
  /// **'Category'**
  String get category;

  /// Province label
  ///
  /// In en, this message translates to:
  /// **'Province'**
  String get province;

  /// Quantity field label
  ///
  /// In en, this message translates to:
  /// **'Quantity'**
  String get quantity;

  /// Please select network first message
  ///
  /// In en, this message translates to:
  /// **'Please select network first'**
  String get pleaseSelectNetworkFirst;

  /// Wallet address label
  ///
  /// In en, this message translates to:
  /// **'Wallet Address'**
  String get walletAddress;

  /// Enter wallet address hint
  ///
  /// In en, this message translates to:
  /// **'Enter wallet address'**
  String get enterWalletAddress;

  /// Quantity field hint
  ///
  /// In en, this message translates to:
  /// **'Enter quantity'**
  String get enterQuantity;

  /// Max button text
  ///
  /// In en, this message translates to:
  /// **'Max'**
  String get max;

  /// Insufficient balance for fee message
  ///
  /// In en, this message translates to:
  /// **'Insufficient balance to pay fee'**
  String get insufficientBalanceForFee;

  /// Transaction summary title
  ///
  /// In en, this message translates to:
  /// **'Transaction Summary'**
  String get transactionSummary;

  /// Fee label
  ///
  /// In en, this message translates to:
  /// **'Fee'**
  String get fee;

  /// Network warning message part 1
  ///
  /// In en, this message translates to:
  /// **'The network you have chosen is'**
  String get networkWarningMessage;

  /// Network warning message part 2
  ///
  /// In en, this message translates to:
  /// **'please make sure that the network supports'**
  String get networkWarningMessage2;

  /// Withdrawal only text
  ///
  /// In en, this message translates to:
  /// **'withdrawal only'**
  String get withdrawalOnly;

  /// Network warning message part 3
  ///
  /// In en, this message translates to:
  /// **'You may lose your assets if the chosen platform does not support the completion of the wrong asset loading.'**
  String get networkWarningMessage3;

  /// OTP sent successfully message
  ///
  /// In en, this message translates to:
  /// **'OTP sent successfully'**
  String get otpSentSuccessfully;

  /// Error sending OTP message
  ///
  /// In en, this message translates to:
  /// **'Error sending OTP'**
  String get errorSendingOtp;

  /// Confirm withdraw title
  ///
  /// In en, this message translates to:
  /// **'Confirm Withdraw'**
  String get confirmWithdraw;

  /// Confirm OTP label
  ///
  /// In en, this message translates to:
  /// **'Confirm OTP'**
  String get confirmOtp;

  /// Withdraw confirmed successfully message
  ///
  /// In en, this message translates to:
  /// **'Withdraw confirmed successfully'**
  String get withdrawConfirmedSuccessfully;

  /// Error confirming withdraw message
  ///
  /// In en, this message translates to:
  /// **'Error confirming withdraw'**
  String get errorConfirmingWithdraw;

  /// Farming service label
  ///
  /// In en, this message translates to:
  /// **'Farming'**
  String get farming;

  /// My farming service label
  ///
  /// In en, this message translates to:
  /// **'My Farming'**
  String get myFarming;

  /// APR label
  ///
  /// In en, this message translates to:
  /// **'APR'**
  String get apr;

  /// Lock-up period label
  ///
  /// In en, this message translates to:
  /// **'Lock-up Period'**
  String get lockupPeriod;

  /// Cycle label
  ///
  /// In en, this message translates to:
  /// **'Cycle'**
  String get cycle;

  /// Start date label
  ///
  /// In en, this message translates to:
  /// **'Start Date'**
  String get startDate;

  /// Staking starts in countdown label
  ///
  /// In en, this message translates to:
  /// **'Staking starts in'**
  String get stakingStartsIn;

  /// Upcoming status
  ///
  /// In en, this message translates to:
  /// **'Upcoming'**
  String get upcoming;

  /// Active status
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get active;

  /// Ended status
  ///
  /// In en, this message translates to:
  /// **'Ended'**
  String get ended;

  /// Completed status
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get completed;

  /// Unknown status
  ///
  /// In en, this message translates to:
  /// **'Unknown'**
  String get unknown;

  /// Details button text
  ///
  /// In en, this message translates to:
  /// **'Details'**
  String get details;

  /// Days unit
  ///
  /// In en, this message translates to:
  /// **'days'**
  String get days;

  /// Hours unit
  ///
  /// In en, this message translates to:
  /// **'hours'**
  String get hours;

  /// Minutes unit
  ///
  /// In en, this message translates to:
  /// **'minutes'**
  String get minutes;

  /// Seconds unit
  ///
  /// In en, this message translates to:
  /// **'seconds'**
  String get seconds;

  /// Staking ends in countdown label
  ///
  /// In en, this message translates to:
  /// **'Staking ends in'**
  String get stakingEndsIn;

  /// Staked amount label
  ///
  /// In en, this message translates to:
  /// **'Staked Amount'**
  String get stakedAmount;

  /// Estimated profit label
  ///
  /// In en, this message translates to:
  /// **'Estimated Profit'**
  String get estimatedProfit;

  /// Rewards received label
  ///
  /// In en, this message translates to:
  /// **'Rewards Received'**
  String get rewardsReceived;

  /// Unstake time label
  ///
  /// In en, this message translates to:
  /// **'Unstake Time'**
  String get unstakeTime;

  /// Text shown when ready to start recording
  ///
  /// In en, this message translates to:
  /// **'Tap to Start Recording'**
  String get tapToStartRecording;

  /// Instructions for video recording
  ///
  /// In en, this message translates to:
  /// **'Position your face in the camera frame and tap to start recording. The video will be recorded for verification purposes.'**
  String get recordVideoInstructions;

  /// Button text to start recording
  ///
  /// In en, this message translates to:
  /// **'Start Recording'**
  String get startRecording;

  /// Label for captured face images
  ///
  /// In en, this message translates to:
  /// **'Captured Face Images'**
  String get capturedFaceImages;

  /// KYC verification title
  ///
  /// In en, this message translates to:
  /// **'KYC Verification'**
  String get kycVerification;

  /// Address field hint
  ///
  /// In en, this message translates to:
  /// **'Enter your address'**
  String get enterYourAddress;

  /// Address validation error
  ///
  /// In en, this message translates to:
  /// **'Please enter your address'**
  String get pleaseEnterYourAddress;

  /// Submit KYC button text
  ///
  /// In en, this message translates to:
  /// **'Submit KYC'**
  String get submitKyc;

  /// Starts in countdown label
  ///
  /// In en, this message translates to:
  /// **'Starts in'**
  String get startsIn;

  /// Ends in countdown label
  ///
  /// In en, this message translates to:
  /// **'Ends in'**
  String get endsIn;

  /// Ended at time label
  ///
  /// In en, this message translates to:
  /// **'Ended at'**
  String get endedAt;

  /// Time status label
  ///
  /// In en, this message translates to:
  /// **'Time Status'**
  String get timeStatus;

  /// Error message when image selection from gallery fails
  ///
  /// In en, this message translates to:
  /// **'Failed to select image. Please try again.'**
  String get imageSelectionFailed;

  /// General error message for unexpected problems
  ///
  /// In en, this message translates to:
  /// **'An unexpected problem occurred.'**
  String get unexpectedProblemOccurred;

  /// Error message when a required field is empty
  ///
  /// In en, this message translates to:
  /// **'This field is required'**
  String get fieldRequired;

  /// Error message when the amount is invalid
  ///
  /// In en, this message translates to:
  /// **'Invalid amount'**
  String get invalidAmount;

  /// Prompt to enter bank account number
  ///
  /// In en, this message translates to:
  /// **'Please enter bank account number'**
  String get enterBankAccountNumber;

  /// Error message when bank account number is invalid
  ///
  /// In en, this message translates to:
  /// **'Invalid bank account number (8-20 digits)'**
  String get invalidBankAccountNumber;

  /// Label for bank account number field
  ///
  /// In en, this message translates to:
  /// **'Bank account number'**
  String get bankAccountNumber;

  /// Label for transfer amount field
  ///
  /// In en, this message translates to:
  /// **'Transfer amount'**
  String get transferAmount;

  /// Transfer page title
  ///
  /// In en, this message translates to:
  /// **'Transfer'**
  String get transferTitle;

  /// Account number field hint
  ///
  /// In en, this message translates to:
  /// **'Account Number'**
  String get enterAccountNumber;

  /// Recipient field label
  ///
  /// In en, this message translates to:
  /// **'Recipient'**
  String get recipient;

  /// Recipient field hint
  ///
  /// In en, this message translates to:
  /// **'Recipient'**
  String get enterRecipient;

  /// Content field hint
  ///
  /// In en, this message translates to:
  /// **'Enter content'**
  String get enterContent;

  /// 2FA title
  ///
  /// In en, this message translates to:
  /// **'Two-Factor Authentication'**
  String get twoFactorAuthentication;

  /// Activate 2FA button text
  ///
  /// In en, this message translates to:
  /// **'Activate 2FA'**
  String get activate2FA;

  /// Deactivate 2FA button text
  ///
  /// In en, this message translates to:
  /// **'Deactivate 2FA'**
  String get deactivate2FA;

  /// 2FA description text
  ///
  /// In en, this message translates to:
  /// **'Use Google Authenticator to protect your account with an additional layer of security'**
  String get twoFactorAuthenticationDescription;

  /// 2FA active description text
  ///
  /// In en, this message translates to:
  /// **'Google Authenticator is currently protecting your account'**
  String get twoFactorAuthenticationActiveDescription;

  /// 2FA status label
  ///
  /// In en, this message translates to:
  /// **'2FA Status'**
  String get twoFactorAuthenticationStatus;

  /// 2FA active status
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get twoFactorAuthenticationActive;

  /// 2FA inactive status
  ///
  /// In en, this message translates to:
  /// **'Inactive'**
  String get twoFactorAuthenticationInactive;

  /// Setup 2FA title
  ///
  /// In en, this message translates to:
  /// **'Setup Two-Factor Authentication'**
  String get setupTwoFactorAuthentication;

  /// QR code instruction
  ///
  /// In en, this message translates to:
  /// **'Scan this QR code with Google Authenticator app'**
  String get scanQRCodeWithGoogleAuthenticator;

  /// Manual secret key instruction
  ///
  /// In en, this message translates to:
  /// **'Or enter this secret key manually:'**
  String get enterSecretKeyManually;

  /// Secret key label
  ///
  /// In en, this message translates to:
  /// **'Secret Key'**
  String get secretKey;

  /// Copy secret key button
  ///
  /// In en, this message translates to:
  /// **'Copy Secret Key'**
  String get copySecretKey;

  /// Secret key copied message
  ///
  /// In en, this message translates to:
  /// **'Secret key copied to clipboard'**
  String get secretKeyCopied;

  /// Continue to verification button
  ///
  /// In en, this message translates to:
  /// **'Continue to Verification'**
  String get continueToVerification;

  /// Verify OTP title
  ///
  /// In en, this message translates to:
  /// **'Verify OTP Code'**
  String get verifyOTPCode;

  /// OTP instruction
  ///
  /// In en, this message translates to:
  /// **'Enter the 6-digit code from your authenticator app'**
  String get enter6DigitCodeFromAuthenticator;

  /// Back to setup button
  ///
  /// In en, this message translates to:
  /// **'Back to Setup'**
  String get backToSetup;

  /// 2FA activation success message
  ///
  /// In en, this message translates to:
  /// **'2FA has been activated successfully!'**
  String get twoFactorAuthenticationActivated;

  /// 2FA deactivation success message
  ///
  /// In en, this message translates to:
  /// **'2FA has been deactivated successfully!'**
  String get twoFactorAuthenticationDeactivated;

  /// 2FA activation failed message
  ///
  /// In en, this message translates to:
  /// **'Failed to activate 2FA'**
  String get twoFactorAuthenticationActivationFailed;

  /// 2FA deactivation failed message
  ///
  /// In en, this message translates to:
  /// **'Failed to deactivate 2FA'**
  String get twoFactorAuthenticationDeactivationFailed;

  /// OTP verification failed message
  ///
  /// In en, this message translates to:
  /// **'OTP verification failed'**
  String get otpVerificationFailed;

  /// OTP validation message
  ///
  /// In en, this message translates to:
  /// **'Please enter all 6 OTP digits'**
  String get pleaseEnter6DigitOTP;

  /// Deactivate 2FA confirmation message
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to deactivate two-factor authentication? This will make your account less secure.'**
  String get deactivate2FAConfirmation;

  /// Deactivate 2FA confirmation title
  ///
  /// In en, this message translates to:
  /// **'Deactivate 2FA'**
  String get deactivate2FAConfirmationTitle;

  /// Deactivate 2FA OTP instruction
  ///
  /// In en, this message translates to:
  /// **'Enter the 6-digit code to deactivate 2FA'**
  String get enter6DigitCodeToDeactivate;

  /// Cancel button text
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// Google Authenticator app name
  ///
  /// In en, this message translates to:
  /// **'Google Authenticator'**
  String get googleAuthenticator;

  /// QR Code label
  ///
  /// In en, this message translates to:
  /// **'QR Code'**
  String get qrCode;

  /// QR Code error message
  ///
  /// In en, this message translates to:
  /// **'QR Code Error'**
  String get qrCodeError;

  /// Minimum transfer amount validation message
  ///
  /// In en, this message translates to:
  /// **'Amount must be greater than 5,000'**
  String get minimumTransferAmount;

  /// KYC notification message
  ///
  /// In en, this message translates to:
  /// **'Please complete identity verification.'**
  String get pleaseCompleteIdentityVerification;

  /// Here link text for KYC notification
  ///
  /// In en, this message translates to:
  /// **'Here'**
  String get here;

  /// KYC pending screen title
  ///
  /// In en, this message translates to:
  /// **'KYC PENDING'**
  String get kycPendingTitle;

  /// KYC pending description text
  ///
  /// In en, this message translates to:
  /// **'Verification is being processed. We will notify you as soon as it is complete.'**
  String get kycPendingDescription;

  /// Back home button text
  ///
  /// In en, this message translates to:
  /// **'Back Home'**
  String get backHome;

  /// KYC status title
  ///
  /// In en, this message translates to:
  /// **'KYC Status'**
  String get kycStatus;

  /// Authentication app menu item
  ///
  /// In en, this message translates to:
  /// **'Authentication app'**
  String get authenticationApp;

  /// QR payment transaction type
  ///
  /// In en, this message translates to:
  /// **'QR Payment'**
  String get qrPayment;

  /// Confirm QR payment title
  ///
  /// In en, this message translates to:
  /// **'Confirm QR Payment'**
  String get confirmQrPayment;

  /// Home tab label in bottom navigation
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get homeTab;

  /// History tab label in bottom navigation
  ///
  /// In en, this message translates to:
  /// **'History'**
  String get historyTab;

  /// Voucher tab label in bottom navigation
  ///
  /// In en, this message translates to:
  /// **'Voucher'**
  String get voucherTab;

  /// Profile tab label in bottom navigation
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profileTab;

  /// Farming tab label
  ///
  /// In en, this message translates to:
  /// **'Farming'**
  String get farmingTab;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'vi'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'vi':
      return AppLocalizationsVi();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
