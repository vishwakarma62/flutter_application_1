import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:postervibe/core/utils/loader.dart';
import 'package:postervibe/presentation/dashboard/add_business/business_detail_controller.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:postervibe/core/app_export.dart';
import 'package:postervibe/presentation/widget/app_bar.dart';
import 'package:postervibe/presentation/widget/no_internet.dart';
import 'package:postervibe/routes/app_routes.dart';
import 'package:postervibe/presentation/widget/app_button.dart';
import 'package:postervibe/presentation/widget/app_text_field.dart';

class BusinessDetail extends StatefulWidget {
  const BusinessDetail({super.key});

  @override
  State<BusinessDetail> createState() => _BusinessDetailState();
}

class _BusinessDetailState extends State<BusinessDetail> {
  final _controller = Get.put(BusinessDetailController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);

          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: Scaffold(
            appBar: appBar(
              text: _controller.connectivityManager.isConnected.value == false
                  ? ' '
                  : 'Add Business Details'.tr,
              isLeading: true,
              back: true,
              widget: InkWell(
                onTap: () {
                  Get.offAllNamed(AppRoute.bottom, arguments: 0);
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    _controller.isSkip.value ? 'Skip' : '',
                    style: TextStyle(
                      fontSize: 20,
                      color: Color(int.parse('0xff5D54B3')),
                    ),
                  ),
                ),
              ),
            ),
            body: Obx(() {
              if (_controller.connectivityManager.isConnected.value == true) {
                return Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        physics: const ClampingScrollPhysics(),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  _controller.picImage();
                                },
                                child: Obx(
                                  () => ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: DottedBorder(
                                      radius: const Radius.circular(12),
                                      borderType: BorderType.RRect,
                                      child: Container(
                                        height: 150,
                                        color: const Color(0xFFF2F2F2),
                                        child: _controller
                                                .logoUrl.value.isNotEmpty
                                            ? Container(
                                                height: 150,
                                                decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                    fit: BoxFit.contain,
                                                    image: NetworkImage(
                                                        _controller
                                                            .logoUrl.value),
                                                  ),
                                                ),
                                              )
                                            : _controller.profileImage.value
                                                    .path.isNotEmpty
                                                ? Container(
                                                    height: 150,
                                                    decoration: BoxDecoration(
                                                      image: DecorationImage(
                                                        fit: BoxFit.contain,
                                                        image: FileImage(
                                                          _controller
                                                              .profileImage
                                                              .value,
                                                        ) as ImageProvider,
                                                      ),
                                                    ),
                                                  )
                                                : const Center(
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        SizedBox(
                                                          width: 20,
                                                          height: 20,
                                                          child: Icon(
                                                            Icons.cloud_upload,
                                                            size: 20,
                                                          ),
                                                        ),
                                                        SizedBox(height: 8),
                                                        Text(
                                                          'Upload Image',
                                                          style: TextStyle(
                                                            fontSize: 18,
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              hSizedBox10,
                              Obx(
                                () => AppTextField(
                                  onTap: () {
                                    showCategoryDialog();
                                  },
                                  readonly: true,
                                  controller: _controller
                                      .selectedCategoryController.value,
                                  hintText: '${'Business Category'.tr}*',
                                  svg: false,
                                  prefixIcon: AppImage.selectBusiness,
                                  suffixIcon: Icon(
                                    Icons.arrow_drop_down,
                                    color: AppColors.darkBlueBlack,
                                  ), // Add dropdown icon
                                  onChange: (val) {
                                    _controller.businessNameError.value = '';
                                  },
                                  errorMessage:
                                      _controller.selectedCategoryError,
                                ),
                              ),
                              hSizedBox10,
                              AppTextField(
                                controller: _controller.bNameController.value,
                                hintText: '${'Business Name'.tr}*',
                                svg: false,
                                prefixIcon: AppImage.businessName,
                                onChange: (val) {
                                  _controller.businessNameError.value = '';
                                },
                                errorMessage:
                                    _controller.businessNameError.value.obs,
                              ),
                              hSizedBox10,
                              AppTextField(
                                onChange: (p0) {
                                  _controller.mobileNumberError.value = '';
                                },
                                controller:
                                    _controller.bphoneNumberController.value,
                                icon: false,
                                hintText: '${"Phone Number".tr}*',
                                prefixIcon: _controller.generateCode(
                                  _controller.countryCode.value?['dial_code']
                                          .toString() ??
                                      "+91",
                                ),
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                  LengthLimitingTextInputFormatter(10),
                                ],
                                errorMessage:
                                    _controller.mobileNumberError.value.obs,
                              ),
                              hSizedBox10,
                              AppTextField(
                                controller: _controller
                                    .balternativePhoneNumberController.value,
                                icon: false,
                                hintText: "Alternative Phone Number".tr,
                                prefixIcon: _controller.generateCode(
                                  _controller.countryCode.value?['dial_code']
                                          .toString() ??
                                      "+91",
                                ),
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                  LengthLimitingTextInputFormatter(10),
                                ],
                                errorMessage:
                                    _controller.alternativePhoneError.value.obs,
                                onChange: (val) {
                                  _controller.alternativePhoneError.value = '';
                                },
                              ),
                              hSizedBox10,
                              AppTextField(
                                controller: _controller.bemailController.value,
                                hintText: "${'Email Address'.tr}*",
                                prefixIcon: AppImage.email,
                                errorMessage: _controller.bEmailError.value.obs,
                                onChange: (val) {
                                  _controller.bEmailError.value = "";
                                },
                              ),
                              hSizedBox10,
                              AppTextField(
                                controller:
                                    _controller.bwebsiteController.value,
                                hintText: '${'Website'.tr}*',
                                prefixIcon: AppImage.userName,
                                onChange: (val) {
                                  _controller.websiteError.value = '';
                                },
                                errorMessage:
                                    _controller.websiteError.value.obs,
                              ),
                              hSizedBox10,
                              AppTextField(
                                controller:
                                    _controller.baddressController.value,
                                lebel: false,
                                maxLines: 3,
                                hintText: '${'Address'.tr}*',
                                onChange: (val) {
                                  _controller.addressError.value = '';
                                },
                                errorMessage:
                                    _controller.addressError.value.obs,
                              ),
                              hSizedBox10,
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 16, right: 16, bottom: 16),
                      child: AppButton(
                        text: _controller.isEdit ? "Update" : "ADD",
                        loader: _controller.isLoading.value,
                        onPressed: () {
                          _controller.addAndUpdateBusiness();
                        },
                      ),
                    ),
                  ],
                );
              } else {
                return NoInternetWidget();
              }
            })),
      ),
    );
  }

  void showCategoryDialog() async {
    DialogueHelper.showLoading(context);
    await _controller.getMyBusinessCategoryNameList();
    DialogueHelper.hideLoading();

    // Define the provided color and its opposite color
    const providedColor = Color(0xFF5D54B3);
    final oppositeColor = Colors.grey[400]!;

    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Container(
          width: Get.width * 0.8,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 2,
                blurRadius: 10,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Select a Category',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueGrey[900],
                ),
              ),
              const SizedBox(height: 20),
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                constraints: BoxConstraints(maxHeight: Get.height * 0.5),
                child: ListView.separated(
                  shrinkWrap: true,
                  itemCount: _controller.businessCategoryList.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final category = _controller.businessCategoryList[index];
                    final isSelected =
                        _controller.selectedCategoryId == category['id'];
                    return InkWell(
                      onTap: () {
                        _controller.selectedCategoryController.value.text =
                            category['name'];
                        _controller.selectedCategoryId = category['id'];
                        _controller.selectedCategoryError.value = '';
                        Get.back();
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 12, horizontal: 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: isSelected
                              ? providedColor.withOpacity(0.1)
                              : Colors.transparent,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                category['name'],
                                style: TextStyle(
                                  fontSize: 18,
                                  color:
                                      isSelected ? providedColor : Colors.black,
                                  fontWeight: isSelected
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                                ),
                              ),
                            ),
                            if (!isSelected)
                              Icon(
                                Icons.circle,
                                color: oppositeColor,
                              ),
                            if (isSelected)
                              const Icon(
                                Icons.check_circle,
                                color: providedColor,
                              ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
