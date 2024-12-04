import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../core/app_export.dart';

class AppButton extends StatelessWidget {
  final Function()? onPressed;
  final String? text;
  final double? height;
  final double? width;
  final Color? color;
  final Color? iconColor;
  final Color? textColor;
  final Color? borderColor;
  final bool? border;
  final double? fs;
  final double? radius;
  final bool loader;

  const AppButton(
      {super.key,
      this.onPressed,
      this.text,
      this.height,
      this.width,
      this.color,
      this.border = false,
      this.borderColor,
      this.textColor,
      this.iconColor,
      this.fs,
      this.radius,
      this.loader = false});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(radius ?? 10),
      child: Ink(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius ?? 10),
          color: color ?? AppColors.darkBlueBlack,
          border: border == false
              ? null
              : Border.all(
                  color: borderColor ??
                      (Get.isDarkMode
                          ? Colors.white
                          : Colors.black.withOpacity(.3)),
                ),
        ),
        child: SizedBox(
          height: height ?? 60,
          width: width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              loader
                  ? Lottie.asset(AppImage.whiteLoader)
                  : Text(
                      text!,
                      style: TextStyle(
                        fontSize: fs ?? 16,
                        color: textColor ?? Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
