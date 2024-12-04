import 'package:flutter_svg/svg.dart';
import 'package:octo_image/octo_image.dart';
import 'package:postervibe/presentation/dashboard/digital_post/digital_post_controller.dart';
import 'package:postervibe/presentation/widget/app_bar.dart';
import 'package:postervibe/presentation/widget/image_card.dart';
import 'package:postervibe/presentation/widget/no_internet.dart';
import 'package:postervibe/presentation/widget/nodata.dart';
import 'package:postervibe/presentation/widget/shimmer.dart';
import 'package:postervibe/routes/app_routes.dart';
import 'package:flutter/material.dart';

import '../../../core/app_export.dart';

class DigitalPostScreen extends StatelessWidget {
  DigitalPostScreen({super.key});

  final DigitalPostController _con = Get.put(DigitalPostController());

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(Get.context!).size;

    return Obx(
      () => Scaffold(
          appBar: appBar(
              text: _con.noInternet.value ? '' : _con.eventName.value,
              action: _con.noInternet.value ? false : true,
              isDisabled: _con.postList.isEmpty ? true : false,
              isLeading: true,
              actionIcon: AppImage.editpost,
              onPressAction: _con.postList.isEmpty || _con.isLoading.value
                  ? () {}
                  : () async {
                      _con.selectedBusinessId.isEmpty
                          ? Get.toNamed(AppRoute.businessDetail, arguments: [
                              Data(
                                  eventId: _con.eventID.value,
                                  eventName: _con.eventName.value,
                                  postId: _con.postId.value),
                              false,
                              false,
                            ])
                          : Get.toNamed(AppRoute.postEditor, arguments: [
                              _con.postList[_con.selectIndex.value]
                                  .eventPostImage,
                              _con.selectedBusinessId
                            ]);
                    }),
          body: Obx(() {
            if (_con.noInternet.value == true) {
              return NoInternetWidget();
            }

            if (_con.isLoading.value) {
              return postShimmer(size);
            }
            if (_con.postList.isEmpty) {
              return NoDataWidget(message: 'No Data Found');
            } else {
              return Column(
                children: [
                  hSizedBox10,
                  Container(
                    height: Get.width - 20,
                    width: Get.width - 20,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          offset: const Offset(0, 3),
                          blurRadius: 20,
                        ),
                      ],
                    ),
                    child: _con.postList.isEmpty
                        ? Center(
                            child: SvgPicture.asset(AppImage.noData),
                          )
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: OctoImage(
                              image: NetworkImage(_con
                                  .postList[_con.selectIndex.value]
                                  .eventPostImage!),
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
                  hSizedBox8,
                  SizedBox(
                    width: Get.width,
                    height: Get.width * 0.06,
                    child: _con.languageList.isEmpty
                        ? const Center(
                            child: Text(
                              "",
                              style: TextStyle(
                                // fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey,
                              ),
                            ),
                          )
                        : ListView.builder(
                            physics: const ClampingScrollPhysics(),
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            scrollDirection: Axis.horizontal,
                            itemCount: _con.languageList.length,
                            itemBuilder: (context, index) {
                              return Obx(
                                () => GestureDetector(
                                    onTap: () {
                                      _con.postLanguage.value =
                                          _con.languageList[index];

                                      _con.postList.clear();
                                      _con.selectIndex.value = 0;

                                      for (var element in _con.data) {
                                        if (_con.postLanguage.value == "All") {
                                          _con.postList.add(element);
                                        } else if (element.language ==
                                            _con.postLanguage.value) {
                                          _con.postList.add(element);
                                        }
                                      }
                                    },
                                    child: Container(
                                      margin: EdgeInsets.only(
                                          right: index ==
                                                  _con.languageList.length - 1
                                              ? 0
                                              : 10),
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        gradient: _con.postLanguage.value ==
                                                _con.languageList[index]
                                            ? LinearGradient(
                                                colors: [
                                                  Color(
                                                      0xFF5D54B3), // AppColors.appBluePurple
                                                  Color(
                                                      0xFF7886D7), // Lighter shade
                                                  Color(
                                                      0xFF3C3988), // Darker shade
                                                ],
                                                begin: Alignment.topLeft,
                                                end: Alignment.bottomRight,
                                              )
                                            : null,
                                        color: _con.postLanguage.value ==
                                                _con.languageList[index]
                                            ? null
                                            : Colors.white,
                                        borderRadius: BorderRadius.circular(5),
                                        border: Border.all(
                                          color: _con.postLanguage.value ==
                                                  _con.languageList[index]
                                              ? AppColors.appBluePurple
                                              : AppColors.darkBlueBlack,
                                        ),
                                      ),
                                      child: FittedBox(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 15, vertical: 4),
                                          child: Text(
                                            _con.languageList[index].tr,
                                            style: TextStyle(
                                              color: _con.postLanguage.value ==
                                                      _con.languageList[index]
                                                  ? Colors.white
                                                  : AppColors.darkBlueBlack,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      ),
                                    )),
                              );
                            },
                          ),
                  ),
                  hSizedBox4,
                  Obx(
                    () => _con.postList.isEmpty
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
                        : Expanded(
                            child: GridView.builder(
                              padding: const EdgeInsets.all(15),
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                crossAxisSpacing: 8,
                                mainAxisSpacing: 8,
                              ),
                              itemCount: _con.postList.length,
                              shrinkWrap: true,
                              physics: const ScrollPhysics(),
                              primary: true,
                              itemBuilder: (BuildContext ctx, index) {
                                var val = _con.postList[index];

                                return Obx(
                                  () => GestureDetector(
                                    onTap: () {
                                      _con.selectIndex.value = index;
                                    },
                                    child: Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        ImageCard(
                                          key: UniqueKey(),
                                          width: Get.width / 3.5,
                                          height: Get.width / 3.5,
                                          imageUrl:
                                              val.eventPostImageThumbnail!,
                                          isNetwork: true,
                                        ),
                                        if (_con.selectIndex.value == index)
                                          Container(
                                            width: Get.width / 3.5,
                                            height: Get.width / 3.5,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(10)),
                                              color:
                                                  Colors.black.withOpacity(0.3),
                                            ),
                                            child: const Icon(
                                              Icons.done_rounded,
                                              color: Colors.white,
                                              size: 50,
                                            ),
                                          ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                  )
                ],
              );
            }
          })),
    );
  }
}
