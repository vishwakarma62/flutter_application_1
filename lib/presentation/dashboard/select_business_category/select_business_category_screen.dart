import 'package:postervibe/core/app_export.dart';
import 'package:postervibe/presentation/dashboard/select_business_category/select_business_category_controller.dart';
import 'package:postervibe/presentation/widget/app_bar.dart';
import 'package:postervibe/presentation/widget/app_button.dart';
import 'package:postervibe/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SelectBusinessCategoryScreen extends StatelessWidget {
  SelectBusinessCategoryScreen({super.key});

  final SelectBusinessCategoryController _controller =
      Get.put(SelectBusinessCategoryController());
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: appBar(text: "Select Business Category", isLeading: true),
        body: _controller.businessCategoryList.isEmpty
            ? const Center(child: Text("No found business category"))
            : Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Column(
                    children: [
                      hSizedBox10,
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 16),
                        padding: const EdgeInsets.all(6),
                        width: Get.width,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Row(
                          children: [
                            wSizedBox10,
                            Expanded(
                              child: TextField(
                                decoration: InputDecoration(
                                  hintText: '${"search".tr}..',
                                  hintStyle: const TextStyle(
                                    color: Color(0xff4B545A),
                                  ),
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                            Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                  color: const Color(0xFF111526),
                                  borderRadius: BorderRadius.circular(10)),
                              child: SvgPicture.asset(
                                AppImage.search,
                                color: Colors.white,
                                fit: BoxFit.scaleDown,
                              ),
                            ),
                          ],
                        ),
                      ),
                      hSizedBox10,
                      Expanded(
                        child: ListView.separated(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: _controller.businessCategoryList.length,
                          separatorBuilder: (context, index) {
                            return Container(
                              margin: const EdgeInsets.symmetric(horizontal: 10),
                              height: 1,
                              width: Get.width,
                              color: Colors.black.withOpacity(.5),
                            );
                          },
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                if (_controller.selectBusinessList
                                    .contains(index)) {
                                  _controller.selectBusinessList.remove(index);
                                } else {
                                  _controller.selectBusinessList.clear();
                                  _controller.selectBusinessList.add(index);
                                }
                              },
                              child: Container(
                                color: AppColors.backgroundColor,
                                child: Row(
                                  children: [
                                    Text(
                                      _controller
                                          .businessCategoryList[index].name!,
                                      style: TextStyle(
                                        color: _controller.selectBusinessList
                                                .contains(index)
                                            ? AppColors.darkBlueBlack
                                            : Colors.black,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      )
                    ],
                  ),
                  if (_controller.selectBusinessList.isNotEmpty)
                    Container(
                      margin: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: AppColors.darkBlueBlack,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: AppButton(
                        text: "Continue",
                        onPressed: () {
                          Get.toNamed(
                            AppRoute.addCompany,
                            arguments: [
                              _controller
                                  .businessCategoryList[
                                      _controller.selectBusinessList.first]
                                  .id,
                              false,
                            ],
                          );
                        },
                      ),
                    )
                ],
              ),
      ),
    );
  }
}
