import 'package:postervibe/presentation/widget/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:postervibe/core/app_export.dart';
import 'package:postervibe/presentation/dashboard/notification/notification_controller.dart';

class NotificationScreen extends StatelessWidget {
  NotificationScreen({super.key});
  final NotificationsController _controller =
      Get.put(NotificationsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(text: "notifications".tr,isLeading: true),
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
                  SvgPicture.asset(
                    AppImage.search,
                    color: const Color(0xffB8BABF),
                  ),
                  wSizedBox10,
                  Expanded(
                    child: TextFormField(
                      cursorColor: AppColors.darkBlueBlack,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "${"searchnotifications".tr}...",
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
                        color: AppColors.darkBlueBlack,
                        borderRadius: BorderRadius.circular(10)),
                    child: SvgPicture.asset(
                      AppImage.filterlanguage,
                      fit: BoxFit.scaleDown,
                    ),
                  ),
                ],
              ),
            ),
            hSizedBox12,
            Text(
              'Today',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Get.isDarkMode
                    ? Colors.white.withOpacity(.8)
                    : const Color(0xff4B545A),
              ),
            ),
            hSizedBox10,
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: EdgeInsets.zero,
              itemCount: _controller.categoryImage.length,
              separatorBuilder: (context, index) => hSizedBox14,
              itemBuilder: (context, index) {
                return Container(
                  padding: const EdgeInsets.all(14),
                  width: Get.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                            color:  AppColors.screenlightBlue,
                            borderRadius: BorderRadius.circular(10)),
                        child: SvgPicture.asset(
                          _controller.categoryImage[index]['image'],
                          fit: BoxFit.scaleDown,
                        ),
                      ),
                      wSizedBox14,
                      Expanded(
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    _controller.categoryImage[index]['title'],
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                  hSizedBox8,
                                  Text(
                                    _controller.categoryImage[index]
                                        ['subTitle'],
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12,
                                      color: Color(0xff3E4958),
                                    ),
                                  ),
                                  hSizedBox8,
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.watch_later_outlined,
                                        color: Color(0xff8B8989),
                                        size: 15,
                                      ),
                                      wSizedBox4,
                                      Text(
                                        _controller.categoryImage[index]
                                            ['duration'],
                                        style: const TextStyle(
                                          color: Color(0xff8B8989),
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            wSizedBox16,
                            const Icon(
                              Icons.chevron_right_rounded,
                              color: Color(0xffBCBFC3),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
