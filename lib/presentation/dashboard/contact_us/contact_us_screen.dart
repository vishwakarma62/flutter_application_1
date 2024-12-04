// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:postervibe/core/app_export.dart';
import 'package:postervibe/presentation/dashboard/contact_us/contact_us_controller.dart';
import 'package:postervibe/presentation/widget/app_bar.dart';
import 'package:postervibe/presentation/widget/no_internet.dart';

class ContactUsScreen extends StatelessWidget {
  final ContactUsController contactUsController =
      Get.put(ContactUsController());

  ContactUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: appBar(
          text: contactUsController.connectivityManager.isConnected.value
              ? "contactus".tr
              : '',
          isLeading: true,
        ),
        body: Obx(() {
          if (contactUsController.connectivityManager.isConnected.value) {
            return SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      width: Get.width / 2,
                      height: Get.width / 2,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Theme.of(context).cardColor,
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.asset(
                          AppImage.ContactUs,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  contact(
                    icon: Icons.email,
                    title: "Email",
                    info: "support@postervibe.com",
                  ),
                ],
              ),
            );
          } else {
            return NoInternetWidget();
          }
        }),
      ),
    );
  }

  Widget contact({
    required IconData icon,
    required String title,
    required String info,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(
            icon,
            size: 24,
            color: AppColors.appBluePurple,
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.appBluePurple,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                info,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
