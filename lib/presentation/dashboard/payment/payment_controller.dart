import 'package:postervibe/core/app_export.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:month_year_picker/month_year_picker.dart';

class PaymentController extends GetxController {
  RxString cardNo = "".obs;
  RxString cardNoError = "".obs;
  RxString cardName = "".obs;
  RxString cardNameError = "".obs;
  RxString date = "".obs;
  RxString dateError = "".obs;
  RxString cvv = "".obs;
  RxString cvvError = "".obs;
  Rx<DateTime> selectedDate = Rx<DateTime>(DateTime(0, 0, 0));

  bool validate() {
    RxBool isValid = true.obs;

    if (cardName.value.isEmpty) {
      cardNameError.value = "entervalidname".tr;
      isValid.value = false;
    }
    if (cardNo.value.isEmpty) {
      cardNoError.value = "entervalidnumber".tr;
      isValid.value = false;
    } else if (!Helper.isCardNumber(cardNo.value)) {
      cardNoError.value = "thecardnumbermustcontainatleast16character".tr;
      isValid.value = false;
    }

    if (selectedDate.value == DateTime(0, 0, 0)) {
      dateError.value = "selectexpiredate".tr;
      isValid.value = false;
    }

    if (cvv.value.isEmpty) {
      cvvError.value = "entersecuritycode".tr;
      isValid.value = false;
    } else if (!Helper.iscvv(cvv.value)) {
      cvvError.value = "thesecuritycodemustcontainatleast3character".tr;
      isValid.value = false;
    }

    return isValid.value;
  }

  selectDate(BuildContext context) async {
    DateTime? selected = await showMonthYearPicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2010),
      lastDate: DateTime(2025),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(
              primary: AppColors.primaryColor,
              onPrimary: Colors.white,
              surface: AppColors.primaryColor,
              onSurface: Colors.black,
            ),
            dialogBackgroundColor: AppColors.secondaryColor,
          ),
          child: child!,
        );
      },
    );

    if (selected != selectedDate.value) {
      selectedDate.value = selected ?? selectedDate.value;

      debugPrint("date\$$selected");
    }
  }

  onAdd() {
    if (validate()) {
      print("success");
    } else {
      print("error");
    }
  }
}

class CardNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    // ignore: avoid_renaming_method_parameters
    TextEditingValue previousValue,
    // ignore: avoid_renaming_method_parameters
    TextEditingValue nextValue,
  ) {
    var inputText = nextValue.text;

    if (nextValue.selection.baseOffset == 0) {
      return nextValue;
    }

    var bufferString = StringBuffer();
    for (int i = 0; i < inputText.length; i++) {
      bufferString.write(inputText[i]);
      var nonZeroIndexValue = i + 1;
      if (nonZeroIndexValue % 4 == 0 && nonZeroIndexValue != inputText.length) {
        bufferString.write(' ');
      }
    }

    var string = bufferString.toString();
    return nextValue.copyWith(
      text: string,
      selection: TextSelection.collapsed(
        offset: string.length,
      ),
    );
  }
}
