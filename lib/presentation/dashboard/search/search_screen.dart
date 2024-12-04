import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:postervibe/presentation/ad/ad_type.dart';
import 'package:postervibe/presentation/ad/ad_unit_id.dart';
import 'package:postervibe/presentation/ad/simple_banner.dart';
import 'package:postervibe/presentation/dashboard/search/search_controller.dart';
import 'package:postervibe/presentation/widget/app_bar.dart';
import 'package:postervibe/presentation/widget/image_card.dart';
import 'package:postervibe/presentation/widget/no_internet.dart';
import 'package:postervibe/presentation/widget/nodata.dart';
import 'package:postervibe/presentation/widget/shimmer.dart';
import 'package:postervibe/routes/app_routes.dart';
import '../../../core/app_export.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({super.key});

  final SearchScreenController _controller = Get.put(SearchScreenController());

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: Obx(
          () => Scaffold(
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
            appBar: appBar(
              searchfield: _controller.noInternet.value ? false : true,
              isLeading: true,
              text: _controller.noInternet.value ? '' : "Search".tr,
              isSearch: false,
              action: false,
              controller: _controller,
            ),
            body: Obx(() {
              if (_controller.isLoading.value) {
                return gridBox(size);
              }
              if (_controller.noInternet.value) {
                return NoInternetWidget();
              }

              if (_controller.searchedEventList.isEmpty) {
                return NoDataWidget(message: 'No Data Found');
              }
              return GridView.builder(
                addAutomaticKeepAlives: true,
                controller: _controller.scrollController,
                padding: const EdgeInsets.only(
                    left: 15, right: 15, bottom: 15, top: 10),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  mainAxisExtent: 150,
                ),
                itemCount: _controller.isPageLoading
                    ? _controller.searchedEventList.length + 10
                    : _controller.searchedEventList.length,
                shrinkWrap: true,
                primary: false,
                itemBuilder: (BuildContext ctx, index) {
                  if (_controller.searchedEventList.length <= index) {
                    return Column(
                      children: [
                        AspectRatio(
                          aspectRatio: 1,
                          child: mainImageShimmer(
                              Size(Get.width / 3, Get.width / 3), true),
                        ),
                      ],
                    );
                  }

                  return _controller.searchedEventList[index]
                          .eventImageThumbnail!.isNotEmpty
                      ? Column(
                          key: UniqueKey(),
                          children: [
                            AspectRatio(
                              aspectRatio: 1,
                              child: ImageCard(
                                width: Get.width / 3,
                                height: Get.width / 3,
                                onImageClick: () {
                                  Get.toNamed(AppRoute.digitalPost, arguments: [
                                    _controller.searchedEventList[index].id,
                                    '',
                                    _controller.searchedEventList[index].name,
                                  ]);
                                },
                                date: Helper.getMonthName(_controller
                                    .searchedEventList[index].eventDate!
                                    .toString()),
                                imageUrl: _controller.searchedEventList[index]
                                    .eventImageThumbnail!,
                                isNetwork: true,
                              ),
                            ),
                            hSizedBox6,
                            Container(
                              alignment: Alignment.center,
                              width: 103,
                              child: Text(
                                _controller.searchedEventList[index].name!,
                                maxLines: 2,
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ],
                        )
                      : SizedBox.shrink();
                },
              );
            }),
          ),
        ),
      ),
    );
  }
}
