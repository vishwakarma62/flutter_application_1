import 'package:postervibe/presentation/dashboard/faq/faq_controller.dart';
import 'package:postervibe/presentation/widget/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:postervibe/core/app_export.dart';

class FAQScreen extends StatelessWidget {
  FAQScreen({super.key});
  final FAQController _controller = Get.put(FAQController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(
        text: "faq".tr,
        isLeading: true,
        action: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'faqandsupport'.tr,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            hSizedBox10,
            Text(
              "didntfindtheansweryouwerelookingforcontactoursupportcenter".tr,
              style: const TextStyle(
                fontSize: 15,
                color: Color(0xff8D8D8D),
                fontWeight: FontWeight.w500,
              ),
            ),
            hSizedBox30,
            support(
              title: 'gotoourwebsite'.tr,
              icon: AppImage.websitFQA,
            ),
            hSizedBox16,
            support(
              title: 'emailus'.tr,
              icon: AppImage.emailFQA,
            ),
            hSizedBox16,
            support(
              title: 'termsofservice'.tr,
              icon: AppImage.documentFQA,
            ),
            hSizedBox30,
            Container(
              padding:
                  const EdgeInsets.only(right: 10, left: 20, bottom: 10, top: 10),
              width: Get.width,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      cursorColor: AppColors.darkBlueBlack,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "${"search".tr}...",
                        hintStyle: const TextStyle(
                          color: Color(0xff4B545A),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                        color: const Color(0xFF111526),
                        borderRadius: BorderRadius.circular(10)),
                    child: const Icon(
                      Icons.search,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            hSizedBox20,
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 4,
              separatorBuilder: (context, index) => hSizedBox10,
              itemBuilder: (context, index) {
                return Obx(
                  () => Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          if (_controller.expaned.contains(index)) {
                            _controller.expaned.remove(index);
                          } else {
                            _controller.expaned.clear();
                            _controller.expaned.add(index);
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                              color: AppColors.appBluePurple,
                            ),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "howdoichangemypassword".tr,
                                  style: const TextStyle(
                                    color: Color(0xff8E8E93),
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              const Icon(
                                Icons.expand_more_rounded,
                                color: Color(0xff8E8E93),
                              )
                            ],
                          ),
                        ),
                      ),
                      if (_controller.expaned.contains(index))
                        Container(
                          margin: const EdgeInsets.only(top: 10),
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                              color: AppColors.appBluePurple,
                            ),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Text(
                            "tochangeyourpasswordproceedtomenuandselectaprofilethenretypeyourcurrentpasswordandclickconfirm"
                                .tr,
                            style: const TextStyle(
                              color: Color(0xff8E8E93),
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              height: 1.6,
                            ),
                          ),
                        )
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget support({
    required String icon,
    required String title,
  }) {
    return Row(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: SvgPicture.asset(
            icon,
            fit: BoxFit.scaleDown,
          ),
        ),
        wSizedBox14,
        Text(
          title,
          style: TextStyle(
            color: Get.isDarkMode
                ? Colors.white.withOpacity(.8)
                : const Color(0xff414141),
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
