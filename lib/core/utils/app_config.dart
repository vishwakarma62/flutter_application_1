import 'package:path_provider/path_provider.dart';
import 'package:intl/intl.dart';
class AppConfig {
  static const String api500Error = '500 Server not found!';
  static const String noInternetText = 'No Internet Connection!';

  // Snackbar tittle messages
  static const String snackbarSuccessTitle = 'Success';
  static const String snackbarErrorTitle = 'Error';

  // Snackbar Error messages
  static const String snackbarErrorMessage =
      'An error occurred while deleting the image.';
  static const String fetchListErrorMessage =
      'An error occurred during fetching list.';
  static const String userLoginErrorMessage =
      'An error occurred during user login.';
  static const String userRegisterErrorMessage =
      'An error occurred during user Registeration.';
  static const String cannotShareMessage = 'Cannot share.';
  static const String imageDownloadErrorMessage =
      'An error occurred while downloading image.';
   static const String snackbarNoMoreScroll = 'no more scroll'; 
  static const String fetchMoreDataErrorMessage =
      'An error occurred during fetching more data.';
  static const String failedToLoadImage = 'Failed to load image.';
  static const String anErrorOccurred =
      'An error occurred. Please try again later.';
  static const String userCheckingError =
      'An error occurred during user checking.';

// Snackbar Success messages
  static const String snackbarSuccessMessage = 'Image deleted successfully.';
  static const String imageDownloadSuccessMessage =
      'Image download successful.';
  static const String imageShareSuccessMessage = 'Image shared successfully.';

  // Firebase related error messages
  static const String invalidPhoneNumber = 'Invalid phone number format.';
  static const String phoneVerificationQuotaExceeded =
      'Phone verification quota exceeded.';
  static const String phoneAlreadyInUse = 'Phone number already in use.';
  static const String recaptchaCheckFailed = 'reCAPTCHA check failed.';
  static const String appNotAuthorized =
      'App not authorized for phone authentication.';
  static const String userDisabled = 'The user account has been disabled.';
  static const String userNotFound = 'User not found.';
  static const String tooManyRequests =
      'Too many verification requests. Please try again later.';
  static const String sessionExpired =
      'Verification session expired. Please try again.';
  static const String invalidVerificationCode = 'Invalid verification code.';
  static const String missingVerificationCode = 'Missing verification code.';
  static const String invalidVerificationId = 'Invalid verification ID.';
  static const String credentialAlreadyInUse = 'Phone number already in use.';
  static const String networkRequestFailed =
      'Network request failed. Please check your internet connection.';
  static const String invalidRecipient =
      'Invalid recipient for verification code.';
  static const String genericFirebaseAuthError =
      'Firebase Authentication Error';
  static const String genericNetworkError =
      'Network request failed. Please check your internet connection.';
  static const String verificationErrorPhone =
      'An error occurred while verifying the phone number';
  static const String verificationErrorOtp =
      'An error occurred while verifying otp';
  static const String firebaseAuthError = 'Firebase Authentication Error';

  // Confirmation dialogue
  // tittle
  static const String exitAppTittle = 'Exit App';
  static const String deleteTittle = 'Are You Sure?';
  static const String updateTitle = 'Update Your Application';

  // content
  static const String updateContent =
      'Update available! Get the latest version now.';
  static const String updateText = 'Update Now';
  static const String deleteContent = 'Do you want to delete this post?';
  static const String yes = 'Yes';
  static const String no = 'No';
  static const String exitAppContent = 'Are you sure you want to exit?';

  // Add unit Ids
  static String _androidInterstitialAdUnitId = '';
  static String _androidBannerAdUnitId = '';
  static String _iosInterstitialAdUnitId = '';
  static String _iosBannerAdUnitId = '';

  // Base url
  static String _appBaseUrl = "https://api.postervibe.com/api";

  // Getter and setter for Android Interstitial Ad Unit ID
  static String get androidInterstitialAdUnitId => _androidInterstitialAdUnitId;
  static set setandroidInterstitialAdUnitId(String value) =>
      _androidInterstitialAdUnitId = value;

  // Getter and setter for Android Banner Ad Unit ID
  static String get androidBannerAdUnitId => _androidBannerAdUnitId;
  static set setandroidBannerAdUnitId(String value) =>
      _androidBannerAdUnitId = value;

  // Getter and setter for iOS Interstitial Ad Unit ID
  static String get iosInterstitialAdUnitId => _iosInterstitialAdUnitId;
  static set setiosInterstitialAdUnitId(String value) =>
      _iosInterstitialAdUnitId = value;

  // Getter and setter for iOS Banner Ad Unit ID
  static String get iosBannerAdUnitId => _iosBannerAdUnitId;
  static set setiosBannerAdUnitId(String value) => _iosBannerAdUnitId = value;

  // Getter for Base URL
  static String get baseUrl => _appBaseUrl;
  static set setappBaseUrl(String value) => _appBaseUrl = value;

  // Getter for local directory path using temporary directory
  static Future<String> getLocalDirectoryPath({String fileNameSuffix = '',String appName= 'PosterVibe'}) async {
    final tempDir = await getTemporaryDirectory();
    String fileName = '$appName-${DateFormat('ddMMyyyyHHmmss').format(DateTime.now())}$fileNameSuffix.jpg';
    return '${tempDir.path}/$fileName';
  }


  
}
