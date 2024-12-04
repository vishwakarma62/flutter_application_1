import 'package:postervibe/core/utils/app_config.dart';

class Endpoints {
  Endpoints._();

  // loginurl
  static String loginUser = '${AppConfig.baseUrl}/v1/MobileUser/Login';

  //singUp url
  static String signUpUser = '${AppConfig.baseUrl}/v1/MobileUser/Register';
  //
  static String checkUserRegister =
      '${AppConfig.baseUrl}/v1/MobileUser/CheckUserRegistered';
  static String getDashBoardEventPostList =
      '${AppConfig.baseUrl}/v1/MobileDashboard/GetDashboardEventPostList';
  static String bannerList = '${AppConfig.baseUrl}/v1/Banner/GetBannerList';
  static String refreshToken = '${AppConfig.baseUrl}/v1/User/RefreshToken';

  static String getCategoruList =
      '${AppConfig.baseUrl}/v1/MobileCategory/GetCategoryList';
  static String GetTodaysEventList =
      '${AppConfig.baseUrl}/v1/MobileDashboard/GetTodayEventList';
  static String GetEventPostByEventId =
      '${AppConfig.baseUrl}/v1/MobileEventPost/GetEventPostList';
  static String getMyBusinessList =
      '${AppConfig.baseUrl}/v1/MobileBusinessDetail/GetBusinessDetailList';
  static String getBusinessCategoryNameList =
      '${AppConfig.baseUrl}/v1/MobileBusinessDetail/GetBusinesssCategoryList';
  static String addAndUpdateBusiness =
      '${AppConfig.baseUrl}/v1/MobileBusinessDetail/Upsert';
  static String deleteBusiness =
      '${AppConfig.baseUrl}/v1/MobileBusinessDetail/Delete';

  static String businessById =
      '${AppConfig.baseUrl}/v1/MobileBusinessDetail/GetBusinessDetailById';

  static String profileUpdate =
      "${AppConfig.baseUrl}/v1/MobileUser/UpdateUserProfile";

  static String getEventList =
      "${AppConfig.baseUrl}/v1/MobileEvent/GetEventList";
  static String getEventPostList =
      "${AppConfig.baseUrl}/v1/MobileEventPost/GetEventPostList";

  static String appVersion = "${AppConfig.baseUrl}/v1/User/GetMobileSettings";

  static String downloadPost = "${AppConfig.baseUrl}/v1/MobileMyPost/Upsert";
  static String getMyPost =
      "${AppConfig.baseUrl}/v1/MobileMyPost/GetMyPostList";
  static String deletePost = "${AppConfig.baseUrl}/v1/MobileMyPost/Delete";
}
