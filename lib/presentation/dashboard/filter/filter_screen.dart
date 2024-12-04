import 'package:postervibe/presentation/widget/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:postervibe/core/app_export.dart';
import 'package:postervibe/presentation/dashboard/filter/filter_controller.dart';

class FiltersScreen extends StatelessWidget {
  FiltersScreen({super.key});
  final FilterControler _controller = Get.put(FilterControler());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(
        text: "filters".tr,
        action: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            heading("posttype".tr),
            hSizedBox20,
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: List.generate(
                _controller.selectKeywords.length,
                (index) {
                  return Container(
                    alignment: Alignment.center,
                    width: Get.width / 3 - 20,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: AppColors.appBluePurple),
                    ),
                    child: Text(
                      _controller.selectKeywords[index]['title'],
                      style: const TextStyle(fontSize: 16),
                    ),
                  );
                },
              ),
            ),
            hSizedBox20,
            heading("categorytype".tr),
            hSizedBox20,
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: List.generate(
                _controller.catagorytype.length,
                (index) {
                  return Container(
                    alignment: Alignment.center,
                    width: Get.width / 3 - 20,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: AppColors.appBluePurple),
                    ),
                    child: Text(
                      _controller.catagorytype[index]['title'],
                      style: const TextStyle(fontSize: 16),
                    ),
                  );
                },
              ),
            ),
            hSizedBox20,
            heading("licensetype".tr),
            hSizedBox20,
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: List.generate(
                _controller.licenseType.length,
                (index) {
                  return Container(
                    alignment: Alignment.center,
                    width: Get.width / 3 - 20,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: AppColors.appBluePurple),
                    ),
                    child: Text(
                      _controller.licenseType[index],
                      style: const TextStyle(fontSize: 16),
                    ),
                  );
                },
              ),
            ),
            hSizedBox20,
            heading("colortype"),
            hSizedBox20,
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: List.generate(
                _controller.colorList.length,
                (index) {
                  return Container(
                    width: 40,
                    height: 35,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: AppColors.appBluePurple),
                      color: Color(_controller.colorList[index]),
                    ),
                  );
                },
              ),
            ),
            hSizedBox20,
            heading("orientationtype"),
            hSizedBox20,
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: List.generate(
                _controller.orientationType.length,
                (index) {
                  return Container(
                    alignment: Alignment.center,
                    width: Get.width / 3 - 20,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: AppColors.appBluePurple),
                    ),
                    child: Text(
                      _controller.orientationType[index]['title'],
                      style: const TextStyle(fontSize: 16),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Text heading(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}
