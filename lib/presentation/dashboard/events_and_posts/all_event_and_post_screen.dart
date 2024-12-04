import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:lottie/lottie.dart';
import 'package:postervibe/core/app_export.dart';
import 'package:postervibe/core/utils/header.dart';
import 'package:postervibe/presentation/ad/ad_type.dart';
import 'package:postervibe/presentation/ad/ad_unit_id.dart';
import 'package:postervibe/presentation/ad/adaptive_banner.dart';
import 'package:postervibe/presentation/ad/ad_size.dart';
import 'package:postervibe/presentation/dashboard/events_and_posts/all_event_and_post_con.dart';
import 'package:postervibe/presentation/widget/app_bar.dart';
import 'package:postervibe/presentation/widget/image_card.dart';
import 'package:postervibe/presentation/widget/nodata.dart';
import 'package:postervibe/presentation/widget/shimmer.dart';
import 'package:postervibe/routes/app_routes.dart';

class AllEventAndPostScreen extends StatefulWidget {
  const AllEventAndPostScreen({super.key});

  @override
  State<AllEventAndPostScreen> createState() => _AllEventAndPostScreenState();
}

class _AllEventAndPostScreenState extends State<AllEventAndPostScreen> {
  final PostController _controller = Get.put(PostController());
  late InlineAdaptiveSize _adSize;
  final ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    loadAdSize();
    _controller.fetchInitialData();
    _scrollController.addListener(_scrollListener);
    super.initState();
  }

  void _scrollListener() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      if (_controller.postLists.length < _controller.total.value) {
        _controller.isAdMore.value = true;
        _controller.loadMoreData();
      } else {
        _controller.isAdMore.value = false;
      }
    }
  }

  loadAdSize() async {
    _adSize =
        (await AdmobBannerSize.customPortraitAdaptiveBannerAdSize(context))!;
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: appBar(
        text: "Event And Posts".tr,
        actionIcon: AppImage.editpost,
      ),
      body: Obx(() {
        if (_controller.noInternet.value) {
          return Center(
            child: SizedBox(
              height: 100,
              width: 100,
              child: Lottie.asset(AppImage.noInternet),
            ),
          );
        }
        if (_controller.isLoading.value) {
          return primaryShimmer(size);
        }
        if (_controller.postLists.isEmpty) {
          return const NoDataWidget(message: 'No Data found found');
        } else {
          return ListView.separated(
              controller: _scrollController,
              addAutomaticKeepAlives: true,
              itemBuilder: (context, index) {
                return _controller.postLists.length <= index &&
                        _controller.isAdMore.value
                    ? Center(
                        child: LoadingAnimationWidget.hexagonDots(
                            color: Colors.blue, size: 40))
                    : Column(
                        children: [
                          if (_controller
                              .postLists[index].eventPostList!.isNotEmpty)
                            Column(
                              children: [
                                hSizedBox16,
                                HeaderWidget(
                                  postLength: _controller
                                      .postLists[index].eventPostList!.length,
                                  title: _controller.postLists[index].name!,
                                  onTap: () {
                                    Get.toNamed(
                                      AppRoute.digitalPost,
                                      arguments: [
                                        _controller.postLists[index].id,
                                        '',
                                        _controller.postLists[index].name,
                                      ],
                                    );
                                  },
                                ),
                                hSizedBox6,
                                SizedBox(
                                  height: Get.width / 3,
                                  width: Get.width,
                                  child: _controller.isLoading.value
                                      ? Lottie.asset(AppImage.loader)
                                      : _controller.postLists[index]
                                              .eventPostList!.isEmpty
                                          ? const Center(
                                              child: Text("No Data Found"),
                                            )
                                          : ListView.separated(
                                              addAutomaticKeepAlives: true,
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                horizontal: 20,
                                              ),
                                              itemCount: _controller
                                                  .postLists[index]
                                                  .eventPostList!
                                                  .length,
                                              scrollDirection: Axis.horizontal,
                                              shrinkWrap: true,
                                              separatorBuilder:
                                                  (context, index) =>
                                                      wSizedBox10,
                                              itemBuilder: (context, ind) {
                                                final eventPost = _controller
                                                    .postLists[index]
                                                    .eventPostList![ind];
                                                return ImageCard(
                                                  width: Get.width / 3.5,
                                                  height: Get.width / 3.5,
                                              
                                                  imageUrl: eventPost
                                                      .eventPostImageThumbnail!,
                                                  onImageClick: () {
                                                    Get.toNamed(
                                                      AppRoute.digitalPost,
                                                      arguments: [
                                                        _controller
                                                            .postLists[index]
                                                            .id,
                                                        eventPost.id,
                                                        _controller
                                                            .postLists[index]
                                                            .name,
                                                      ],
                                                    );
                                                  },
                                                  isNetwork: true,
                                                );
                                              },
                                            ),
                                ),
                              ],
                            ),
                          if (index % 5 == 0 &&
                              index > 0 &&
                              index < _controller.postLists.length - 1 &&
                              _controller
                                  .bottomBarController.shouldShowAdAvailable)
                            AdaptiveBannerAd(
                              key: Key('ad_item_${index ~/ 2}'),
                              onAdLoaded: () {},
                              adUnitId: AdUnitIds.getTestAdUnitId(
                                  adType: AdType.banner),
                              adRequest: AdRequest(),
                              adSize: _adSize,
                            )
                        ],
                      );
              },
              separatorBuilder: (context, index) {
                return hSizedBox0;
              },
              itemCount: _controller.isAdMore.value
                  ? _controller.postLists.length + 1
                  : _controller.postLists.length);
        }
      }),
    );
  }
}
