import 'package:postervibe/presentation/widget/app_bar.dart';
import 'package:postervibe/presentation/widget/app_button.dart';
import 'package:postervibe/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:postervibe/core/app_export.dart';

class NoYetNotificationScreen extends StatelessWidget {
  const NoYetNotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(text: "notifications".tr,isLeading: true),
      extendBodyBehindAppBar: true,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Image(
              image: AssetImage(AppImage.notificationbell),
              width: 200,
              height: 150,
            ),
            hBox(40),
            Text(
              'nonotificationyet'.tr,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            hBox(20),
            Text(
              "whenyougetnotificaiontheyllshowuphere".tr,
              style: const TextStyle(
                fontSize: 16,
                color: Color(0xff414141),
              ),
              textAlign: TextAlign.center,
            ),
            hBox(60),
            AppButton(
              text: "return".tr,
              onPressed: () {
                Get.toNamed(AppRoute.notification);
              },
            )
          ],
        ),
      ),
    );
  }
}
