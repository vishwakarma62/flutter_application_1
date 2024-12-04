import 'package:octo_image/octo_image.dart';
import 'package:postervibe/core/local_storage.dart';
import 'package:postervibe/presentation/dashboard/search/search_controller.dart';
import 'package:postervibe/presentation/widget/app_text.dart';
import 'package:postervibe/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';

import '../../core/app_export.dart';

AppBar appBar({
  Function()? onPressAction,
  Function()? onPressLeading,
  Function()? onEdittingComplete,
  String? actionIcon,
  String? text,
  bool back = true,
  bool action = false,
  bool isDisabled = false,
  bool menu = false,
  bool centerLogo = false,
  bool isSearch = false,
  bool searchfield = false,
  bool isLeading = false,
  Color? backgroundColor,
  Color? backColor,
  SearchScreenController? controller,
  Widget? widget,
}) {
  return AppBar(
    automaticallyImplyLeading: false,
    leadingWidth: 75,
    backgroundColor: backgroundColor ??
        (Get.isDarkMode ? AppColors.darkModeBackgroundColor : Colors.white),
    elevation: 0,
    leading: Row(
      children: [
        wSizedBox10,
        if (isLeading)
          back
              ? InkWell(
                  borderRadius: BorderRadius.circular(10),
                  onTap: onPressLeading ?? Get.back,
                  child: Container(
                    height: 40,
                    width: 40,
                    margin: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      color: backColor ?? Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: SvgPicture.asset(
                          AppImage.backAppbar,
                          color: AppColors.appTextBlack,
                          height: 15,
                        ),
                      ),
                    ),
                  ),
                )
              : Obx(
                  () => LocalStorage.selectedBusinessId.value.isNotEmpty
                      ? Obx(
                          () => Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: AppColors.appBluePurple, width: 2),
                              shape: BoxShape.circle,
                              color: Colors.transparent,
                            ),
                            child: GestureDetector(
                              onTap: onPressLeading,
                              child: ClipOval(
                                child: LocalStorage
                                        .selectedBusinessLogo.value.isEmpty
                                    ? Image.asset(AppImage.defaultImage)
                                    : OctoImage(
                                        image: NetworkImage(
                                          LocalStorage
                                              .selectedBusinessLogo.value,
                                        ),

                                        fit: BoxFit
                                            .contain, // Fit the image inside the circular shape
                                        placeholderBuilder: (context) =>
                                            Lottie.asset(AppImage.loader),
                                        errorBuilder: (context, error,
                                                stackTrace) =>
                                            Image.asset(AppImage.defaultImage),
                                      ),
                              ),
                            ),
                          ),
                        )
                      : Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            color: backColor ?? Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: IconButton(
                            constraints: const BoxConstraints(),
                            icon: const Icon(Icons.add),
                            onPressed: () {
                              Get.toNamed(AppRoute.businessDetail, arguments: [
                                '',
                                false,
                                false,
                              ]);
                            },
                          ),
                        ),
                ),
      ],
    ),
    centerTitle: true,
    title: centerLogo
        ? Container(
            margin: const EdgeInsets.all(18),
            child: SvgPicture.asset(AppImage.homeLogo),
          )
        : capitalizeWords(text ?? '',
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.appTextBlack,),
    actions: [
      if (isSearch)
        InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () {
            Get.toNamed(AppRoute.search);
          },
          child: Container(
            width: 40,
            height: 40,
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: backColor ?? Colors.grey.shade300,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: SvgPicture.asset(
                AppImage.search,
                color: AppColors.appTextBlack,
              ),
            ),
          ),
        ),
      widget ?? const SizedBox(),
      if (action)
        IgnorePointer(
          ignoring: isDisabled, // Set ignoring to true when disabled
          child: GestureDetector(
            onTap: isDisabled
                ? null // Set onTap to null when it's disabled
                : onPressAction ??
                    () {
                      Get.toNamed(AppRoute.postEditor);
                    },
            child: Container(
              width: 40,
              height: 40,
              margin: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                color: isDisabled
                    ? Colors.grey.shade300
                    : backColor ?? Colors.grey.shade300,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: SvgPicture.asset(
                  actionIcon ?? AppImage.notification,
                  color: isDisabled ? Colors.grey : AppColors.appTextBlack,
                ),
              ),
            ),
          ),
        ),
      controller != null && searchfield
          ? Expanded(
              child: Container(
                margin: const EdgeInsets.only(
                    left: 75, top: 8, bottom: 8, right: 12),
                child: Obx(
                  () => TextField(
                    cursorColor: AppColors.primaryColor,
                    controller: controller.textEditingController,
                    style: const TextStyle(fontSize: 14),
                    decoration: InputDecoration(
                      suffixIcon: controller.enterText.value.isNotEmpty
                          ? Material(
                              color: Colors.transparent,
                              child: IconButton(
                                  onPressed: () {
                                    controller.enterText.value = '';
                                    controller.textEditingController.clear();
                                    controller.searchEvent(
                                        limit: 20, page: 1, query: '');
                                    controller.page = 1;
                                  },
                                  icon: SizedBox(
                                      width: 25,
                                      height: 25,
                                      child: SvgPicture.asset(
                                          AppImage.search_clear))),
                            )
                          : null,
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 22, vertical: 8),
                      filled: true,
                      fillColor: Colors.grey.shade300,
                      hintText: '${"Birthday".tr}..',
                      hintStyle: const TextStyle(
                        color: Color(0xff4B545A),
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide.none),
                    ),
                    onChanged: (value) {
                      controller.onSearchChanged(value);
                      controller.enterText.value = value;
                      controller.page = 1;
                    },
                  ),
                ),
              ),
            )
          : const SizedBox(),
      wSizedBox10
    ],
  );
}
