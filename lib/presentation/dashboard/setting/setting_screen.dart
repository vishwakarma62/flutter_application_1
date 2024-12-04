import 'package:postervibe/presentation/widget/app_bar.dart';
import 'package:postervibe/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:postervibe/presentation/dashboard/setting/setting_controller.dart';
import '../../../core/app_export.dart';

class SettingScreen extends StatelessWidget {
  SettingScreen({super.key});
  final SettingController _controller = Get.put(SettingController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(
        text: "settings".tr,
        isLeading: true,
      
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        physics: const ClampingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            hSizedBox10,
            heading("account".tr),
            hSizedBox10,
            settingList(
              icon: AppImage.personInfo,
              title: 'personalinformation'.tr,
            ),
            hSizedBox20,
            heading('other'.tr),
            hSizedBox10,
            settingList(
              icon: AppImage.fb,
              title: 'contactus'.tr,
              navigation: () {
                Get.toNamed(AppRoute.contactUs);
              },
            ),
            hSizedBox10,
          ],
        ),
      ),
    );
  }

  Text heading(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget settingList({
    required String title,
    required String icon,
    bool isSwitch = false,
    String? subtitle,
    bool? value,
    Function(bool)? onToggle,
    Function()? navigation,
  }) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
      onTap: navigation,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      tileColor: Get.isDarkMode ? Colors.black :  AppColors.screenlightBlue,
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: SvgPicture.asset(
          icon,
          fit: BoxFit.scaleDown,
          height: 20,
          width: 20,
        ),
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          color: Color(0xff8E8E93),
        ),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            subtitle ?? "",
            style: const TextStyle(
              fontSize: 16,
              color: Color(0xff8E8E93),
            ),
          ),
          if (isSwitch)
            FlutterSwitch(
              toggleColor:  AppColors.screenlightBlue,
              width: 50.0,
              height: 30.0,
              valueFontSize: 25.0,
              toggleSize: 15.0,
              value: value ?? false,
              borderRadius: 30.0,
              padding: 8.0,
              showOnOff: false,
              activeColor: const Color(0xFF111526),
              inactiveColor: Colors.white,
              onToggle: onToggle!,
            )
          else
            const Icon(
              Icons.chevron_right,
              color: Color(0xffBCBFC3),
            ),
        ],
      ),
    );
  }
}
