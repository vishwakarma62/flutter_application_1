import 'package:postervibe/presentation/dashboard/add_business/business_detail.dart';
import 'package:postervibe/presentation/auth/login_signup/components/signup/my_profile.dart';
import 'package:postervibe/presentation/dashboard/category/category_screen.dart';
import 'package:postervibe/presentation/dashboard/contact_us/contact_us_screen.dart';
import 'package:postervibe/presentation/dashboard/events_and_posts/all_event_and_post_screen.dart';
import 'package:postervibe/presentation/dashboard/events_and_posts/event_and_post_screen.dart';
import '../core/app_export.dart';

import '../presentation/auth/splash/splash_screen.dart';
import '../presentation/auth/verification_code/verification_code_screen.dart';
import '../presentation/auth/verify_phone_number/verify_phone_number_screen.dart';
import '../presentation/bottom_bar/bottom_bar_screen.dart';

import '../presentation/dashboard/digital_post/digital_post_screen.dart';
import '../presentation/dashboard/download/download_screen.dart';
import '../presentation/dashboard/filter/filter_screen.dart';
import '../presentation/dashboard/faq/faq_screen.dart';
import '../presentation/dashboard/home/home_screen.dart';
import '../presentation/dashboard/inviteFriend/invite_friend_screen.dart';
import '../presentation/dashboard/language/language_screen.dart';
import '../presentation/dashboard/my_business_list/my_business_list_screen.dart';
import '../presentation/dashboard/notification/component/no_notification_screen.dart';
import '../presentation/dashboard/notification/notification_screen.dart';
import '../presentation/dashboard/payment/payment_screen.dart';
import '../presentation/dashboard/post_editor/post_editor_screen.dart';
import '../presentation/dashboard/premium/premium_screen.dart';
import '../presentation/dashboard/preview/preview_screen.dart';
import '../presentation/dashboard/review/review_screen.dart';
import '../presentation/dashboard/search/search_screen.dart';
import '../presentation/dashboard/select_business_category/select_business_category_screen.dart';
import '../presentation/dashboard/setting/setting_screen.dart';
import '../presentation/dashboard/share/share_screen.dart';

class AppRoute {
  static String splash = '/splash';
  static String home = '/home';
  static String intro = '/intro';
  static String login = '/login';
  static String verificationCode = '/verificationCode';
  static String passWordRecovery = '/passWordRecovery';
  static String verifyPhoneNumber = '/verifyPhoneNumber';
  static String createPassword = '/createPassword';
  static String bottom = '/bottom';
  static String digitalPost = '/digitalPost';
  static String notification = '/notification';
  static String premium = '/premium';
  static String editProfile = '/editProfile';
  static String setting = '/setting';
  static String preview = '/preview';
  static String invite = '/invite';
  static String filter = '/Filter';
  static String post = '/post';
  static String review = '/review';
  static String payment = '/payment';
  static String contactUs = '/contactUs';
  static String share = '/share';
  static String language = '/language';
  static String faq = '/faq';
  static String noYetNotification = '/noYetNotification';
  static String download = '/download';
  static String search = '/search';
  static String findPasswordOption = '/findPasswordOption';
  static String myBusinessList = '/myBusinessList';
  static String selectBusinessCategory = '/selectBusinessCategory';
  static String addCompany = '/addCompany';
  static String postEditor = '/postEditor';
  static String myProfile = '/myProfile';
  static String businessDetail = '/businessDetail';
  static String eventAndPost = '/eventAndPost';
  static String category = '/category';
  static String demoScreen = '/demoScreen';

  static List<GetPage> pages = [
    GetPage(name: splash, page: () => const SplashScreen()),
    GetPage(name: home, page: () => const HomeScreen()),
    GetPage(name: myProfile, page: () => MyProfile()),
    GetPage(name: category, page: () => const CategoryScreen()),
    GetPage(name: businessDetail, page: () => const BusinessDetail()),
    GetPage(name: verificationCode, page: () => VerificationCodeScreen()),
    GetPage(name: verifyPhoneNumber, page: () => VerifyPhoneNumberScreen()),
    GetPage(name: bottom, page: () => BottomBarScreen()),
    GetPage(name: digitalPost, page: () => DigitalPostScreen()),
    GetPage(name: notification, page: () => NotificationScreen()),
    GetPage(name: premium, page: () => PremiumScreen()),
    GetPage(name: setting, page: () => SettingScreen()),
    GetPage(name: preview, page: () => PreviewScreen()),
    GetPage(name: invite, page: () => InviteFriendScreen()),
    GetPage(name: filter, page: () => FiltersScreen()),
    GetPage(name: post, page: () => const AllEventAndPostScreen()),
    GetPage(name: review, page: () => ReviewScreen()),
    GetPage(name: payment, page: () => PaymentScreen()),
    GetPage(name: contactUs, page: () => ContactUsScreen()),
    GetPage(name: share, page: () => const ShareScreen()),
    GetPage(name: language, page: () => LanguageScreen()),
    GetPage(name: faq, page: () => FAQScreen()),
    GetPage(
        name: noYetNotification, page: () => const NoYetNotificationScreen()),
    GetPage(name: download, page: () => const DownloadScreen()),
    GetPage(name: search, page: () => SearchScreen()),
    GetPage(name: myBusinessList, page: () => const MyBusinessListScreen()),
    GetPage(
        name: selectBusinessCategory,
        page: () => SelectBusinessCategoryScreen()),
    GetPage(name: postEditor, page: () => const PostEditorScreen()),
    GetPage(name: eventAndPost, page: () => const EventAndPostScreen()),
  ];
}
