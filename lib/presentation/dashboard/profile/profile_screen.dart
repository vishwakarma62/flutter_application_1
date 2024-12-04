import 'dart:io';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:lottie/lottie.dart';
import 'package:postervibe/core/local_storage.dart';
import 'package:postervibe/core/utils/loader.dart';
import 'package:postervibe/presentation/ad/ad_type.dart';
import 'package:postervibe/presentation/ad/ad_unit_id.dart';
import 'package:postervibe/presentation/ad/simple_banner.dart';
import 'package:postervibe/presentation/widget/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:postervibe/core/app_export.dart';
import 'package:postervibe/presentation/dashboard/profile/profile_controller.dart';
import 'package:postervibe/routes/app_routes.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ProfileController _controller = Get.put(ProfileController());
  late double height;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    height = max(size.height * .05, 50.0);
    return Scaffold(
        bottomNavigationBar: Builder(
          builder: (BuildContext context) {
            if (_controller.bottomBarController.shouldShowAdAvailable) {
              return AdmobBanner(
                adUnitId: AdUnitIds.getTestAdUnitId(adType: AdType.banner),
                adSize: AdSize.banner,
              );
            }
            return const SizedBox.shrink();
          },
        ),
        appBar: appBar(
          text: "profile".tr,
          onPressLeading: () {},
        ),
        body: Obx(() {
          if (_controller.connectivityManager.isConnected.value == true) {
            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                children: [
                  hBox(Get.height * .05),
                  Container(
                    height: 105,
                    width: 105,
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(
                        color: Colors.white,
                        width: 2,
                      ),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: _controller.bottomBarController.userProfileImage
                                .value.isEmpty
                            ? LocalStorage.profileImage.isEmpty
                                ? const AssetImage(AppImage.defaultImage)
                                : NetworkImage(LocalStorage.profileImage)
                                    as ImageProvider
                            : NetworkImage(_controller.bottomBarController
                                .userProfileImage.value) as ImageProvider,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(.16),
                          blurRadius: 6,
                        ),
                      ],
                    ),
                  ),
                  hSizedBox10,
                  Text(
                    _controller.bottomBarController.userName.value,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  hSizedBox8,
                  Text(
                    '+91 ${_controller.bottomBarController.mobileNumber.value}',
                    style: const TextStyle(
                      fontSize: 14,
                      color: Color(0xff8B8989),
                    ),
                  ),
                  hSizedBox8,
                  Text(
                    _controller.bottomBarController.userEmail.value,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Color(0xff8B8989),
                    ),
                  ),
                  hSizedBox30,
                  profileList(
                    icon: SvgPicture.asset(
                      AppImage.iconProfileAcc,
                      fit: BoxFit.scaleDown,
                      height: 20,
                      width: 20,
                    ),
                    title: 'Edit Profile'.tr,
                    navigation: () {
                      Get.toNamed(AppRoute.myProfile, arguments: ['', true]);
                    },
                  ),
                  hSizedBox10,
                  profileList(
                    icon: ConstrainedBox(
                      constraints: const BoxConstraints(),
                      child: const Icon(
                        Icons.business_center_outlined,
                        color: Colors.black,
                      ),
                    ),
                    title: 'My Busineess List'.tr,
                    navigation: () {
                      Get.toNamed(AppRoute.myBusinessList);
                    },
                  ),
                  hSizedBox10,
                  profileList(
                    icon: ConstrainedBox(
                      constraints: const BoxConstraints(),
                      child: const Icon(
                        Icons.alternate_email_outlined,
                        color: Colors.black,
                      ),
                    ),
                    title: 'Contact Us'.tr,
                    navigation: () {
                      Get.toNamed(AppRoute.contactUs);
                    },
                  ),
                  hSizedBox10,
                  profileList(
                    icon: SvgPicture.asset(
                      AppImage.logout,
                      fit: BoxFit.scaleDown,
                      height: 20,
                      width: 20,
                    ),
                    title: 'Logout'.tr,
                    navigation: () {
                      Platform.isIOS
                          ? showDialog(
                              barrierColor: const Color.fromRGBO(0, 0, 0, 0.76),
                              context: context,
                              builder: (BuildContext context) {
                                return CupertinoAlertDialog(
                                  title: Text(
                                    "logout".tr,
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  content: Text(
                                    "areyousureyouwanttologout".tr,
                                  ),
                                  actions: <Widget>[
                                    CupertinoDialogAction(
                                      isDefaultAction: true,
                                      child: Text(
                                        "cancel".tr,
                                        style: const TextStyle(
                                          fontSize: 18,
                                          color: Colors.blue,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      onPressed: () => Get.back(),
                                    ),
                                    CupertinoDialogAction(
                                      child: Text(
                                        "logout".tr,
                                        style: const TextStyle(
                                          fontSize: 18,
                                          color: Colors.red,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      onPressed: () {
                                        LocalStorage.clearLocalData();
                                        Get.offAllNamed(AppRoute.login);
                                      },
                                    )
                                  ],
                                );
                              })
                          : DialogueHelper.logoutDialog(
                              title: "logout".tr,
                              description: "areyousureyouwanttologout".tr,
                              color: AppColors.darkShadeBlue,
                              context: Get.context!,
                              onTap: () {
                                LocalStorage.clearLocalData();
                                Get.offAllNamed(AppRoute.verifyPhoneNumber);
                              },
                            );
                    },
                  ),
                  SizedBox(
                    height:
                        _controller.bottomBarController.shouldShowAdAvailable
                            ? height + 10
                            : 10,
                  )
                ],
              ),
            );
          }
          return Center(
            child: SizedBox(
              height: 100,
              width: 100,
              child: Lottie.asset(AppImage.noInternet),
            ),
          );
        }));
  }

  Widget profileList({
    required String title,
    required Widget icon, // Accepts any Widget type
    required Function() navigation,
  }) {
    return ListTile(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      tileColor: Get.isDarkMode ? Colors.black : AppColors.screenlightBlue,
      onTap: navigation,
      leading: Container(
        width: 35,
        height: 35,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: icon, // Use the provided icon directly
      ),
      title: Text(
        title,
        style: const TextStyle(fontSize: 16),
      ),
      trailing: const Icon(
        Icons.chevron_right,
        color: Color(0xffBCBFC3),
      ),
    );
  }
}
