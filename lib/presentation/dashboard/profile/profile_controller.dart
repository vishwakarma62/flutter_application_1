import 'package:postervibe/core/app_export.dart';
import 'package:postervibe/core/network/network_info.dart';

import '../../bottom_bar/bottom_bar_controller.dart';

class ProfileController extends GetxController {
  BottomBarController bottomBarController = Get.find();
  ConnectivityManager connectivityManager = Get.find();
}
