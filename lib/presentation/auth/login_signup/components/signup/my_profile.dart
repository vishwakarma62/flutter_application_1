import 'package:lottie/lottie.dart';
import 'package:postervibe/core/local_storage.dart';
import 'package:postervibe/presentation/auth/login_signup/components/signup/sign_up_controller.dart';

import 'package:postervibe/presentation/widget/app_bar.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../../core/app_export.dart';

import '../../../../widget/app_button.dart';
import '../../../../widget/app_text_field.dart';

class MyProfile extends StatelessWidget {
  MyProfile({super.key});
  final SignUpController _controller = Get.put(SignUpController());
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
          appBar: appBar(
              isLeading: true,
              text: _controller.connectivityManager.isConnected.value
                  ? 'myprofile'.tr
                  : ''),
          body: Obx(
            () {
              if (_controller.connectivityManager.isConnected.value == true) {
                return Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              hSizedBox36,
                              if (_controller.isEdit == true)
                                Stack(
                                  clipBehavior: Clip.none,
                                  children: [
                                    Obx(
                                      () => Container(
                                        height: 105,
                                        width: 105,
                                        decoration: BoxDecoration(
                                          color: Colors.transparent,
                                          borderRadius:
                                              BorderRadius.circular(18),
                                          border: Border.all(
                                            color: Colors.white,
                                            width: 2,
                                          ),
                                          image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: _controller.profileImage
                                                    .value.path.isEmpty
                                                ? LocalStorage
                                                        .profileImage.isEmpty
                                                    ? const AssetImage(
                                                        AppImage.defaultImage)
                                                    : NetworkImage(LocalStorage
                                                            .profileImage)
                                                        as ImageProvider
                                                : FileImage(_controller
                                                    .profileImage.value),
                                          ),
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.black.withOpacity(.16),
                                              blurRadius: 6,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        _controller
                                            .pickProfileFile(Get.context);
                                      },
                                      child: Container(
                                        margin: const EdgeInsets.only(
                                          top: 105 - 17,
                                          left: 105 / 2 - 17,
                                        ),
                                        width: 34,
                                        height: 34,
                                        decoration: const BoxDecoration(
                                          image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: AssetImage(
                                                  AppImage.editprofile)),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              hSizedBox30,
                              if (_controller.isEdit == false)
                                Text(
                                  "registerinbyenteringyouraccountdetails".tr,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(fontSize: 16),
                                ),
                              const SizedBox(height: 20),
                              AppTextField(
                                onChange: (p0) {
                                  _controller.firstNameError.value = '';
                                },
                                hintText: 'firstname'.tr,
                                prefixIcon: AppImage.userName,
                                controller: _controller.rfirstName.value,
                                errorMessage: _controller.firstNameError,
                              ),
                              hSizedBox10,
                              AppTextField(
                                onChange: (p0) {
                                  _controller.lastNameError.value = '';
                                },
                                hintText: 'lastname'.tr,
                                prefixIcon: AppImage.userName,
                                controller: _controller.rlastName.value,
                                errorMessage: _controller.lastNameError,
                              ),
                              hSizedBox10,
                              AppTextField(
                                readonly: _controller.isEdit ? true : false,
                                hintText: 'emailaddress'.tr,
                                prefixIcon: AppImage.email,
                                controller: _controller.rEmail.value,
                                errorMessage: _controller.rEmailError,
                                onChange: (p0) {
                                  _controller.rEmailError.value = '';
                                },
                              ),
                              hSizedBox10,
                              Obx(
                                () => AppTextField(
                                  onChange: (p0) {
                                    _controller.rphoneNoError.value = '';
                                  },
                                  controller: _controller.rphoneNomber.value,
                                  readonly: true,
                                  icon: false,
                                  hintText: "phonenumber".tr,
                                  prefixIcon: _controller.generateCode(
                                    _controller.countryCode.value?['dial_code']
                                            .toString() ??
                                        "+91",
                                  ),
                                  keyboardType: TextInputType.number,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                  errorMessage: _controller.rphoneNoError,
                                ),
                              ),
                              hSizedBox10,
                            ],
                          ),
                        ),
                      ),
                      Obx(
                        () => AppButton(
                          text: 'Save'.tr,
                          loader: _controller.isLoading.value,
                          onPressed: () {
                            _controller.isEdit
                                ? _controller.updatProfile()
                                : _controller.onSignUp();
                          },
                        ),
                      )
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
            },
          )),
    );
  }
}
