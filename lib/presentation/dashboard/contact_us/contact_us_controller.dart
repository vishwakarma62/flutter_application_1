import 'package:postervibe/core/app_export.dart';
import 'package:postervibe/core/network/network_info.dart';

class ContactUsController extends GetxController {

  
  ConnectivityManager connectivityManager = Get.find();
  RxString name = "".obs;
  RxString nameError = "".obs;
  RxString email = "".obs;
  RxString emailError = "".obs;
  RxString message = "".obs;
  RxString messageError = "".obs;

  bool valid() {
    RxBool isValid = true.obs;
    messageError.value = '';

    if (name.value.isEmpty) {
      nameError.value = 'namefieldrequired'.tr;
      isValid.value = false;
    }
    if (email.value.isEmpty) {
      emailError.value = 'emailfieldrequired'.tr;
      isValid.value = false;
    } else if (email.value.isEmail) {
      emailError.value = 'wecannotfindanaccountwiththatemailaddress'.tr;
      isValid.value = false;
    }

    if (message.value.isEmpty) {
      messageError.value = 'messagefieldrequired'.tr;
      isValid.value = false;
    }

    return isValid.value;
  }

  onAdd() {
    if (valid()) {
      print("Send successfully");
    } else {
      print("error");
    }
  }
}
