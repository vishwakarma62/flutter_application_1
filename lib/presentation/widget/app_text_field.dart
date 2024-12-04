import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../core/app_export.dart';

class AppTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? prefixIcon;
  final bool? icon;
  final String? keyValue;
  final String? hintText;
  final String? initialValue;
  final Widget? suffixIcon;
  final String? Function(String?)? validate;
  final Function(String)? onChange;
  final Function(String)? onFieldSubmitted;
  final bool obscureText;
  final bool border;
  final bool shadow;
  final bool enabled;
  final bool lebel;
  final TextInputType? keyboardType;
  final int maxLines;
  final Color? color;
  final List<TextInputFormatter>? inputFormatters;
  final RxString? errorMessage;
  final bool readonly;
  final bool svg;

  final Function()? onTap;
  final double? radius;

  const AppTextField({
    super.key,
    this.lebel = true,
    this.keyValue = "1",
    this.hintText,
    this.initialValue,
    this.validate,
    this.onChange,
    this.svg = true,
    this.obscureText = false,
    this.keyboardType,
    this.maxLines = 1,
    this.suffixIcon,
    this.onFieldSubmitted,
    this.color,
    this.border = false,
    this.shadow = false,
    this.prefixIcon,
    this.inputFormatters,
    this.controller,
    this.errorMessage,
    this.readonly = false,
    this.onTap,
    this.enabled = true,
    this.radius,
    this.icon = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: color ?? Colors.white,
            borderRadius: BorderRadius.circular(radius ?? 10),
            boxShadow: shadow
                ? [
                    BoxShadow(
                      color: Colors.black.withOpacity(.1),
                      blurRadius: 10.0,
                      spreadRadius: 2.0,
                    ),
                  ]
                : [],
          ),

          child: TextFormField(
            keyboardType: keyboardType,
            enabled: enabled,
            onTap: onTap,
            readOnly: readonly,
            controller: controller,
            onChanged: onChange,
            inputFormatters: inputFormatters,
            cursorColor: AppColors.primaryColor,
            obscureText: obscureText,
            maxLines: maxLines,
            decoration: InputDecoration(
              labelText: lebel == true ? hintText : null,
              labelStyle: const TextStyle(
                color: Color(0xff8B8989),
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
              prefixIcon: icon == true
                  ? prefixIcon != null
                      ? Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 20, right: 10),
                              child: svg
                                  ? SvgPicture.asset(
                                      prefixIcon!,
                                      height: 30,
                                      width: 30,
                                      color: AppColors.appIconColor,
                                    )
                                  : Image.asset(
                                      prefixIcon!,
                                      height: 30,
                                      width: 30,
                                      color: AppColors.appIconColor,
                                    ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(left: 5, right: 20),
                              height: 20,
                              width: 2,
                              decoration: const BoxDecoration(
                                color: Color(0xffC3CDDB),
                              ),
                            ),
                          ],
                        )
                      : null
                  : Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(
                          width: 20,
                        ),
                        Text(
                          prefixIcon!,
                          style: const TextStyle(
                            color: Color(0xff5A6274),
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 20, right: 20),
                          height: 20,
                          width: 2,
                          decoration: const BoxDecoration(
                            color: Color(0xffC3CDDB),
                          ),
                        ),
                      ],
                    ),
              suffixIcon: suffixIcon,
              hintText: hintText,
              hintStyle: lebel == true
                  ? const TextStyle(
                      fontSize: 15.0,
                    )
                  : const TextStyle(
                      fontSize: 12,
                    ),
              focusedErrorBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.teal, width: 2),
                borderRadius: BorderRadius.circular(radius ?? 10),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.darkBlueBlack, width: 2),
                borderRadius: BorderRadius.circular(radius ?? 10),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide:
                    BorderSide(color: AppColors.appTextBlack.withOpacity(0.3), width: 1),
                borderRadius: BorderRadius.circular(radius ?? 10),
              ),
            ),
          ),
        ),
        Obx(
          () => (errorMessage!.value.isNotEmpty)
              ? Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    height: 25,
                    color: Colors.transparent,
                    child: Text(
                      errorMessage!.value,
                      style: const TextStyle(color: Colors.red, fontSize: 11),
                    ),
                  ),
                )
              : Container(),
        )
      ],
    );
  }
}
