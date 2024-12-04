import 'package:postervibe/core/app_export.dart';

class ReviewController extends GetxController {
  RxBool status = false.obs;

  RxString message = "".obs;
  RxString messageError = "".obs;

  bool valid() {
    RxBool isValid = true.obs;
    messageError.value = '';

    if (message.value.isEmpty) {
      messageError.value = 'messagefieldrequired'.tr;
      isValid.value = false;
    }

    return isValid.value;
  }

  onSubmit() {
    if (valid()) {
      print("Send successfully");
    } else {
      print("error");
    }
  }
}
