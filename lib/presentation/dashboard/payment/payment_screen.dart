import 'package:postervibe/presentation/dashboard/payment/payment_controller.dart';
import 'package:postervibe/presentation/widget/app_bar.dart';
import 'package:postervibe/presentation/widget/app_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:postervibe/core/app_export.dart';
import 'package:postervibe/presentation/widget/app_text_field.dart';

class PaymentScreen extends StatelessWidget {
  PaymentScreen({super.key});
  final PaymentController _controller = Get.put(PaymentController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(
        text: "payment".tr,
        action: true,
      ),
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Column(
          children: [
            SizedBox(
              height: Get.height / 3.5,
              child: const Image(
                image: AssetImage(AppImage.payment),
              ),
            ),
            hSizedBox30,
            Text(
              'addnewcard'.tr,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            hSizedBox10,
            Text(
              'addyourdebitcreaditcard'.tr,
              style: const TextStyle(fontSize: 14),
            ),
            hSizedBox30,
            AppTextField(
                hintText: "cardholdername".tr,
                prefixIcon: AppImage.userName,
                onChange: (val) {
                  _controller.cardName.value = val;
                  _controller.cardNameError.value;
                },
                errorMessage: _controller.cardNameError),
            hSizedBox20,
            AppTextField(
              hintText: "**** **** **** ****",
              prefixIcon: AppImage.wallet,
              errorMessage: _controller.cardNameError,
              onChange: (val) {
                _controller.cardNo.value = val;
                _controller.cardNoError.value;
              },
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                CardNumberFormatter(),
                LengthLimitingTextInputFormatter(19),
              ],
            ),
            hSizedBox20,
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {
                          _controller.selectDate(context);
                        },
                        child: Container(
                          alignment: Alignment.center,
                          height: 58,
                          width: Get.width,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                                color: AppColors.appBluePurple, width: 2),
                          ),
                          child: Obx(
                            () => _controller.selectedDate.value ==
                                    DateTime(0, 0, 0)
                                ? Text(
                                    " ${"month".tr} / ${"year".tr}",
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: Color(0xff4B4B4B),
                                      fontWeight: FontWeight.w500,
                                    ),
                                  )
                                : Text(
                                    "${_controller.selectedDate.value.month.toString().padLeft(2, "0")}/${_controller.selectedDate.value.year}",
                                    style: const TextStyle(
                                      color: Color(0xff7E7E7E),
                                    ),
                                  ),
                          ),
                        ),
                      ),
                      Obx(
                        () => (_controller.dateError.value.isNotEmpty)
                            ? Align(
                                alignment: Alignment.centerLeft,
                                child: Container(
                                  color: Colors.transparent,
                                  child: Text(
                                    _controller.dateError.value,
                                    style: const TextStyle(
                                      color: Colors.red,
                                      fontSize: 11,
                                    ),
                                  ),
                                ),
                              )
                            : hSizedBox8,
                      )
                    ],
                  ),
                ),
                wSizedBox10,
                Expanded(
                  child: AppTextField(
                    border: true,
                    hintText: "* * *",
                    radius: 10,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(3),
                    ],
                    onChange: (val) {
                      _controller.cvv.value = val;
                      _controller.cvvError.value;
                    },
                    errorMessage: _controller.cvvError,
                  ),
                )
              ],
            ),
            hSizedBox10,
            hBox(25),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: AppButton(
                text: "add".tr,
                onPressed: () {
                  _controller.onAdd();
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
