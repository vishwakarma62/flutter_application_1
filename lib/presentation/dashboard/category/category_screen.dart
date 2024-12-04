import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:postervibe/core/utils/constant_sizebox.dart';
import 'package:postervibe/presentation/dashboard/category/category_controller.dart';
import 'package:postervibe/presentation/widget/app_bar.dart';
import 'package:postervibe/presentation/widget/circular_image_widget.dart';
import 'package:postervibe/presentation/widget/no_internet.dart';
import 'package:postervibe/presentation/widget/nodata.dart';
import 'package:postervibe/presentation/widget/shimmer.dart';
import 'package:postervibe/routes/app_routes.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  final AllCategoryController _controller = Get.put(AllCategoryController());

  @override
  void initState() {
    _controller.checkInternetConnectivity();
    // Listen for changes in connectivity status
    _controller.networkSubscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      if (result != ConnectivityResult.none) {
        _controller.noInternet.value = false;
        if (mounted) {
          _controller.getCategoryList();
        }
      } else {
        _controller.noInternet.value = true;
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(Get.context!).size;
    return Obx(
      
      () =>  Scaffold(
          appBar: appBar(
              isLeading: true,
              back: true,
              text: _controller.noInternet.value ? ' ' : 'category screen'),
          body: Obx(() {
            if (_controller.noInternet.value) {
              return NoInternetWidget();
            }
            if (_controller.isLoading.value) {
              return categorBox(size);
            }
            if (_controller.allCategory.isEmpty) {
              return const NoDataWidget(message: 'No Data Found');
            } else {
              return SingleChildScrollView(
                child: Column(
                  children: [
                   
                    GridView.builder(
                      padding: const EdgeInsets.only(left: 15,right: 15,bottom: 15,top: 10),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 8,
                        mainAxisSpacing: 8,
                        mainAxisExtent: 120,
                      ),
                      itemCount: _controller.allCategory.length,
                      shrinkWrap: true,
                      physics: const ScrollPhysics(),
                      primary: true,
                      itemBuilder: (BuildContext ctx, index) {
                        var val = _controller.allCategory[index];
                        return Column(
                          children: [
                            CircularImageWidget(
                              height: Get.width / 4.5,
                              width: Get.width / 4.5,
                              imageUrl: val.categoryImageThumbnail!,
                              onTap: () {
                                Get.toNamed(AppRoute.eventAndPost, arguments: [
                                  _controller.allCategory[index].id,
                                  _controller.allCategory[index].name,
                                ]);
                              },
                            ),
                            hSizedBox6,
                            Container(
                              alignment: Alignment.center,
                              width: 103,
                              child: Text(
                                val.name!,
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
                        );
                      },
                    ),
                  ],
                ),
              );
            }
          })),
    );
  }
}
