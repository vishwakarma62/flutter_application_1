import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:lottie/lottie.dart';
import 'package:get/get.dart';
import 'package:postervibe/core/app_export.dart';
import 'package:postervibe/core/utils/app_config.dart';
import 'package:postervibe/core/utils/loader.dart';
import 'package:postervibe/presentation/ad/ad_type.dart';
import 'package:postervibe/presentation/ad/ad_unit_id.dart';
import 'package:postervibe/presentation/ad/simple_banner.dart';
import 'package:postervibe/presentation/bottom_bar/bottom_bar_controller.dart';
import 'package:postervibe/presentation/dashboard/download/download_screen.dart';
import 'package:postervibe/presentation/dashboard/events_and_posts/all_event_and_post_screen.dart';
import 'package:postervibe/presentation/dashboard/home/home_screen.dart';
import 'package:postervibe/presentation/dashboard/profile/profile_screen.dart';

class BottomBarScreen extends StatelessWidget {
  BottomBarScreen({Key? key}) : super(key: key);

  final BottomBarController _controller = Get.put(BottomBarController());
  DateTime? lastPressed;

  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: () async {
        DateTime now = DateTime.now();
        if (_controller.selectIndex.value != 0) {
          _controller.selectIndex.value = 0;
          return false;
        } else if (lastPressed == null ||
            now.difference(lastPressed!) > const Duration(seconds: 2)) {
          lastPressed = now;
          bool? exit = await Future.delayed(
            const Duration(milliseconds: 100),
            () => DialogueHelper.showConfirmationDialog(
              context: context,
              confirmButton: MaterialButton(
                onPressed: () {
                  Get.back(result: true);
                },
                child: const Text(AppConfig.yes),
              ),
              cancelButton: MaterialButton(
                onPressed: () {
                  Get.back(result: false, closeOverlays: true);
                },
                child: const Text(AppConfig.no),
              ), 
              dialogTitle: AppConfig.exitAppTittle,
              dialogContent: AppConfig.exitAppContent,
            ),
          );
          return exit ?? false;
        }
        return false;
      },
      child: Scaffold(
        body: Obx(
          () => _controller.connectivityManager.isConnected.value == true
              ? _buildBody(_controller.selectIndex.value)
              : Center(
                  child: SizedBox(
                    height: 100,
                    width: 100,
                    child: Lottie.asset(AppImage.noInternet),
                  ),
                ),
        ),
        bottomSheet: Obx(() {
          if (_controller.isDisplayAd.value) {
            return _controller.selectIndex.value == 1
                ? const SizedBox.shrink()
                : AdmobBanner(
                    adUnitId: AdUnitIds.getTestAdUnitId(adType: AdType.banner),
                    adSize: AdSize.banner,
                  );
          }

          return const SizedBox.shrink();
        }),
        bottomNavigationBar: Container(
          height: 70,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 5)],
            color: Get.isDarkMode ? Colors.black : Colors.white,
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(20),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(
              _controller.list.length,
              (index) => Obx(
                () => Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () {
                        _controller.selectIndex.value = index;
                      },
                      icon: SvgPicture.asset(
                        _controller.list[index]['image'],
                        color: _controller.selectIndex.value == index
                            ? AppColors.appBluePurple
                            : AppColors.appTextBlack,
                      ),
                    ),],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBody(int currentIndex) {
    switch (currentIndex) {
      case 0:
        return const HomeScreen();
      case 1:
        return const AllEventAndPostScreen();
      case 2:
        return const DownloadScreen();
      case 4:
        return const ProfileScreen();
      default:
        return const ProfileScreen();
    }
  }
}
