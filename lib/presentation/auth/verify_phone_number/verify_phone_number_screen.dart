import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';
import 'package:postervibe/core/app_export.dart';
import 'package:postervibe/presentation/auth/verify_phone_number/verify_phone_number_controller.dart';
import 'package:postervibe/presentation/widget/app_button.dart';
import 'package:postervibe/presentation/widget/app_text.dart';
import 'package:postervibe/presentation/widget/app_text_field.dart';

class VerifyPhoneNumberScreen extends StatelessWidget {
  VerifyPhoneNumberScreen({super.key});

  final VerifyPhoneNumberController _controller =
      Get.put(VerifyPhoneNumberController());

  Widget buildLogo() {
    return SizedBox(
      height: 100,
      width: 150,
      child: SvgPicture.asset(AppImage.logo),
    );
  }

  Widget buildTitle() {
    return title('Phone Verification');
  }

  Widget buildDescription() {
    return disc('We need to register your phone before getting started',
        fontWeight: FontWeight.normal, color: Colors.grey[700]);
  }

  Widget buildPhoneNumberField(BuildContext context) {
    return Obx(
      () => AppTextField(
        key: Key('phoneNumberField'),
        icon: false,
        hintText: "Phone Number",
        prefixIcon: _controller.generatecode(
          _controller.countryCode.value?['dial_code'].toString() ?? "+91",
        ),
        keyboardType: TextInputType.number,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
          LengthLimitingTextInputFormatter(10),
        ],
        errorMessage: _controller.phoneNoError,
        onChange: (val) {
          _controller.phoneNO.value = val;
          _controller.phoneNoError.value = "";
          if (Helper.isPhoneNumber(_controller.phoneNO.value)) {
            FocusScopeNode currentFocus = FocusScope.of(context);
            if (!currentFocus.hasPrimaryFocus) {
              currentFocus.unfocus();
            }
          }
        },
      ),
    );
  }

  Widget buildSendOTPButton() {
    return Obx(
      () => AppButton(
        color: _controller.phoneNO.value.length == 10 ? null : Colors.grey,
        loader: _controller.isLoading.value,
        text: "Send OTP",
        onPressed: _controller.phoneNO.value.isNotEmpty &&
                _controller.isLoading.value == false
            ? () {
                _controller.onVerifyPhoneNumber();
              }
            : null,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        body: Obx(() {
          if (_controller.connectivityManager.isConnected.value == true) {
            return Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              alignment: Alignment.center,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    buildLogo(),
                    SizedBox(height: 25),
                    buildTitle(),
                    hSizedBox10,
                    buildDescription(),
                    SizedBox(height: 30),
                    buildPhoneNumberField(context),
                    SizedBox(height: 20),
                    buildSendOTPButton(),
                  ],
                ),
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
        }),
      ),
    );
  }
}
