import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:postervibe/core/app_export.dart';
import 'package:get/get.dart';

class DialogueHelper {
  static OverlayEntry? _overlayEntry;

  static void showLoading(
    BuildContext context, {
    bool isDissmiss = false,
    String? message,
  }) {
    _overlayEntry = OverlayEntry(
      builder: (BuildContext context) => GestureDetector(
        onTap: () {
          isDissmiss ? hideLoading() : null;
        },
        child: Stack(
          children: [
            Positioned.fill(
              child: Material(
                color: Colors.transparent,
                child: Container(
                  alignment: Alignment.center,
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.darkBlueBlack,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          height: 60,
                          width: 60,
                          child: Lottie.asset(
                            AppImage.whiteLoader,
                            fit: BoxFit.contain,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          message ?? 'Loading..',
                          style: const TextStyle(
                              fontSize: 12,
                              letterSpacing: 2,
                              fontWeight: FontWeight.w500,
                              color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );

    Overlay.of(context).insert(_overlayEntry!);
  }

  static void hideLoading() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  static void showError(BuildContext context, String errorMessage) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        content: Text(errorMessage),
        duration: const Duration(seconds: 2),
        backgroundColor: Colors.red,
      ),
    );
  }

  static Future<bool?> showConfirmationDialog({
    required BuildContext context,
    Widget? confirmButton,
    Widget? cancelButton,
    String errorMsg = '',
    String newVersion = '',
    String currentVersion = '',
    String dialogTitle = '',
    String dialogContent = '',
    bool barrierDismissible = true,
    bool canPop = true,
  }) {
    if (errorMsg.isEmpty) {
      return Get.dialog<bool>(
        PopScope(
          canPop: barrierDismissible,
          child: AlertDialog(
            backgroundColor: Colors.white,
            title: Text(dialogTitle),
            content: Text(
              dialogContent,
              style: const TextStyle(
                color: Colors.black87,
              ),
            ),
            actions: [
              cancelButton ?? const SizedBox.shrink(),
              confirmButton ?? const SizedBox.shrink(),
            ],
          ),
        ),
        barrierDismissible: barrierDismissible,
      );
    } else {
      showError(context, errorMsg);
      return Future.value(false);
    }
  }

  static void logoutDialog({
    required BuildContext context,
    required String? title,
    required String? description,
    required Color? color,
    required Function onTap,
  }) {
    showDialog(
      barrierColor: const Color.fromRGBO(0, 0, 0, 0.80),
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: SizedBox(
            height: 135.0,
            child: Column(
              children: [
                msgArea(title, description, context),
                const Spacer(),
                footer(context, color, onTap),
              ],
            ),
          ),
        );
      },
    );
  }

  static Widget msgArea(String? title, String? description, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(width: double.infinity),
                Text(
                  title ?? '',
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 16.0,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  description ?? '',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w500,
                    fontSize: 12.0,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static Widget footer(BuildContext context, Color? color, Function onTap) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(8.0),
          bottomRight: Radius.circular(8.0),
        ),
        color: Colors.grey[100],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          InkWell(
            onTap: () => onTap(),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: color!),
                borderRadius: BorderRadius.circular(2.0),
                color: color,
              ),
              margin: const EdgeInsets.symmetric(vertical: 5.0),
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 4.0),
              child: Text(
                "yes".tr,
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ),
          InkWell(
            onTap: () => Get.back(),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(2.0),
                border: Border.all(color: color),
                color: Colors.white,
              ),
              margin: const EdgeInsets.all(5.0),
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 4.0),
              child: Text(
                "no".tr,
                style: const TextStyle(color: Colors.black),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
