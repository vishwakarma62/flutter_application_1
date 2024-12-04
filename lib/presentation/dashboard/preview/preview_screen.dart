import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:lottie/lottie.dart';
import 'package:postervibe/presentation/ad/ad_type.dart';
import 'package:postervibe/presentation/ad/ad_unit_id.dart';
import 'package:postervibe/presentation/ad/simple_banner.dart';
import 'package:postervibe/presentation/dashboard/preview/preview_controller.dart';
import 'package:postervibe/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:postervibe/core/app_export.dart';

import '../../widget/app_bar.dart';

class PreviewScreen extends StatefulWidget {
  PreviewScreen({Key? key}) : super(key: key);

  @override
  State<PreviewScreen> createState() => _PreviewScreenState();
}

class _PreviewScreenState extends State<PreviewScreen> {
  final PreviewController _controller = Get.put(PreviewController());
  @override
  void didChangeDependencies() {
    _controller.setContext(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(
        text: "preview".tr,
        isLeading: true,
      ),
      bottomNavigationBar: Builder(
        builder: (BuildContext context) {
          if (_controller.bottomBarController.shouldShowAdAvailable) {
            return AdmobBanner(
              adUnitId: AdUnitIds.getTestAdUnitId(adType: AdType.banner),
              adSize: AdSize.banner,
            );
          }
          return const SizedBox.shrink();
        },
      ),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          final screenHeight = constraints.maxHeight;
          final logoHeight =
              screenHeight < _controller.heightThreshold ? 100.0 : 80.0;
          final boxsize =
              screenHeight < _controller.heightThreshold ? 50.0 : 40.0;

          return SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 20.0),
                Container(
                  alignment: Alignment.center,
                  height: logoHeight,
                  child: Center(
                    child: SvgPicture.asset(
                      AppImage.appIcon,
                      color: AppColors.darkBlueBlack,
                    ),
                  ),
                ),
                AspectRatio(
                  aspectRatio: 1,
                  child: Container(
                    margin: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: _controller.downloadImage
                            ? MemoryImage(_controller.data)
                            : FileImage(_controller.data) as ImageProvider,
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const SizedBox(width: 20.0),
                    previewOption(
                        icon: AppImage.share,
                        size: boxsize,
                        onTap: _controller.canShare.value
                            ? () => _controller.share(context)
                            : () {}),
                    previewOption(
                      icon: AppImage.home,
                      size: boxsize,
                      onTap: () {
                        Get.offAllNamed(AppRoute.bottom, arguments: 0);
                      },
                    ),
                    if (_controller.downloadImage)
                      GestureDetector(
                        onTap: () {
                          _controller.download();
                        },
                        child: Obx(
                          () => Container(
                            width: boxsize,
                            height: boxsize,
                            margin: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                              border: Border.all(
                                color: AppColors.appBluePurple,
                              ),
                            ),
                            child: _controller.isLoading.value
                                ? Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Lottie.asset(
                                      AppImage.loader,
                                    ),
                                  )
                                : Padding(
                                    padding: boxsize == 50
                                        ? const EdgeInsets.all(14)
                                        : const EdgeInsets.all(10),
                                    child: SvgPicture.asset(
                                      AppImage.download,
                                    ),
                                  ),
                          ),
                        ),
                      ),
                    SizedBox(width: 20.0),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget previewOption({
    required String icon,
    required double size,
    required Function() onTap,
  }) {
    final double paddingValue = size == 50.0 ? 14.0 : 10.0;
    final EdgeInsetsGeometry padding = EdgeInsets.all(paddingValue);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size,
        height: size,
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          border: Border.all(
            color: AppColors.appBluePurple,
          ),
        ),
        child: Padding(
          padding: padding,
          child: SvgPicture.asset(
            icon,
          ),
        ),
      ),
    );
  }
}
