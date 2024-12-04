import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:postervibe/core/app_export.dart';
import 'package:postervibe/core/packages/otp/animation_type.dart';
import 'package:postervibe/core/packages/otp/pin_theme.dart';
import 'package:postervibe/presentation/auth/verification_code/verification_code_controller.dart';
import 'package:postervibe/presentation/widget/app_bar.dart';
import 'package:postervibe/presentation/widget/app_button.dart';
import 'package:postervibe/presentation/widget/app_text.dart';
import 'package:timer_count_down/timer_count_down.dart';

import '../../../core/packages/otp/otp_text_field.dart';

class VerificationCodeScreen extends StatelessWidget {
  VerificationCodeScreen({super.key});

  final VerificationCodeController _controller =
      Get.put(VerificationCodeController());
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBar(isLeading: false),
        body: Obx(() {
          if (_controller.connectivityManager.isConnected.value == true) {
            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  hSizedBox40,
                  SizedBox(
                    height: 100,
                    width: 150,
                    child: SvgPicture.asset(AppImage.logo),
                  ),
                  hSizedBox10,
                  title('Verification code was sent to'),
                  hBox(10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      disc(_controller.currentText,
                          fontWeight: FontWeight.normal,
                          color: AppColors.appTextBlack),
                      wSizedBox20,
                      InkWell(
                        onTap: () {
                          Get.back();
                        },
                        child: SvgPicture.asset(AppImage.editnumber),
                      ),
                    ],
                  ),
                  hSizedBox50,
                  Form(
                    key: _formKey,
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 14),
                        child: PinCodeTextField(
                          controller: _controller.textEditingController,
                          appContext: context,
                          length: 6,
                          obscureText: false,
                          animationType: AnimationType.fade,
                          pinTheme: PinTheme(
                            shape: PinCodeFieldShape.box,
                            borderRadius: BorderRadius.circular(10),
                            activeFillColor: Colors.white,
                            activeColor: AppColors.appBluePurple,
                            selectedFillColor: AppColors.darkBlueBlack,
                            selectedColor: AppColors.darkBlueBlack,
                            inactiveFillColor: Colors.white,
                            inactiveColor: const Color(0xffF4F5FA),
                          ),
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          animationDuration: const Duration(milliseconds: 300),
                          enableActiveFill: true,
                          onCompleted: (v) {
                            _controller.otp.value = v;
                          },
                          onChanged: (value) {
                            _controller.otp.value = value;
                          },
                          beforeTextPaste: (text) {
                            return true;
                          },
                        ),
                      ),
                    ),
                  ),
                  hSizedBox30,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      disc('Enter your OTP code in ',
                          fontSize: 14, color: AppColors.appTextBlack),
                      Countdown(
                        seconds: 30,
                        controller: _controller.countdownController,
                        build: (BuildContext context, double time) => disc(
                          "${secondToDurationForTimer(second: time)} ",
                          fontSize: 14,
                          color: AppColors.darkBlueBlack,
                          fontWeight: FontWeight.bold,
                        ),
                        interval: const Duration(seconds: 1),
                        onFinished: () {
                          _controller.hideUnHideReSend(true);
                        },
                      ),
                      disc('mins',
                          fontSize: 14, color: AppColors.appTextBlack),
                    ],
                  ),
                  hSizedBox30,
                  disc(
                    "I didn't receive a code",
                    fontSize: 14,
                    color: AppColors.appTextBlack,
                  ),
                  hSizedBox8,
                  Obx(
                    () => InkWell(
                      onTap: _controller.isResend.value
                          ? () {
                              _controller.textEditingController.clear();
                              _controller.hideUnHideReSend(false);
                              _controller.onResendOtp();
                            }
                          : null,
                      child: Text(
                        'Resend Code',
                        style: TextStyle(
                          fontSize: 14,
                          color: _controller.isResend.value
                              ? const Color(0xff5D54B3)
                              : Colors.grey, // Set disabled color
                          decoration: _controller.isResend.value
                              ? TextDecoration.underline
                              : TextDecoration
                                  .none, // Remove underline when disabled
                          decorationColor: const Color(0xff5D54B3),
                        ),
                      ),
                    ),
                  ),
                  hSizedBox25,
                  Obx(
                    () => AppButton(
                      loader: _controller.isLoading.value,
                      text: "Submit".tr,
                      onPressed: _controller.isLoading.value
                          ? () {}
                          : () {
                              _controller.onEnterOtpAsync();
                            },
                    ),
                  ),
                  hSizedBox14
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

  String secondToDurationForTimer({required double second}) {
    if (second != 0.0) {
      final convertedSecond = double.parse(second.toStringAsFixed(0)).toInt();
      final duration = Duration(seconds: convertedSecond);
      final minutes = duration.inMinutes.remainder(60);
      final remainingSeconds = duration.inSeconds.remainder(60);
      return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
    } else {
      return "00:00";
    }
  }
}
