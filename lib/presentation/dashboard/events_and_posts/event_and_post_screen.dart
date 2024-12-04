import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:lottie/lottie.dart';
import 'package:postervibe/core/utils/app_image.dart';
import 'package:postervibe/core/utils/constant_sizebox.dart';
import 'package:postervibe/presentation/ad/ad_type.dart';
import 'package:postervibe/presentation/ad/ad_unit_id.dart';
import 'package:postervibe/presentation/ad/adaptive_banner.dart';
import 'package:postervibe/presentation/ad/ad_size.dart';
import 'package:postervibe/presentation/dashboard/events_and_posts/event_and_post_con.dart';
import 'package:postervibe/presentation/widget/app_bar.dart';
import 'package:postervibe/core/utils/header.dart';
import 'package:postervibe/presentation/widget/image_card.dart';
import 'package:postervibe/presentation/widget/no_internet.dart';
import 'package:postervibe/presentation/widget/nodata.dart';
import 'package:postervibe/presentation/widget/shimmer.dart';
import 'package:postervibe/routes/app_routes.dart';

class EventAndPostScreen extends StatefulWidget {
  const EventAndPostScreen({super.key});

  @override
  State<EventAndPostScreen> createState() => _EventAndPostScreenState();
}

class _EventAndPostScreenState extends State<EventAndPostScreen> {
  final EventAndPostController _controller = Get.put(EventAndPostController());
  late InlineAdaptiveSize _adSize;
  final ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    _controller.ID.value = Get.arguments[0];
    _controller.eventName.value = Get.arguments[1];
    _controller.getEventAndPostByCategory();
    loadAdSize();
    _controller.connectivityManager.isConnected.listen((isConnected) {
      if (isConnected) {
        _controller.noInternet.value = false;
        _controller.getEventAndPostByCategory();
      } else {
        _controller.noInternet.value = true;
      }
    });
    _scrollController.addListener(_scrollListener);
    super.initState();
  }

  void _scrollListener() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      if (_controller.eventPostList.length < _controller.total.value) {
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
    Size size = MediaQuery.of(Get.context!).size;
    return Obx(
      () => Scaffold(
          appBar: appBar(
            isLeading: true,
            text:
                _controller.noInternet.value ? '' : _controller.eventName.value,
          ),
          body: Obx(() {
            if (_controller.isLoading.value) {
              return primaryShimmer(size);
            }

            if (_controller.noInternet.value) {
              return NoInternetWidget();
            }
            if (_controller.eventPostList.isEmpty) {
              return const NoDataWidget(message: 'No Data Found');
            } else {
              return ListView.separated(
                  controller: _scrollController,
                  addAutomaticKeepAlives: true,
                  itemBuilder: (context, index) {
                    return _controller.eventPostList.length <= index &&
                            _controller.isAdMore.value
                        ? Center(
                            child: LoadingAnimationWidget.hexagonDots(
                                color: Colors.blue, size: 40))
                        : Column(
                            children: [
                              if (_controller.eventPostList[index]
                                  .eventPostList!.isNotEmpty)
                                Column(
                                  children: [
                                    hSizedBox16,
                                    HeaderWidget(
                                      postLength: _controller
                                          .eventPostList[index]
                                          .eventPostList!
                                          .length,
                                      title: _controller
                                          .eventPostList[index].name!,
                                      onTap: () {
                                        Get.toNamed(
                                          AppRoute.digitalPost,
                                          arguments: [
                                            _controller.eventPostList[index].id,
                                            '',
                                            _controller
                                                .eventPostList[index].name,
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
                                          : _controller.eventPostList[index]
                                                  .eventPostList!.isEmpty
                                              ? const Center(
                                                  child: Text("No Data Found"),
                                                )
                                              : ListView.separated(
                                                  addAutomaticKeepAlives: true,
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                    horizontal: 20,
                                                  ),
                                                  itemCount: _controller
                                                      .eventPostList[index]
                                                      .eventPostList!
                                                      .length,
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  shrinkWrap: true,
                                                  separatorBuilder:
                                                      (context, index) =>
                                                          wSizedBox10,
                                                  itemBuilder: (context, ind) {
                                                    final eventPost =
                                                        _controller
                                                                .eventPostList[
                                                                    index]
                                                                .eventPostList![
                                                            ind];
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
                                                                .eventPostList[
                                                                    index]
                                                                .id,
                                                            eventPost.id,
                                                            _controller
                                                                .eventPostList[
                                                                    index]
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
                                  index <
                                      _controller.eventPostList.length - 1 &&
                                  _controller.bottomBarController
                                      .shouldShowAdAvailable)
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
                      ? _controller.eventPostList.length + 1
                      : _controller.eventPostList.length);
            }
          })),
    );
  }
}
