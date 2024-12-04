import 'package:octo_image/octo_image.dart';
import 'package:postervibe/presentation/dashboard/post_editor/post_editor_controller.dart';

import 'package:postervibe/presentation/widget/app_bar.dart';
import 'package:postervibe/presentation/widget/no_internet.dart';
import 'package:postervibe/presentation/widget/nodata.dart';
import 'package:postervibe/presentation/widget/shimmer.dart';
import 'package:postervibe/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';
import 'package:screenshot/screenshot.dart';
import '../../../core/app_export.dart';

class PostEditorScreen extends StatefulWidget {
  const PostEditorScreen({super.key});

  @override
  State<PostEditorScreen> createState() => _PostEditorScreenState();
}

class _PostEditorScreenState extends State<PostEditorScreen> {
  final PostEditorController _con = Get.put(PostEditorController());

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(Get.context!).size;
    return Screenshot(
      controller: _con.screenshotController,
      child: Obx(
        () => Scaffold(
          appBar: appBar(
              text: _con.noInternet.value ? '' : "edit post".tr,
              action: false,
              isLeading: true,
              widget: Visibility(
                visible: _con.business.value == null || _con.noInternet.value
                    ? false
                    : true, // Disable interaction when isLoading is true
                child: InkWell(
                  borderRadius: BorderRadius.circular(10),
                  onTap: _con.isLoading.value
                      ? null // Disable onTap action when isLoading is true
                      : () {
                          _con.isLoading.value = true;
                          _con.screenshotController
                              .captureFromWidget(
                            InheritedTheme.captureAll(
                              context,
                              Material(child: screenShot(size)),
                            ),
                            delay: const Duration(seconds: 1),
                          )
                              .then((value) {
                            _con.isLoading.value = false;
                            Get.toNamed(
                              AppRoute.preview,
                              arguments: [value, true],
                            );
                          });
                        },
                  child: Container(
                    margin: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      color: _con.business.value == null
                          ? Colors.grey.shade300.withOpacity(
                              0.5) // Reduced opacity to indicate disabled state when isLoading is true
                          : Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: _con.isLoading.value
                        ? Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Lottie.asset(AppImage.loader),
                          )
                        : Padding(
                            padding: const EdgeInsets.all(12.4),
                            child: SvgPicture.asset(
                              AppImage.download,
                              color: AppColors.appTextBlack,
                              height: 15,
                            ),
                          ),
                  ),
                ),
              )),
          body: Obx(() {
            if (_con.noInternet.value) {
              return NoInternetWidget();
            }
            if (_con.isBusinessDataLoading.value) {
              return postShimmer(size);
            }
            if (_con.business.value == null) {
              return const NoDataWidget(message: 'No Data Found');
            } else {
              return Column(
                children: [
                  hSizedBox10,
                  screenShot(size),
                  hSizedBox10,
                  SizedBox(
                    height: 40,
                    child: ListView(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      scrollDirection: Axis.horizontal,
                      children: [
                        detailsOption(
                          icon: const Text(
                            "NAME",
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          onTap: () {
                            _con.isName.value = !_con.isName.value;
                          },
                          value: _con.isName.value,
                        ),
                        wSizedBox10,
                        detailsOption(
                          icon: const Text(
                            "LOGO",
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          onTap: () {
                            if (_con.business.value!.logo!.isNotEmpty) {
                              _con.isLogo.value = !_con.isLogo.value;
                            }
                          },
                          value: _con.business.value!.logo!.isEmpty
                              ? false
                              : _con.isLogo.value,
                        ),
                        wSizedBox10,
                        detailsOption(
                          icon: const Icon(
                            Icons.call,
                            color: Colors.white,
                          ),
                          onTap: () {
                            _con.isMobileNumber.value =
                                !_con.isMobileNumber.value;
                          },
                          value: _con.isMobileNumber.value,
                        ),
                        wSizedBox10,
                        detailsOption(
                          icon: const Icon(
                            Icons.email,
                            color: Colors.white,
                          ),
                          onTap: () {
                            _con.isEmail.value = !_con.isEmail.value;
                          },
                          value: _con.isEmail.value,
                        ),
                        wSizedBox10,
                        detailsOption(
                          icon: const Icon(
                            Icons.location_on,
                            color: Colors.white,
                          ),
                          onTap: () {
                            _con.isAddress.value = !_con.isAddress.value;
                          },
                          value: _con.isAddress.value,
                        ),
                        wSizedBox10,
                        detailsOption(
                          icon: const Icon(
                            Icons.public,
                            color: Colors.white,
                          ),
                          onTap: () {
                            _con.isWebsite.value = !_con.isWebsite.value;
                          },
                          value: _con.isWebsite.value,
                        ),
                        wSizedBox10,
                        detailsOption(
                          icon: const Text(
                            "FRAME",
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          onTap: () {
                            _con.isFrame.value = !_con.isFrame.value;
                          },
                          value: _con.isFrame.value,
                        ),
                        if (Get.height < 680)
                          Row(
                            children: [
                              wSizedBox10,
                              detailsOption(
                                  icon: const Icon(
                                    Icons.palette_outlined,
                                    color: Colors.white,
                                  ),
                                  onTap: () {
                                    showDialog(
                                      builder: (context) => Dialog(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                        ),
                                        child: Container(
                                          width: Get.width * 0.8,
                                          padding: const EdgeInsets.all(20),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            color: Colors.white,
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.grey
                                                    .withOpacity(0.3),
                                                spreadRadius: 2,
                                                blurRadius: 10,
                                                offset: const Offset(0, 3),
                                              ),
                                            ],
                                          ),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    'Pick a color!',
                                                    style: TextStyle(
                                                      fontSize: 24,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color:
                                                          Colors.blueGrey[900],
                                                    ),
                                                  ),
                                                  IconButton(
                                                    onPressed: () {
                                                      Get.back();
                                                    },
                                                    icon: const Icon(
                                                      Icons.close,
                                                      color: Colors.grey,
                                                      size: 24,
                                                    ),
                                                  )
                                                ],
                                              ),
                                              hSizedBox20,
                                              BlockPicker(
                                                layoutBuilder:
                                                    (context, colors, child) {
                                                  return SizedBox(
                                                    width: Get.width *
                                                        0.8, // Width of the content area
                                                    height: Get.height *
                                                        0.5, // Height of the content area
                                                    child: GridView.count(
                                                      physics:
                                                          const ClampingScrollPhysics(),
                                                      crossAxisCount: 4,
                                                      crossAxisSpacing: 5,
                                                      mainAxisSpacing: 5,
                                                      children: [
                                                        for (Color color
                                                            in colors)
                                                          Container(
                                                            decoration:
                                                                BoxDecoration(
                                                              color: color,
                                                              shape: BoxShape
                                                                  .circle,
                                                              boxShadow: [
                                                                BoxShadow(
                                                                  color: Colors
                                                                      .black
                                                                      .withOpacity(
                                                                          0.2),
                                                                  spreadRadius:
                                                                      2,
                                                                  blurRadius: 4,
                                                                  offset:
                                                                      const Offset(
                                                                          0, 2),
                                                                ),
                                                              ],
                                                            ),
                                                            child: child(color),
                                                          ),
                                                      ],
                                                    ),
                                                  );
                                                },
                                                availableColors:
                                                    _con.defaultColors,
                                                pickerColor:
                                                    _con.currentColor.value,
                                                onColorChanged: (Color color) {
                                                  _con.pickerColor.value =
                                                      color;
                                                  _con.currentColor.value =
                                                      _con.pickerColor.value!;
                                                  Get.back();
                                                },
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      context: context,
                                    );
                                  }),
                              wSizedBox10,
                              detailsOption(
                                icon: const Icon(
                                  Icons.text_format,
                                  color: Colors.white,
                                ),
                                onTap: () {
                                  final providedColor = AppColors.appBluePurple;
                                  final oppositeColor = Colors.grey[400]!;

                                  Get.dialog(
                                    Dialog(
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                      ),
                                      child: Container(
                                        width: Get.width * 0.8,
                                        padding: const EdgeInsets.all(20),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          color: Colors.white,
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.3),
                                              spreadRadius: 2,
                                              blurRadius: 10,
                                              offset: const Offset(0, 3),
                                            ),
                                          ],
                                        ),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  "Choose Font",
                                                  style: TextStyle(
                                                    fontSize: 24,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.blueGrey[900],
                                                  ),
                                                ),
                                                IconButton(
                                                  onPressed: () {
                                                    Get.back();
                                                  },
                                                  icon: const Icon(
                                                    Icons.close,
                                                    color: Colors.grey,
                                                    size: 24,
                                                  ),
                                                )
                                              ],
                                            ),
                                            hSizedBox20,
                                            AnimatedContainer(
                                              duration: const Duration(
                                                  milliseconds: 300),
                                              curve: Curves.easeInOut,
                                              constraints: BoxConstraints(
                                                  maxHeight: Get.height * 0.5),
                                              child: Container(
                                                child: ListView.separated(
                                                  separatorBuilder: (_, __) =>
                                                      const SizedBox(
                                                          height: 12),
                                                  itemCount: _con
                                                      .fontFamilyList.length,
                                                  itemBuilder:
                                                      (BuildContext context,
                                                          int index) {
                                                    final isSelected =
                                                        _con.fontFamilyList[_con
                                                                .selectFontStyle
                                                                .value] ==
                                                            _con.fontFamilyList[
                                                                index];
                                                    return InkWell(
                                                      onTap: () {
                                                        _con.selectFontStyle
                                                            .value = index;
                                                        Get.back();
                                                      },
                                                      child: Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                                vertical: 12,
                                                                horizontal: 20),
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          color: isSelected
                                                              ? providedColor
                                                                  .withOpacity(
                                                                      0.1)
                                                              : Colors
                                                                  .transparent,
                                                        ),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Text(
                                                              "Festival Post",
                                                              style: TextStyle(
                                                                fontFamily: _con
                                                                    .fontFamilyList[
                                                                        index]
                                                                    .toString(),
                                                                fontSize: 18,
                                                                color: Colors
                                                                        .blueGrey[
                                                                    900],
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal,
                                                              ),
                                                            ),
                                                            if (!isSelected)
                                                              Icon(
                                                                Icons.circle,
                                                                color:
                                                                    oppositeColor,
                                                              ),
                                                            if (isSelected)
                                                              Icon(
                                                                Icons
                                                                    .check_circle,
                                                                color:
                                                                    providedColor,
                                                              ),
                                                          ],
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  const Divider(),
                  SizedBox(
                    height: 3,
                  ),
                  SizedBox(
                    height: 80,
                    child: _con.frameList.isEmpty
                        ? const Text("Data No")
                        : ListView.separated(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            physics: const ClampingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            itemCount: _con.frameList.length,
                            separatorBuilder: (context, index) => wSizedBox10,
                            itemBuilder: (context, index) {
                              return Obx(
                                () => GestureDetector(
                                  onTap: () {
                                    _con.selectedFrame.value = index;
                                  },
                                  child: AnimatedContainer(
                                    duration: Duration(milliseconds: 300),
                                    width: 80,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      boxShadow:
                                          _con.selectedFrame.value == index
                                              ? [
                                                  BoxShadow(
                                                    color: Colors.black
                                                        .withOpacity(0.5),
                                                    spreadRadius: 3,
                                                    blurRadius: 6,
                                                    offset: Offset(0, 3),
                                                  ),
                                                ]
                                              : [],
                                      gradient:
                                          _con.selectedFrame.value == index
                                              ? LinearGradient(
                                                  colors: [
                                                    Color(0xFF5D54B3),
                                                    Color(0xFF857FCF),
                                                    Color(0xFFA59AE4),
                                                  ],
                                                  begin: Alignment.topLeft,
                                                  end: Alignment.bottomRight,
                                                )
                                              : null,
                                    ),
                                    child: Padding(
                                      padding: _con.selectedFrame.value == index
                                          ? const EdgeInsets.all(3)
                                          : EdgeInsets.zero,
                                      child: Stack(
                                        children: [
                                          OctoImage(
                                            width: 80,
                                            height: 80,
                                            image: NetworkImage(
                                                _con.imageUrl.value),
                                            fit: BoxFit.fill,
                                            placeholderBuilder: (context) =>
                                                mainImageShimmer(size, true),
                                            errorBuilder:
                                                (context, error, stackTrace) =>
                                                    Image.asset(
                                                        AppImage.defaultImage),
                                          ),
                                          Image.asset(
                                            _con.frameList[index].frameUrl,
                                            fit: BoxFit.cover,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  if (Get.height >= 680)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        editOption(
                          title: "Text Color",
                          onTap: () {
                            showDialog(
                              builder: (context) => Dialog(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                child: Container(
                                  width: Get.width * 0.8,
                                  padding: const EdgeInsets.all(20),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.3),
                                        spreadRadius: 2,
                                        blurRadius: 10,
                                        offset: const Offset(0, 3),
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Pick a color!',
                                            style: TextStyle(
                                              fontSize: 24,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.blueGrey[900],
                                            ),
                                          ),
                                          IconButton(
                                            onPressed: () {
                                              Get.back();
                                            },
                                            icon: const Icon(
                                              Icons.close,
                                              color: Colors.grey,
                                              size: 24,
                                            ),
                                          )
                                        ],
                                      ),
                                      hSizedBox20,
                                      BlockPicker(
                                        layoutBuilder:
                                            (context, colors, child) {
                                          return SizedBox(
                                            width: Get.width *
                                                0.8, // Width of the content area
                                            height: Get.height *
                                                0.5, // Height of the content area
                                            child: GridView.count(
                                              physics:
                                                  const ClampingScrollPhysics(),
                                              crossAxisCount: 4,
                                              crossAxisSpacing: 5,
                                              mainAxisSpacing: 5,
                                              children: [
                                                for (Color color in colors)
                                                  Container(
                                                    decoration: BoxDecoration(
                                                      color: color,
                                                      shape: BoxShape.circle,
                                                      boxShadow: [
                                                        BoxShadow(
                                                          color: Colors.black
                                                              .withOpacity(0.2),
                                                          spreadRadius: 2,
                                                          blurRadius: 4,
                                                          offset: const Offset(
                                                              0, 2),
                                                        ),
                                                      ],
                                                    ),
                                                    child: child(color),
                                                  ),
                                              ],
                                            ),
                                          );
                                        },
                                        availableColors: _con.defaultColors,
                                        pickerColor: _con.currentColor.value,
                                        onColorChanged: (Color color) {
                                          _con.pickerColor.value = color;
                                          _con.currentColor.value =
                                              _con.pickerColor.value!;
                                          Get.back();
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              context: context,
                            );
                          },
                        ),

                        editOption(
                          title: "Font Type",
                          onTap: () {
                            final providedColor = AppColors.appBluePurple;
                            final oppositeColor = Colors.grey[400]!;

                            Get.dialog(
                              Dialog(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                child: Container(
                                  width: Get.width * 0.8,
                                  padding: const EdgeInsets.all(20),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.3),
                                        spreadRadius: 2,
                                        blurRadius: 10,
                                        offset: const Offset(0, 3),
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Choose Font",
                                            style: TextStyle(
                                              fontSize: 24,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.blueGrey[900],
                                            ),
                                          ),
                                          IconButton(
                                            onPressed: () {
                                              Get.back();
                                            },
                                            icon: const Icon(
                                              Icons.close,
                                              color: Colors.grey,
                                              size: 24,
                                            ),
                                          )
                                        ],
                                      ),
                                      hSizedBox20,
                                      AnimatedContainer(
                                        duration:
                                            const Duration(milliseconds: 300),
                                        curve: Curves.easeInOut,
                                        constraints: BoxConstraints(
                                            maxHeight: Get.height * 0.5),
                                        child: Container(
                                          child: ListView.separated(
                                            separatorBuilder: (_, __) =>
                                                const SizedBox(height: 12),
                                            itemCount:
                                                _con.fontFamilyList.length,
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              final isSelected = _con
                                                          .fontFamilyList[
                                                      _con.selectFontStyle
                                                          .value] ==
                                                  _con.fontFamilyList[index];
                                              return InkWell(
                                                onTap: () {
                                                  _con.selectFontStyle.value =
                                                      index;
                                                  Get.back();
                                                },
                                                child: Container(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      vertical: 12,
                                                      horizontal: 20),
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    color: isSelected
                                                        ? providedColor
                                                            .withOpacity(0.1)
                                                        : Colors.transparent,
                                                  ),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        "Festival Post",
                                                        style: TextStyle(
                                                          fontFamily: _con
                                                              .fontFamilyList[
                                                                  index]
                                                              .toString(),
                                                          fontSize: 18,
                                                          color: Colors
                                                              .blueGrey[900],
                                                          fontWeight:
                                                              FontWeight.normal,
                                                        ),
                                                      ),
                                                      if (!isSelected)
                                                        Icon(
                                                          Icons.circle,
                                                          color: oppositeColor,
                                                        ),
                                                      if (isSelected)
                                                        Icon(
                                                          Icons.check_circle,
                                                          color: providedColor,
                                                        ),
                                                    ],
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),

                        /////
                      ],
                    ),
                  hSizedBox10,
                ],
              );
            }
          }),
        ),
      ),
    );
  }

  Column editOption({
    required String title,
    required Function() onTap,
  }) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            height: Get.height < 762 ? 30 : 35,
            width: Get.height < 762 ? 30 : 35,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.darkBlueBlack.withOpacity(0.7),
                  AppColors.darkBlueBlack.withOpacity(0.5),
                  AppColors.darkBlueBlack.withOpacity(0.3),
                ],
                stops: [0.0, 0.5, 1.0],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(6),
            ),
            child: const Icon(
              Icons.text_format,
              color: Colors.white,
            ),
          ),
        ),
        hSizedBox4,
        Text(
          title,
          style: const TextStyle(fontSize: 10),
        ),
      ],
    );
  }

  Widget detailsOption({
    required Widget icon,
    required Function() onTap,
    bool value = true,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(50),
      child: Container(
        alignment: Alignment.center,
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: value
              ? AppColors.darkBlueBlack
              : AppColors.darkBlueBlack.withOpacity(.1),
          shape: BoxShape.circle,
          gradient: value
              ? LinearGradient(
                  colors: [
                    AppColors.darkBlueBlack.withOpacity(0.9),
                    AppColors.blueShade,
                    AppColors.darkBlueBlack.withOpacity(0.7),
                    AppColors.darkBlueBlack.withOpacity(0.5),
                    AppColors.darkBlueBlack.withOpacity(0.3),
                    AppColors.darkBlueBlack.withOpacity(0.1),
                  ],
                  stops: [0.0, 0.2, 0.4, 0.6, 0.8, 1.0],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                )
              : null,
        ),
        child: icon,
      ),
    );
  }

  Widget screenShot(size) {
    return RepaintBoundary(
      child: Obx(
        () => GestureDetector(
          onTap: () {
            _con.deleteSticker.clear();
          },
          onScaleStart: (details) {
            _con.previousZoom.value = _con.zoom.value;
          },
          onScaleUpdate: (details) {
            double newScale = _con.previousZoom.value * details.scale;

            if (newScale >= 0.1) {
              _con.zoom.value = newScale;
            }
          },
          child: AspectRatio(
            aspectRatio: 1,
            child: Container(
              child: _con.isBusinessDataLoading.value
                  ? const CircularProgressIndicator.adaptive()
                  : _con.business.value == null
                      ? Center(
                          child: SvgPicture.asset(AppImage.noData),
                        )
                      : Stack(
                          children: [
                            AspectRatio(
                              aspectRatio: 1,
                              child: Container(
                                decoration: const BoxDecoration(),
                                child: OctoImage(
                                  image: NetworkImage(_con.imageUrl.value),
                                  fit: BoxFit.fill,
                                  placeholderBuilder: (context) =>
                                      mainImageShimmer(size, true),
                                  errorBuilder: (context, error, stackTrace) =>
                                      Image.asset(
                                    AppImage.defaultImage,
                                    filterQuality: FilterQuality.low,
                                  ),
                                ),
                              ),
                            ),
                            if (_con.isFrame.value)
                              Stack(
                                children: [
                                  if (_con.selectedFrame.value == 9)
                                    Positioned(
                                      bottom: Get.width * 0.0,
                                      child: Container(
                                        width: Get.width,
                                        height: 48,
                                        color: Colors.white,
                                      ),
                                    ),
                                  // Frame
                                  Obx(
                                    () => _con.frameList.isEmpty ||
                                            _con.frameList.isEmpty
                                        ? const CircularProgressIndicator
                                            .adaptive()
                                        : AspectRatio(
                                            aspectRatio: 1,
                                            child: Image.asset(
                                              _con
                                                  .frameList[
                                                      _con.selectedFrame.value]
                                                  .frameUrl,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                  ),

                                  if (_con.isName.value)
                                    Positioned(
                                      top: Get.width *
                                          double.parse(_con
                                              .frameList[
                                                  _con.selectedFrame.value]
                                              .position!
                                              .companyName!
                                              .top!),
                                      left: Get.width *
                                          double.parse(_con
                                              .frameList[
                                                  _con.selectedFrame.value]
                                              .position!
                                              .companyName!
                                              .left!),
                                      child: Text(
                                        _con.business.value!.businessName!,
                                        style: TextStyle(
                                          color: _con.pickerColor.value ??
                                              _con
                                                  .frameList[
                                                      _con.selectedFrame.value]
                                                  .position!
                                                  .companyName!
                                                  .color,
                                          fontSize: Get.width *
                                              double.parse(_con
                                                  .frameList[
                                                      _con.selectedFrame.value]
                                                  .position!
                                                  .companyName!
                                                  .fontSize!),
                                          fontFamily: _con.fontFamilyList[
                                              _con.selectFontStyle.value],
                                        ),
                                      ),
                                    ),
      
                                  if (_con.isMobileNumber.value)
                                    Positioned(
                                      bottom: Get.width *
                                          double.parse(_con
                                              .frameList[_con.selectedFrame.value]
                                              .position!
                                              .mobileNumber!
                                              .bottom!),
                                      left: Get.width *
                                          double.parse(_con
                                              .frameList[_con.selectedFrame.value]
                                              .position!
                                              .mobileNumber!
                                              .left!),
                                      top: _con.selectedFrame.value == 06 ||
                                              _con.selectedFrame.value == 09 ||
                                              _con.selectedFrame.value == 14 ||
                                              _con.selectedFrame.value == 15
                                          ? Get.width *
                                              double.parse(_con
                                                  .frameList[
                                                      _con.selectedFrame.value]
                                                  .position!
                                                  .mobileNumber!
                                                  .top!)
                                          : null,
                                      child: Column(
                                        mainAxisAlignment: _con.business.value!
                                                    .phoneNumber2!.isNotEmpty &&
                                                _con.selectedFrame.value == 06
                                            ? MainAxisAlignment.spaceEvenly
                                            : _con.selectedFrame.value == 06
                                                ? MainAxisAlignment.start
                                                : MainAxisAlignment.center,
                                        children: [
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.call,
                                                color: _con.pickerColor.value !=
                                                        null
                                                    ? _con.pickerColor.value ==
                                                            const Color(
                                                                0xffffffff)
                                                        ? Colors.white
                                                        : _con.pickerColor.value
                                                    : _con
                                                        .frameList[_con
                                                            .selectedFrame.value]
                                                        .position!
                                                        .mobileNumber!
                                                        .color,
                                                size: Get.width *
                                                    double.parse(_con
                                                        .frameList[_con
                                                            .selectedFrame.value]
                                                        .position!
                                                        .mobileNumber!
                                                        .iconSize!),
                                              ),
                                              const SizedBox(
                                                width: 5,
                                              ),
                                              Text(
                                                _con.business.value!
                                                    .phoneNumber1!,
                                                style: TextStyle(
                                                  color: _con.pickerColor.value !=
                                                          null
                                                      ? _con.pickerColor.value ==
                                                              const Color(
                                                                  0xffffffff)
                                                          ? Colors.white
                                                          : _con.pickerColor.value
                                                      : _con
                                                          .frameList[_con
                                                              .selectedFrame
                                                              .value]
                                                          .position!
                                                          .mobileNumber!
                                                          .color,
                                                  fontSize: Get.width *
                                                      double.parse(_con
                                                          .frameList[_con
                                                              .selectedFrame
                                                              .value]
                                                          .position!
                                                          .mobileNumber!
                                                          .fontSize!),
                                                  fontFamily: _con.fontFamilyList[
                                                      _con.selectFontStyle.value],
                                                ),
                                              ),
                                            ],
                                          ),
                                          if (_con.business.value!.phoneNumber2!
                                                  .isNotEmpty &&
                                              (_con.selectedFrame.value == 6 ||
                                                  _con.selectedFrame.value == 9 ||
                                                  _con.selectedFrame.value ==
                                                      14 ||
                                                  _con.selectedFrame.value == 15))
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.call,
                                                  color: _con.pickerColor.value !=
                                                          null
                                                      ? _con.pickerColor.value ==
                                                              const Color(
                                                                  0xffffffff)
                                                          ? Colors.white
                                                          : _con.pickerColor.value
                                                      : _con
                                                          .frameList[_con
                                                              .selectedFrame
                                                              .value]
                                                          .position!
                                                          .mobileNumber!
                                                          .color,
                                                  size: Get.width *
                                                      double.parse(_con
                                                          .frameList[_con
                                                              .selectedFrame
                                                              .value]
                                                          .position!
                                                          .mobileNumber!
                                                          .iconSize!),
                                                ),
                                                const SizedBox(
                                                  width: 5,
                                                ),
                                                Text(
                                                  _con.business.value!
                                                      .phoneNumber2!,
                                                  style: TextStyle(
                                                    color: _con.pickerColor
                                                                .value !=
                                                            null
                                                        ? _con.pickerColor
                                                                    .value ==
                                                                const Color(
                                                                    0xffffffff)
                                                            ? Colors.white
                                                            : _con
                                                                .pickerColor.value
                                                        : _con
                                                            .frameList[_con
                                                                .selectedFrame
                                                                .value]
                                                            .position!
                                                            .mobileNumber!
                                                            .color,
                                                    fontSize: Get.width *
                                                        double.parse(_con
                                                            .frameList[_con
                                                                .selectedFrame
                                                                .value]
                                                            .position!
                                                            .mobileNumber!
                                                            .fontSize!),
                                                    fontFamily:
                                                        _con.fontFamilyList[_con
                                                            .selectFontStyle
                                                            .value],
                                                  ),
                                                ),
                                              ],
                                            ),
                                        ],
                                      ),
                                    ),
      
                                  // mobile number 2
                                  if (_con.isWebsite.value)
                                    Positioned(
                                      bottom: Get.width *
                                          double.parse(_con
                                              .frameList[_con.selectedFrame.value]
                                              .position!
                                              .website!
                                              .bottom!),
                                      left: Get.width *
                                          double.parse(_con
                                              .frameList[_con.selectedFrame.value]
                                              .position!
                                              .website!
                                              .left!),
                                      right: Get.width *
                                          double.parse(_con
                                              .frameList[_con.selectedFrame.value]
                                              .position!
                                              .website!
                                              .right!),
                                      child: Row(
                                        mainAxisAlignment: _con
                                            .frameList[_con.selectedFrame.value]
                                            .position!
                                            .website!
                                            .alignment!,
                                        children: [
                                          Icon(
                                            Icons.web_sharp,
                                            color: _con.pickerColor.value != null
                                                ? _con.pickerColor.value ==
                                                        const Color(0xffffffff)
                                                    ? Colors.white
                                                    : _con.pickerColor.value
                                                : _con
                                                    .frameList[
                                                        _con.selectedFrame.value]
                                                    .position!
                                                    .website!
                                                    .color,
                                            size: Get.width *
                                                double.parse(_con
                                                    .frameList[
                                                        _con.selectedFrame.value]
                                                    .position!
                                                    .website!
                                                    .iconSize!),
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          Flexible(
                                            child: Text(
                                              _con.business.value!.website!,
                                              maxLines: int.parse(_con
                                                  .frameList[
                                                      _con.selectedFrame.value]
                                                  .position!
                                                  .website!
                                                  .maxLine!),
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                color: _con.pickerColor.value !=
                                                        null
                                                    ? _con.pickerColor.value ==
                                                            const Color(
                                                                0xffffffff)
                                                        ? Colors.white
                                                        : _con.pickerColor.value
                                                    : _con
                                                        .frameList[_con
                                                            .selectedFrame.value]
                                                        .position!
                                                        .website!
                                                        .color,
                                                fontSize: Get.width *
                                                    double.parse(_con
                                                        .frameList[_con
                                                            .selectedFrame.value]
                                                        .position!
                                                        .website!
                                                        .fontSize!),
                                                fontFamily: _con.fontFamilyList[
                                                    _con.selectFontStyle.value],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
      
                                  //Email
                                  if (_con.isEmail.value)
                                    Positioned(
                                      bottom: Get.width *
                                          double.parse(_con
                                              .frameList[_con.selectedFrame.value]
                                              .position!
                                              .email!
                                              .bottom!),
                                      right: Get.width *
                                          double.parse(_con
                                              .frameList[_con.selectedFrame.value]
                                              .position!
                                              .email!
                                              .right!),
                                      left: Get.width *
                                          double.parse(_con
                                              .frameList[_con.selectedFrame.value]
                                              .position!
                                              .email!
                                              .left!),
                                      child: Row(
                                        mainAxisAlignment: _con
                                            .frameList[_con.selectedFrame.value]
                                            .position!
                                            .email!
                                            .alignment!,
                                        children: [
                                          Icon(
                                            Icons.email,
                                            color: _con.pickerColor.value != null
                                                ? _con.pickerColor.value ==
                                                        const Color(0xffffffff)
                                                    ? Colors.white
                                                    : _con.pickerColor.value
                                                : _con
                                                    .frameList[
                                                        _con.selectedFrame.value]
                                                    .position!
                                                    .email!
                                                    .color,
                                            size: Get.width *
                                                double.parse(_con
                                                    .frameList[
                                                        _con.selectedFrame.value]
                                                    .position!
                                                    .email!
                                                    .iconSize!),
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          Flexible(
                                            child: Text(
                                              _con.business.value!.email!,
                                              maxLines: int.parse(_con
                                                  .frameList[
                                                      _con.selectedFrame.value]
                                                  .position!
                                                  .email!
                                                  .maxLine!),
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                color: _con.pickerColor.value !=
                                                        null
                                                    ? _con.pickerColor.value ==
                                                            const Color(
                                                                0xffffffff)
                                                        ? Colors.white
                                                        : _con.pickerColor.value
                                                    : _con
                                                        .frameList[_con
                                                            .selectedFrame.value]
                                                        .position!
                                                        .email!
                                                        .color,
                                                fontSize: Get.width *
                                                    double.parse(_con
                                                        .frameList[_con
                                                            .selectedFrame.value]
                                                        .position!
                                                        .email!
                                                        .fontSize!),
                                                fontFamily: _con.fontFamilyList[
                                                    _con.selectFontStyle.value],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
      
                                  //Address
                                  if (_con.isAddress.value)
                                    Positioned(
                                      bottom: Get.width *
                                          double.parse(_con
                                              .frameList[_con.selectedFrame.value]
                                              .position!
                                              .address!
                                              .bottom!),
                                      left: Get.width *
                                          double.parse(_con
                                              .frameList[_con.selectedFrame.value]
                                              .position!
                                              .address!
                                              .left!),
                                      right: Get.width *
                                          double.parse(_con
                                              .frameList[_con.selectedFrame.value]
                                              .position!
                                              .address!
                                              .right!),
                                      child: Row(
                                        mainAxisAlignment: _con
                                            .frameList[_con.selectedFrame.value]
                                            .position!
                                            .address!
                                            .alignment!,
                                        children: [
                                          Icon(
                                            Icons.location_on,
                                            color: _con.pickerColor.value != null
                                                ? _con.pickerColor.value ==
                                                        const Color(0xffffffff)
                                                    ? Colors.white
                                                    : _con.pickerColor.value
                                                : _con
                                                    .frameList[
                                                        _con.selectedFrame.value]
                                                    .position!
                                                    .address!
                                                    .color,
                                            size: Get.width *
                                                double.parse(_con
                                                    .frameList[
                                                        _con.selectedFrame.value]
                                                    .position!
                                                    .address!
                                                    .iconSize!),
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          Flexible(
                                            child: Text(
                                              _con.business.value!.address!,
                                              maxLines: int.parse(_con
                                                  .frameList[
                                                      _con.selectedFrame.value]
                                                  .position!
                                                  .address!
                                                  .maxLine!),
                                              textAlign: TextAlign.start,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                color: _con.pickerColor.value !=
                                                        null
                                                    ? _con.pickerColor.value ==
                                                            const Color(
                                                                0xffffffff)
                                                        ? Colors.white
                                                        : _con.pickerColor.value
                                                    : _con
                                                        .frameList[_con
                                                            .selectedFrame.value]
                                                        .position!
                                                        .address!
                                                        .color,
                                                fontSize: Get.width *
                                                    double.parse(_con
                                                        .frameList[_con
                                                            .selectedFrame.value]
                                                        .position!
                                                        .address!
                                                        .fontSize!),
                                                fontFamily: _con.fontFamilyList[
                                                    _con.selectFontStyle.value],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
      
                                  // LOGO
                                  if (_con.isLogo.value &&
                                      _con.business.value!.logo!.isNotEmpty)
                                    Positioned(
                                      left: _con.offset.value.dx,
                                      top: _con.offset.value.dy,
                                      child: Transform.scale(
                                        scale: _con.zoom.value,
                                        child: GestureDetector(
                                          onTap: () {},
                                          behavior: HitTestBehavior.translucent,
                                          onScaleStart: (details) {
                                            _con.previousZoom.value =
                                                _con.zoom.value;
                                            _con.startingFocalPoint.value =
                                                details.focalPoint;
                                            _con.previousOffset.value =
                                                _con.offset.value;
                                          },
                                          onScaleUpdate: (details) {
                                            double newScale =
                                                _con.previousZoom.value *
                                                    details.scale;
      
                                            if (newScale >= 0.1) {
                                              _con.zoom.value = newScale;
                                            }
                                            final Offset normalizedOffset =
                                                (_con.startingFocalPoint.value -
                                                        _con.previousOffset
                                                    .value) /
                                                _con.previousZoom.value;
                                            _con.offset.value =
                                                details.focalPoint -
                                                    normalizedOffset *
                                                        _con.zoom.value;
                                          },
                                          child: Container(
                                            alignment: Alignment.topRight,
                                            width: 120,
                                            height: 120,
                                            child: Image.network(
                                                _con.business.value!.logo!),
                                          ),
                                        ),
                                      ),
                                    )
                                ],
                              ),
                          ],
                        ),
            ),
          ),
        ),
      ),
    );
  }
}
