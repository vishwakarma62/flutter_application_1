import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:octo_image/octo_image.dart';
import 'package:postervibe/core/local_storage.dart';
import 'package:postervibe/core/utils/app_color.dart';
import 'package:postervibe/core/utils/app_config.dart';
import 'package:postervibe/core/utils/app_image.dart';
import 'package:postervibe/core/utils/loader.dart';
import 'package:postervibe/presentation/dashboard/download/download_controller.dart';
import 'package:postervibe/presentation/widget/app_bar.dart';
import 'package:postervibe/presentation/widget/nodata.dart';
import 'package:postervibe/presentation/widget/shimmer.dart';

class DownloadScreen extends StatefulWidget {
  const DownloadScreen({super.key});

  @override
  State<DownloadScreen> createState() => _DownloadScreenState();
}

class _DownloadScreenState extends State<DownloadScreen>
    with WidgetsBindingObserver {
  final DownloadController _controller = Get.put(DownloadController());
  @override
  void initState() {
    super.initState();
    _controller.userID.value = LocalStorage.userId;
    _controller.selectIndex.value = 0;
    _controller.getMyPost();
    _controller.connectivityManager.isConnected.listen((isConnected) {
      if (isConnected) {
        _controller.noInternet.value = false;
      } else {
        _controller.noInternet.value = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(
        text: "Download".tr,
      ),
      body: Obx(() {
        if (_controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator.adaptive());
        }
        if (_controller.myPostLists.isEmpty) {
          return const NoDataWidget(message: 'No Data Found');
        }

        if (_controller.noInternet.value) {
          return Center(
            child: SizedBox(
              height: 100,
              width: 100,
              child: Lottie.asset(AppImage.noInternet),
            ),
          );
        }
        if (_controller.noInternet.value == false) {
          return SingleChildScrollView(
            child: GridView.builder(
              padding: const EdgeInsets.all(15),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              itemCount: _controller.myPostLists.length,
              shrinkWrap: true,
              physics: const ScrollPhysics(),
              primary: false,
              itemBuilder: (BuildContext ctx, index) {
                return GestureDetector(
                  onTap: () {
                    _controller.goToShare(
                        _controller.myPostLists[index].postImage!, context);
                  },
                  child: Stack(
                    children: [
                      AspectRatio(
                        aspectRatio: 1,
                        child: OctoImage(
                          errorBuilder: (context, error, stackTrace) {
                            return Image.asset(
                              AppImage.defaultImage,
                              filterQuality: FilterQuality.low,
                            );
                          },
                          fit: BoxFit.cover,
                          image: NetworkImage(_controller
                              .myPostLists[index].postImageThumbnail!),
                          placeholderBuilder: (context) {
                            return mainImageShimmer(
                                Size(Get.width / 3.5, Get.width / 3.5), true);
                          },
                        ),
                      ),
                      Positioned(
                        right: 0,
                        top: 0,
                        child: InkWell(
                          onTap: () {
                            DialogueHelper.logoutDialog(
                              title: AppConfig.deleteTittle,
                              description: AppConfig.deleteContent,
                              color: AppColors.darkShadeBlue,
                              context: Get.context!,
                              onTap: () {
                                Get.back();
                                _controller.deleteMyPost(index, context);
                              },
                            );
                          },
                          child: Container(
                            height: 28,
                            width: 28,
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.3),
                                  spreadRadius: 2,
                                  blurRadius: 4,
                                  offset: Offset(0, 4),
                                ),
                              ],
                              gradient: LinearGradient(
                                colors: [
                                  AppColors.startGradientColor,
                                  AppColors.middleGradientColor,
                                  AppColors.endGradientColor,
                                ],
                                stops: [0.2, 0.5, 1.0],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                              ),
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(20),
                              ),
                            ),
                            child: const Center(
                              child: Padding(
                                padding:
                                    EdgeInsets.only(left: 3.5, bottom: 3.5),
                                child: Icon(
                                  Icons.delete_sharp,
                                  size: 15,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        }
        return const SizedBox();
      }),
    );
  }
}
