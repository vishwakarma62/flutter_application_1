import 'package:flutter_svg/svg.dart';
import 'package:postervibe/presentation/auth/splash/splash_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:postervibe/core/app_export.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(SplashController());
    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
              alignment: Alignment.center,
              height: Get.height,
              width: Get.width,
              color: const Color(0xFF111526),
              child: SvgPicture.asset(semanticsLabel: 'splash',
                AppImage.appIcon,
                height: Get.height * .15,
                width: Get.height * .15,
              )),
        ],
      ),
    );
  }
}
