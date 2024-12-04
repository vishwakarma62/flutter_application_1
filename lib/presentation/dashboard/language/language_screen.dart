import 'package:postervibe/core/local_storage.dart';
import 'package:postervibe/presentation/widget/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:postervibe/core/utils/app_image.dart';
import 'package:postervibe/core/utils/constant_sizebox.dart';
import '../../../core/utils/app_color.dart';
import 'language_controler.dart';

class LanguageScreen extends StatelessWidget {
  LanguageScreen({super.key});
  final LanguageController _controller = Get.put(LanguageController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(
        text: "language".tr,
        action: true,
      ),
      body: WillPopScope(
        onWillPop: () async {
          await _controller.catagoryImage[_controller.selectIndex.value]
              ['title'];
          return true;
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
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
                          hintText: "${"searchlanguages".tr}...",
                          hintStyle: const TextStyle(
                            color: Color(0xff4B545A),
                            fontSize: 13,
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
              hSizedBox20,
              GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 3 / 2,
                  crossAxisSpacing: 14,
                  mainAxisSpacing: 14,
                ),
                shrinkWrap: true,
                primary: true,
                itemCount: _controller.catagoryImage.length,
                itemBuilder: (context, index) => Obx(
                  () => GestureDetector(
                    onTap: () {
                      _controller.selectIndex.value = index;

                      Get.back(
                          result: _controller.catagoryImage[index]['title']);

                      Get.updateLocale(
                          _controller.catagoryImage[index]['locale']);

                      LocalStorage.selectLanguage(
                          _controller.catagoryImage[index]['lang']);
                    },
                    child: Container(
                        decoration: BoxDecoration(
                          color: _controller.selectIndex.value == index
                              ? AppColors.darkBlueBlack
                              : Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image(
                              image: AssetImage(
                                _controller.catagoryImage[index]['image'],
                              ),
                            ),
                            hSizedBox6,
                            Text(
                              _controller.catagoryImage[index]['title'],
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: _controller.selectIndex.value == index
                                    ? Colors.white
                                    : Colors.black,
                              ),
                            )
                          ],
                        )),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
