import 'package:postervibe/presentation/widget/app_bar.dart';
import 'package:postervibe/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:postervibe/core/app_export.dart';
import 'package:postervibe/presentation/dashboard/premium/premium_controller.dart';

// ignore: must_be_immutable
class PremiumScreen extends StatelessWidget {
  PremiumScreen({super.key});
  final PremiumController _controller = Get.put(PremiumController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(
        text: "premium".tr,
        action: true,
        isLeading: true
      ),
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 30),
        child: Column(
          children: [
            Center(
                child: Text(
              'premiumaccess'.tr,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 20,
              ),
            )),
            hBox(20),
            ...List.generate(
              _controller.accesslist.length,
              (index) {
                return Row(
                  children: [
                    Obx(
                      () => Checkbox(
                        hoverColor: Colors.white,
                        autofocus: false,
                        activeColor: null,
                        focusColor: Colors.white,
                        side: BorderSide(
                            color: Get.isDarkMode ? Colors.white : Colors.black,
                            width: 1),
                        value: _controller.selectPremiumAccess.contains(index),
                        checkColor: Colors.black,
                        onChanged: (value) {
                          if (_controller.selectPremiumAccess.contains(index)) {
                            _controller.selectPremiumAccess.remove(index);
                          } else {
                            _controller.selectPremiumAccess.add(index);
                          }
                        },
                      ),
                    ),
                    Text(
                      _controller.accesslist[index]['title'],
                    )
                  ],
                );
              },
            ),
            hSizedBox20,
            ListView.separated(
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              padding: EdgeInsets.zero,
              itemCount: _controller.durationlist.length,
              separatorBuilder: (context, index) => hSizedBox20,
              itemBuilder: (context, index) {
                return Obx(
                  () => GestureDetector(
                    onTap: () {
                      _controller.selectPremium.value = index;

                      Get.toNamed(AppRoute.payment);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                        color: _controller.selectPremium.value == index
                            ? const Color(0xFF111526)
                            : Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: AppColors.appBluePurple),
                      ),
                      height: 75,
                      width: Get.width,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  _controller.durationlist[index]['duration'],
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                    color:
                                        _controller.selectPremium.value == index
                                            ? Colors.white
                                            : Colors.black,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Text(
                                  _controller.durationlist[index]['price'],
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    color:
                                        _controller.selectPremium.value == index
                                            ? Colors.white
                                            : Colors.black.withOpacity(.6),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          if (index == 0) hSizedBox10,
                          if (index == 0)
                            Text(
                              "(${"3daysfreetrialthenmonthisnotcancelled".tr})",
                              style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w400,
                                  color:
                                      _controller.selectPremium.value == index
                                          ? Colors.white
                                          : Colors.black),
                            )
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
            hSizedBox30,
            Text(
              "loremipsumissimplydummytextoftheprintingandtypesettingindustryloremipsumhasbeentheindustrysstandarddummytexteversincethe1500swhenanunknownprintertookagalleyoftypeandscrambledittomakeatypespecimenbook"
                  .tr,
              style: TextStyle(
                fontSize: 14,
                color: Get.isDarkMode
                    ? Colors.white.withOpacity(.8)
                    : Colors.black.withOpacity(.6),
                height: 1.6,
              ),
            )
          ],
        ),
      ),
    );
  }
}
