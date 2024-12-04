import 'package:flutter_svg/svg.dart';
import 'package:octo_image/octo_image.dart';
import 'package:postervibe/core/app_export.dart';
import 'package:postervibe/core/utils/loader.dart';

import 'package:postervibe/presentation/dashboard/my_business_list/my_business_list_controller.dart';
import 'package:postervibe/presentation/widget/app_bar.dart';
import 'package:postervibe/presentation/widget/nodata.dart';
import 'package:postervibe/presentation/widget/shimmer.dart';
import 'package:postervibe/routes/app_routes.dart';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class MyBusinessListScreen extends StatefulWidget {
  const MyBusinessListScreen({super.key});

  @override
  State<MyBusinessListScreen> createState() => _MyBusinessListScreenState();
}

class _MyBusinessListScreenState extends State<MyBusinessListScreen> {
  final MyBusinessListController _controller =
      Get.put(MyBusinessListController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(
        text: _controller.noInternet.value ? ' ' : "My Business",
        isLeading: true,
      ),
      floatingActionButton: Obx(
        () => Visibility(
          visible: !_controller.noInternet.value,
          child: FloatingActionButton(
            backgroundColor: AppColors.darkBlueBlack,
            onPressed: () => Get.toNamed(AppRoute.businessDetail, arguments: [
              '',
              false,
              false,
            ]),
            child: const Icon(Icons.add, color: Colors.white),
          ),
        ),
      ),
      body: Obx(() {
        if (_controller.noInternet.value == true) {
          return Center(
            child: SizedBox(
              height: 100,
              width: 100,
              child: Lottie.asset(AppImage.noInternet),
            ),
          );
        }
        if (_controller.isLoading.value == true) {
          return Center(
            child: SizedBox(
              height: 100,
              width: 100,
              child: Lottie.asset(AppImage.loader),
            ),
          );
        }
        if (_controller.businessList.isEmpty) {
          return Center(
            child: NoDataWidget(message: 'No Data Found'),
          );
        } else {
          return SingleChildScrollView(
            child: Column(
              children: [
                ListView.separated(
                  shrinkWrap: true,
                  primary: false,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  physics: const ClampingScrollPhysics(),
                  itemCount: _controller.businessList.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 10),
                  itemBuilder: (context, index) {
                    return Stack(
                      children: [
                        GestureDetector(
                          onTap: () {
                            if (_controller.businessList[index].isDefault ==
                                false) {
                              _controller.updateSelectedIndexBusinessList(
                                  context: context, updateIndex: index);
                            }
                          },
                          child: Container(
                            key: UniqueKey(),
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: AppColors.grey97,
                              borderRadius: BorderRadius.circular(10),
                              border:
                                  Border.all(color: AppColors.appBluePurple),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  height: 60,
                                  width: 60,
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade300,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: _controller
                                            .businessList[index].logo!.isEmpty
                                        ? Image.asset(
                                            AppImage.defaultImage,
                                            filterQuality: FilterQuality.low,
                                          )
                                        : OctoImage(
                                            image: NetworkImage(
                                              _controller
                                                  .businessList[index].logo!,
                                            ),
                                            fit: BoxFit.contain,
                                            placeholderBuilder: (context) =>
                                                mainImageShimmer(
                                                    const Size(60, 120), true),
                                            errorBuilder:
                                                (context, error, stackTrace) =>
                                                    Image.asset(
                                              AppImage.defaultImage,
                                              filterQuality: FilterQuality.low,
                                            ),
                                          ),
                                  ),
                                ),
                                const SizedBox(width: 20),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text(
                                          _controller.businessList[index]
                                                  .businessName ??
                                              '',
                                          maxLines: 1,
                                          style: const TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w600)),
                                      const SizedBox(height: 8),
                                      Row(
                                        children: [
                                          const Icon(Icons.business_center,
                                              size: 15),
                                          const SizedBox(width: 6),
                                          Expanded(
                                            child: Text(
                                              _controller.businessList[index]
                                                      .businessCategoryName ??
                                                  '',
                                              maxLines: 1,
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w400,
                                                  color: Colors.black
                                                      .withOpacity(.8)),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    IconButton(
                                      constraints: const BoxConstraints(),
                                      onPressed: () {
                                        Get.toNamed(AppRoute.businessDetail,
                                            arguments: [
                                              _controller.businessList[index],
                                              true,
                                              false
                                            ]);
                                      },
                                      icon: Padding(
                                        padding: const EdgeInsets.all(2.0),
                                        child: SvgPicture.asset(
                                          AppImage.myBusinessEdit,
                                          semanticsLabel: 'editIcon',
                                          color: AppColors.darkBlueBlack,
                                        ),
                                      ),
                                    ),
                                    IconButton(
                                      constraints: const BoxConstraints(),
                                      onPressed: () async {
                                       DialogueHelper.logoutDialog(
                                          title: "Warning!".tr,
                                          description:
                                              "Are you sure want to delete this Business?"
                                                  .tr,
                                          color: AppColors.darkBlueBlack,
                                          context: Get.context!,
                                          onTap: () async {
                                            if (_controller.businessList[index]
                                                        .isDefault ==
                                                    true &&
                                                _controller
                                                        .businessList.length >
                                                    1) {
                                              _controller
                                                  .updateSelectedIndexBusinessList(
                                                      context: context,
                                                      updateIndex:
                                                          index == 0 ? 1 : 0,
                                                      deleteIndex: index);
                                            } else {
                                              _controller.deleteBusiness(index);
                                            }
                                            Get.back();
                                          },
                                        );
                                      },
                                      icon: Padding(
                                        padding: const EdgeInsets.all(2.0),
                                        child: SvgPicture.asset(
                                          AppImage.myBusinessDelete,
                                          semanticsLabel: 'deleteIcon',
                                          color: AppColors.deleteIconRed,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        Obx(() => _controller.businessList[index].isDefault!
                            ? Container(
                                height: 25,
                                width: 25,
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                    fit: BoxFit.fill,
                                    image: AssetImage(
                                      AppImage.check,
                                    ),
                                  ),
                                ),
                              )
                            : const SizedBox())
                      ],
                    );
                  },
                ),
              ],
            ),
          );
        }
      }),
    );
  }
}
