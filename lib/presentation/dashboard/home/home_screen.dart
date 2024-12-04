import 'dart:math';

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'package:lottie/lottie.dart';
import 'package:octo_image/octo_image.dart';
import 'package:postervibe/core/app_export.dart';
import 'package:postervibe/presentation/bottom_bar/bottom_bar_controller.dart';
import 'package:postervibe/presentation/dashboard/home/demo.dart';

import 'package:postervibe/presentation/dashboard/home/home_controller.dart';
import 'package:postervibe/presentation/widget/circular_image_widget.dart';
import 'package:postervibe/presentation/widget/image_card.dart';
import 'package:postervibe/presentation/widget/shimmer.dart';
import 'package:postervibe/routes/app_routes.dart';

import '../../../core/utils/header.dart';
import '../../widget/app_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeController _controller = Get.put(HomeController());
  BottomBarController bottomBarController = Get.find();

  @override
  void initState() {
    super.initState();
    _controller.getBannerList();
    _controller.getTodayEventList();
    _controller.getCategoryList();
    _controller.getPostList();
    _controller.getBusinessList();
  }

  late double height;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    height = max(size.height * .05, 50.0);
    return Obx(
      () => Scaffold(
        appBar: appBar(
          back: false,
          isSearch: _controller.noInternet.value ? false : true,
          action: false,
          centerLogo: _controller.noInternet.value ? false : true,
          isLeading: _controller.noInternet.value ? false : true,
          onPressLeading: _controller.noInternet.value
              ? null
              : () {
                  Get.toNamed(AppRoute.myBusinessList);
                },
          onPressAction: () {},
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
          if (_controller.isCategoryListLoading.value ||
              _controller.isUpcomingFestivalLoading.value ||
              _controller.isTodayEventLoading.value ||
              _controller.isBannerLoading.value) {
            return homeScreenShimmer(size);
          } else {
            return SingleChildScrollView(
              physics: _controller.isCategoryListLoading.value ||
                      _controller.isUpcomingFestivalLoading.value ||
                      _controller.isTodayEventLoading.value ||
                      _controller.isBannerLoading.value
                  ? const NeverScrollableScrollPhysics()
                  : const RangeMaintainingScrollPhysics(),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _controller.bannerList.isEmpty
                      ? const Text("No Data found found")
                      : CarouselSlider(
                          carouselController: _controller.carouselController,
                          options: CarouselOptions(
                            enlargeCenterPage: true,
                            aspectRatio: 2.2,
                            viewportFraction: .9,
                            enableInfiniteScroll: true,
                            autoPlay: true,
                            reverse: false,
                            onPageChanged: (i, reason) =>
                                _controller.selectedIndex.value = i,
                          ),
                          items: _controller.bannerList.map((item) {
                            return Container(
                              margin: const EdgeInsets.symmetric(vertical: 10),
                              width: Get.width,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(.15),
                                    offset: const Offset(0, 3),
                                    blurRadius: 10,
                                  ),
                                ],
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: OctoImage(
                                  image: NetworkImage(item.imagePath ?? ''),
                                  fit: BoxFit.cover,
                                  placeholderBuilder: (context) =>
                                      mainImageShimmer(size, true),
                                  errorBuilder: (context, error, stackTrace) =>
                                      Image.asset(
                                    AppImage.defaultImage,
                                    filterQuality: FilterQuality.low,
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                  const SizedBox(height: 10),
                  Obx(
                    () => Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: _controller.bannerList
                          .asMap()
                          .map(
                            (i, item) => MapEntry(
                              i,
                              GestureDetector(
                                onTap: () {
                                  _controller.carouselController.jumpToPage(i);
                                },
                                child: Container(
                                  height: 10,
                                  width: _controller.selectedIndex.value == i
                                      ? 20
                                      : 10,
                                  margin: const EdgeInsets.only(right: 5),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: _controller.selectedIndex.value == i
                                        ? AppColors.carouselSLiderVoilet
                                        : AppColors.carouselSLiderMercury,
                                  ),
                                ),
                              ),
                            ),
                          )
                          .values
                          .toList(),
                    ),
                  ),
                  if (_controller.todaysEventList.isNotEmpty)
                    Column(
                      children: [
                        const SizedBox(height: 16),
                        HeaderWidget(
                          showViewAll: false,
                          postLength: _controller.todaysEventList.length,
                          title: "Today's For You",
                          onTap: () {},
                        ),
                        const SizedBox(height: 16),
                        SizedBox(
                          height: 116,
                          width: Get.width,
                          child: ListView.separated(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            itemCount: _controller.todaysEventList.length,
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            separatorBuilder: (context, index) =>
                                const SizedBox(width: 10),
                            itemBuilder: (context, ind) {
                              final val = _controller.todaysEventList[ind];
                              return ImageCard(
                                key: UniqueKey(),
                                width: Get.width / 3.5,
                                height: Get.width / 3.5,
                             
                                imageUrl: val.eventImageThumbnail ?? '',
                                onImageClick: () {
                                  Get.toNamed(
                                    AppRoute.digitalPost,
                                    arguments: [
                                      _controller.todaysEventList[ind].id,
                                      _controller.todaysEventList[ind].id,
                                      _controller.todaysEventList[ind].name
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
                  Column(
                    children: [
                      const SizedBox(height: 16),
                      HeaderWidget(
                        postLength: _controller.categoryList.length,
                        title: 'Category',
                        onTap: () {
                          Get.toNamed(AppRoute.category);
                        },
                      ),
                      const SizedBox(height: 6),
                      SizedBox(
                        height: Get.width / 4.5,
                        width: Get.width,
                        child: _controller.isCategoryListLoading.value
                            ? Lottie.asset(AppImage.loader)
                            : _controller.categoryList.isEmpty
                                ? const Center(
                                    child: Text(
                                      "No Data found available.",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  )
                                : ListView.separated(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    itemCount: _controller.categoryList.length,
                                    scrollDirection: Axis.horizontal,
                                    shrinkWrap: true,
                                    separatorBuilder: (context, index) =>
                                        const SizedBox(width: 10),
                                    itemBuilder: (context, ind) {
                                      final category =
                                          _controller.categoryList[ind];
                                      return Column(
                                        children: [
                                          CircularImageWidget(
                                            height: Get.width / 4.5,
                                            width: Get.width / 4.5,
                                            onTap: () {
                                              Get.toNamed(AppRoute.eventAndPost,
                                                  arguments: [
                                                    _controller
                                                        .categoryList[ind].id,
                                                    _controller
                                                        .categoryList[ind].name,
                                                  ]);
                                            },
                                            imageUrl: category.categoryImage!,
                                          ),
                                        ],
                                      );
                                    },
                                  ),
                      ),
                    ],
                  ),
                  if (_controller.isUpcomingFestivalLoading.value)
                    AspectRatio(
                      aspectRatio: 2.3,
                      child: Lottie.asset(AppImage.loader),
                    )
                  else if (_controller.postList.isEmpty)
                    const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.sentiment_dissatisfied,
                          size: 100,
                          color: Color.fromARGB(255, 189, 189, 189),
                        ),
                        SizedBox(height: 20),
                        Text(
                          "Oops! Nothing here yet.",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 66, 66, 66),
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          "Placeholder text for the message.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            color: Color.fromARGB(255, 117, 117, 117),
                          ),
                        ),
                        SizedBox(height: 20),
                      ],
                    )
                  else
                    Column(
                      children: [
                        for (var i = 0; i < _controller.postList.length; i++)
                          Column(
                            children: [
                              const SizedBox(height: 16),
                              HeaderWidget(
                                postLength: _controller
                                    .postList[i].eventPostByEventList!.length,
                                title: _controller.postList[i].eventName!,
                                onTap: () {
                                  Get.toNamed(
                                    AppRoute.digitalPost,
                                    arguments: [
                                      _controller.postList[i].id,
                                      '',
                                      _controller.postList[i].eventName
                                    ],
                                  );
                                },
                              ),
                              const SizedBox(height: 6),
                              SizedBox(
                                height: Get.width / 3.5,
                                width: Get.width,
                                child: _controller
                                        .isUpcomingFestivalLoading.value
                                    ? _buildLoadingWidget()
                                    : _controller.postList[i]
                                            .eventPostByEventList!.isEmpty
                                        ? _buildNoDataWidget()
                                        : ListView.separated(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 20),
                                            itemCount: _controller.postList[i]
                                                .eventPostByEventList!.length,
                                            scrollDirection: Axis.horizontal,
                                            shrinkWrap: true,
                                            separatorBuilder:
                                                (context, index) =>
                                                    const SizedBox(width: 10),
                                            itemBuilder: (context, ind) {
                                              final post = _controller
                                                  .postList[i]
                                                  .eventPostByEventList![ind];
                                              return ImageCard(
                                                key: UniqueKey(),
                                                width: Get.width / 3.5,
                                                height: Get.width / 3.5,
                                              
                                                imageUrl: post
                                                    .eventPostImageThumbnail!,
                                                onImageClick: () {
                                                  Get.toNamed(
                                                    AppRoute.digitalPost,
                                                    arguments: [
                                                      _controller
                                                          .postList[i].id,
                                                      post.id,
                                                      _controller
                                                          .postList[i].eventName
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
                      ],
                    ),
                  SizedBox(
                    height: bottomBarController.shouldShowAdAvailable
                        ? height + 8
                        : 8,
                  )
                ],
              ),
            );
          }
        }),
      ),
    );
  }

  Widget _buildLoadingWidget() {
    return Center(
      child: Lottie.asset(
        AppImage.loader,
        width: 100, // Adjust the width as needed
        height: 100, // Adjust the height as needed
      ),
    );
  }

  Widget _buildNoDataWidget() {
    return const Center(
      child: Text("No Data found found"),
    );
  }
}
