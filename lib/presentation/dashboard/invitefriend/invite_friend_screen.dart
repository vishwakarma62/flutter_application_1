import 'package:postervibe/core/app_export.dart';
import 'package:postervibe/presentation/dashboard/inviteFriend/invite_friend_controller.dart';
import 'package:postervibe/presentation/widget/app_bar.dart';
import 'package:postervibe/presentation/widget/app_button.dart';
import 'package:postervibe/presentation/widget/app_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class InviteFriendScreen extends StatelessWidget {
  InviteFriendScreen({super.key});
  final InviteFriendController _controller = Get.put(InviteFriendController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(
        isLeading: true,
        back: true,
        text: "invitefriends".tr,
        action: true,
      ),
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Column(
          children: [
            SizedBox(
              height: Get.height / 3,
              child: const Image(
                fit: BoxFit.cover,
                image: AssetImage(AppImage.invite),
              ),
            ),
            hSizedBox10,
            Text(
              'invitefriends'.tr,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            hSizedBox14,
            Text(
              "whenyourfrindssignupwithyourlinkyoullbothgetcharge".tr,
              textAlign: TextAlign.center,
              style: const TextStyle(height: 1.6),
            ),
            hBox(40),
            AppTextField(
              hintText: "link".tr,
              obscureText: true,
              onChange: (val) {
                _controller.link.value = val;
              },
              errorMessage: _controller.linkError,
              prefixIcon: AppImage.link,
              suffixIcon: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    margin: const EdgeInsets.only(right: 15),
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                        color: AppColors.backgroundColor,
                        borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: SvgPicture.asset(AppImage.copy),
                    ),
                  ),
                ],
              ),
            ),
            hSizedBox20,
            AppButton(
              text: "invitefriends".tr,
              onPressed: () {
                _controller.onInviteFriend();
              },
            )
          ],
        ),
      ),
    );
  }
}
