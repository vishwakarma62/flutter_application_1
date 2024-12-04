import 'package:postervibe/presentation/widget/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:postervibe/core/app_export.dart';

import '../../widget/app_text_field.dart';

class ShareScreen extends StatelessWidget {
  const ShareScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          appBar: appBar(
            isLeading: true,
            text: "share".tr,
            action: true,
          ),
          body: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: ConstrainedBox(
              constraints: constraints.copyWith(
                minHeight:
                    constraints.maxHeight - kToolbarHeight - kToolbarHeight,
                maxHeight: double.infinity,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      SizedBox(
                        height: Get.height / 4,
                        child: const Image(
                          image: AssetImage(AppImage.sharescreen),
                        ),
                      ),
                      hSizedBox10,
                      Text(
                        'shareyourlink'.tr,
                        style: const TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: [
                        Expanded(
                          child: AppTextField(
                            hintText: 'Xh54Dj684vgd654',
                            errorMessage: "".obs,
                          ),
                        ),
                        wSizedBox10,
                        Container(
                          width: 55,
                          height: 55,
                          decoration: BoxDecoration(
                            color: AppColors.darkBlueBlack,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Icon(
                            Icons.link,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    width: Get.width,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          const BorderRadius.vertical(top: Radius.circular(15)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(.06),
                          blurRadius: 20,
                          offset: const Offset(0.0, 3.0),
                        )
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'sharetoyourfriendbyusingthese'.tr,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 15,
                            color: AppColors.appTextBlack,
                          ),
                        ),
                        hSizedBox20,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            hSizedBox0,
                            tollSocial(
                              icon: AppImage.facebookShare,
                              title: 'Facebook',
                            ),
                            tollSocial(
                              icon: AppImage.twitterShare,
                              title: 'Twitter',
                            ),
                            tollSocial(
                              icon: AppImage.insatgramShare,
                              title: 'Instagram',
                            ),
                            hSizedBox0,
                          ],
                        ),
                        hSizedBox20,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            hSizedBox0,
                            tollSocial(
                              icon: AppImage.googleShare,
                              title: 'Google',
                            ),
                            tollSocial(
                              icon: AppImage.whatsapp,
                              title: 'Whatsapp',
                            ),
                            tollSocial(
                              icon: AppImage.lineShare,
                              title: 'Line',
                            ),
                            hSizedBox0,
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget tollSocial({
    required String icon,
    required String title,
  }) {
    return GestureDetector(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            width: Get.width * .15,
            height: Get.width * .15,
            decoration: BoxDecoration(
                color: AppColors.screenlightBlue,
                borderRadius: BorderRadius.circular(10)),
            child: SvgPicture.asset(
              icon,
              fit: BoxFit.scaleDown,
            ),
          ),
          hSizedBox16,
          Text(
            title,
            style: TextStyle(
              color: AppColors.appTextBlack,
            ),
          )
        ],
      ),
    );
  }
}
