import 'package:postervibe/presentation/widget/app_bar.dart';
import 'package:postervibe/presentation/widget/app_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:postervibe/core/app_export.dart';
import 'package:postervibe/presentation/dashboard/review/review_controler.dart';

class ReviewScreen extends StatelessWidget {
  ReviewScreen({super.key});
  final ReviewController _controller = Get.put(ReviewController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(
        isLeading: true,
        text: "review".tr,
        action: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
        child: Column(
          children: [
            SizedBox(
              height: Get.height / 4,
              child: const Image(
                image: AssetImage(AppImage.design),
              ),
            ),
            hSizedBox20,
            Text(
              'review'.tr,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            hSizedBox16,
            Text(
              "whenyourfrindssignupwithyourlinkyoullbothgetcharge".tr,
              style: const TextStyle(
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
            ),
            hBox(35),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
                border: Border.all(
                  color: AppColors.appBluePurple,
                  width: 2,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Hey Joe!',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                  TextField(
                    maxLines: 3,
                    onChanged: (val) {
                      _controller.message.value = val;
                      _controller.messageError.value = "";
                    },
                    decoration: InputDecoration(
                      hintText: '${"writeyourmessagehere".tr} ...',
                      hintStyle: const TextStyle(
                        color: Color(0xff8B8989),
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                      fillColor: Colors.black,
                      border: InputBorder.none,
                    ),
                  ),
                ],
              ),
            ),
            Obx(
              () => (_controller.messageError.value.isNotEmpty)
                  ? Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        height: 25,
                        color: Colors.transparent,
                        child: Text(
                          _controller.messageError.value,
                          style:
                              const TextStyle(color: Colors.red, fontSize: 11),
                        ),
                      ),
                    )
                  : Container(),
            ),
            hBox(25),
            Row(
              children: [
                Obx(
                  () => FlutterSwitch(
                      width: 45.0,
                      height: 30.0,
                      valueFontSize: 25.0,
                      toggleSize: 15.0,
                      value: _controller.status.value,
                      borderRadius: 30.0,
                      padding: 5.0,
                      inactiveToggleColor: const Color(0xFF111526),
                      activeColor: Colors.transparent,
                      inactiveColor: Colors.transparent,
                      showOnOff: false,
                      switchBorder: Border.all(
                        color: const Color(0xffCDD4F5),
                        width: 4,
                      ),
                      onToggle: (value) {
                        _controller.status.value = value;
                      }),
                ),
                wSizedBox10,
                Expanded(
                  child: Text(
                    'shareyourmessagewithothertaxipassenger'.tr,
                    style: const TextStyle(
                      height: 1.6,
                      fontSize: 14,
                    ),
                  ),
                ),
                wSizedBox10,
                Stack(
                  children: [
                    sharePassengers(margin: 0),
                    sharePassengers(margin: 10),
                    sharePassengers(margin: 20),
                    sharePassengers(margin: 30),
                  ],
                )
              ],
            ),
            hSizedBox30,
            AppButton(
              text: "submit".tr,
              onPressed: () {
                _controller.onSubmit();
              },
            )
          ],
        ),
      ),
    );
  }

  Container sharePassengers({required double margin}) {
    return Container(
      margin: EdgeInsets.only(left: margin),
      width: 25,
      height: 25,
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.white, width: 2),
        image: const DecorationImage(
          image: AssetImage(AppImage.profile),
        ),
      ),
    );
  }
}
