import 'package:postervibe/core/app_prefs.dart';
import 'package:postervibe/data/model/my_business_list_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:get_storage/get_storage.dart';

class LocalStorage {
  static String token = "";

  static RxString selectedBusinessId = "".obs;
  static RxString selectedBusinessName = "".obs;
  static RxString selectedBusinessLogo = ''.obs;
  static RxString selectedBusinessPhone1 = "".obs;
  static RxString selectedBusinessPhone2 = "".obs;
  static RxString selectedBusinessEmail = "".obs;
  static RxString selectedBusinessAddress = "".obs;
  static RxString selectedBusinessWebsite = "".obs;
  static RxString selectedBusinessCategory = "".obs;
  static String profileImage = "";

  static String userId = "";
  static String firstName = "";
  static String lasttName = "";
  static String countryCode = "";
  static String userMobile = "";
  static String? userProfile = "";
  static String userEmail = "";
  static String jwtToken = "";
  static String refreshToken = "";

  static String provider = "";
  static String userName = "";
  static String deviceId = "";
  static String deviceToken = "";
  static String deviceType = "";
  static String supportNumber = "";

  static bool loginStatus = false;

  static String local = 'en';
  static String languageName = 'English';

  static int selectBusiness = 0;

  static setAuthToken(json) async {
    final prefs = GetStorage();
    prefs.write(Prefs.jwtToken, json['jwtToken']);
    prefs.write(Prefs.refreshToken, json['refreshToken']);
    jwtToken = prefs.read(Prefs.jwtToken) ?? "";
    refreshToken = prefs.read(Prefs.refreshToken) ?? "";
  }

  static void storeDataInfo(json) async {
    final prefs = GetStorage();
    //* Store UserId
    prefs.write(Prefs.userId, json['id']);
    //* Store firstName
    prefs.write(Prefs.firstName, json['firstName']);
    //* Store lastName
    prefs.write(Prefs.lastName, json['lastName']);
    //* Store Country code
    prefs.write(Prefs.countryCode, json['countryCode'].toString());
    //* Store mobile
    prefs.write(Prefs.mobile, json['phoneNumber'].toString());
    //* Store email
    prefs.write(Prefs.email, json['email'] ?? "");
    //* Store profileImage
    prefs.write(Prefs.profileImage, json['profileImage'] ?? "");
    //* Store logging
    prefs.write(Prefs.isLogging, json['login_status']);
    //* set data
    userId = prefs.read(Prefs.userId) ?? "";
    firstName = prefs.read(Prefs.firstName) ?? "";
    lasttName = prefs.read(Prefs.lastName) ?? "";
    countryCode = prefs.read(Prefs.countryCode) ?? "";
    userMobile = prefs.read(Prefs.mobile) ?? "";
    userEmail = prefs.read(Prefs.email) ?? "";
    profileImage = prefs.read(Prefs.profileImage) ?? "";
    loginStatus = prefs.read(Prefs.isLogging) ?? false;
    setAuthToken(json);
  }

  static void storeProfileInfo(json) async {
    final prefs = GetStorage();

    // //* Store userID
    prefs.write(Prefs.userId, json['id']);
    // //* Store fullName
    prefs.write(Prefs.firstName, json['firstName']);
    // //* Store email
    prefs.write(Prefs.lastName, json['lastName'] ?? "");
    // //* Store profileImage
    if (json['profileImage'] != null) {
      prefs.write(Prefs.profileImage, json['profileImage']);
    }
    // //* Store mobile
    prefs.write(Prefs.countryCode, json['countryCode'] ?? '+91');

    //* set data
    firstName = prefs.read(Prefs.firstName) ?? '';
    lasttName = prefs.read(Prefs.lastName) ?? '';
    profileImage = prefs.read(Prefs.profileImage) ?? '';
    countryCode = prefs.read(Prefs.countryCode) ?? '';
  }

  static void storeDeviceInfo(
    String deviceID,
    String deviceTOKEN,
    String deviceTYPE,
    String supportNUMBER,
  ) async {
    final prefs = GetStorage();
    try {
      const url = 'https://api.ipify.org';
      var response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        prefs.write(Prefs.deviceIP, response.body);
      } else {}
    } catch (exception) {
      print(exception);
    }
    //* Store device id
    prefs.write(Prefs.deviceID, deviceID);
    //* Store device token
    prefs.write(Prefs.deviceFCMToken, deviceTOKEN);
    //* Store device type
    prefs.write(Prefs.deviceType, deviceTYPE);
    prefs.write(Prefs.supportNumber, supportNUMBER);

    //* set data
    deviceId = prefs.read(Prefs.deviceID);
    deviceToken = prefs.read(Prefs.deviceFCMToken);
    deviceType = prefs.read(Prefs.deviceType);
    supportNumber = prefs.read(Prefs.supportNumber);
  }

  static void selectLanguage(String lang) async {
    Get.updateLocale(Get.locale!);

    final prefs = GetStorage();
    prefs.write(Prefs.selectLanguage, Get.locale!.toString());
    prefs.write(Prefs.selectLanguageName, lang);
    local = prefs.read(Prefs.selectLanguage);
    languageName = prefs.read(Prefs.selectLanguageName);
    loadLocalData();
  }

  static void selectBusinessIndex(myBusinessData? myBusinessData) {
    final prefs = GetStorage();

    prefs.write(Prefs.selectedBusinessId, myBusinessData?.id);
    prefs.write(Prefs.selectedBusinessLogo, myBusinessData?.logo);
    prefs.write(Prefs.selectedBusinessName, myBusinessData?.businessName);
    prefs.write(Prefs.selectedBusinessEmail, myBusinessData?.email);
    prefs.write(Prefs.selectedBusinessAddress, myBusinessData?.address);
    prefs.write(Prefs.selectedBusinessPhone1, myBusinessData?.phoneNumber1);
    prefs.write(Prefs.selectedBusinessPhone2, myBusinessData?.phoneNumber2);
    prefs.write(Prefs.selectedBusinessWebsite, myBusinessData?.website);

    ///prefs.write(Prefs.selectedBusiness, index);

    selectedBusinessId.value = prefs.read(Prefs.selectedBusinessId) ?? '';
    selectedBusinessLogo.value = prefs.read(Prefs.selectedBusinessLogo) ?? '';
    selectedBusinessName.value = prefs.read(Prefs.selectedBusinessName) ?? '';
    selectedBusinessEmail.value = prefs.read(Prefs.selectedBusinessEmail) ?? '';
    selectedBusinessAddress.value =
        prefs.read(Prefs.selectedBusinessAddress) ?? '';
    selectedBusinessPhone1.value =
        prefs.read(Prefs.selectedBusinessPhone1) ?? '';
    selectedBusinessPhone2.value =
        prefs.read(Prefs.selectedBusinessPhone2) ?? '';
    selectedBusinessWebsite.value =
        prefs.read(Prefs.selectedBusinessWebsite) ?? '';
  }

  static void clearSelectedBusinessData() {
    final prefs = GetStorage();

    prefs.remove(Prefs.selectedBusinessId);
    prefs.remove(Prefs.selectedBusinessLogo);
    selectedBusinessLogo.value = '';
    selectedBusinessId.value = '';

    selectedBusinessName.value = '';
    selectedBusinessEmail.value = '';
    selectedBusinessAddress.value = '';
    selectedBusinessPhone1.value = '';
    selectedBusinessPhone2.value = '';
    selectedBusinessWebsite.value = '';
  }

  static void loadLocalData() {
    final prefs = GetStorage();

    userEmail = prefs.read(Prefs.email) ?? "";
    firstName = prefs.read(Prefs.firstName) ?? "";
    lasttName = prefs.read(Prefs.lastName) ?? "";
    profileImage = prefs.read(Prefs.profileImage) ?? '';
    userMobile = prefs.read(Prefs.mobile) ?? "";
    local = prefs.read(Prefs.selectLanguage) ?? 'en';
    languageName = prefs.read(Prefs.selectLanguageName) ?? 'English';
    provider = prefs.read(Prefs.provider) ?? "";
    loginStatus = prefs.read(Prefs.isLogging) ?? false;
    countryCode = prefs.read(Prefs.countryCode) ?? "";
    userId = prefs.read(Prefs.userId) ?? "";

//business id//
    selectedBusinessId = RxString(prefs.read(Prefs.selectedBusinessId) ?? '');

//business logo//
    selectedBusinessLogo =
        RxString(prefs.read(Prefs.selectedBusinessLogo) ?? '');

//business name//
    selectedBusinessName =
        RxString(prefs.read(Prefs.selectedBusinessName) ?? '');

//business email//
    selectedBusinessEmail =
        RxString(prefs.read(Prefs.selectedBusinessEmail) ?? '');

//business address//
    selectedBusinessAddress =
        RxString(prefs.read(Prefs.selectedBusinessAddress) ?? '');

    //business phone1//
    selectedBusinessPhone1 =
        RxString(prefs.read(Prefs.selectedBusinessPhone1) ?? '');

    //business phone2//
    selectedBusinessPhone2 =
        RxString(prefs.read(Prefs.selectedBusinessPhone2) ?? '');

    //business website//
    selectedBusinessWebsite =
        RxString(prefs.read(Prefs.selectedBusinessWebsite) ?? '');
  }

  static void clearLocalData() {
    GetStorage().erase();
    loadLocalData();
  }
}
