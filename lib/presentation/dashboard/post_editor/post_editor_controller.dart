import 'package:postervibe/core/app_export.dart';
import 'package:postervibe/core/local_storage.dart';
import 'package:postervibe/core/network/network_info.dart';
import 'package:postervibe/data/model/business_by_id_model.dart';

import 'package:postervibe/data/repository/business_repo.dart';
import 'package:postervibe/di/service_locator.dart';
import 'package:postervibe/model/frame_model.dart';

import 'package:flutter/material.dart';

import 'package:screenshot/screenshot.dart';

import '../../../model/sticker_model.dart';

class PostEditorController extends GetxController
    with GetSingleTickerProviderStateMixin {
  ScreenshotController screenshotController = ScreenshotController();
  final ConnectivityManager connectivityManager = Get.find();
  RxBool noInternet = false.obs;
  final _repository = getIt.get<BusinessRepository>();
  Rx<BusinessData?> business = Rx<BusinessData?>(null);

  @override
  void onInit() async {
    business.value = BusinessData(
      address: LocalStorage.selectedBusinessAddress.value,
      businessName: LocalStorage.selectedBusinessName.value,
      id: LocalStorage.selectedBusinessId.value,
      email: LocalStorage.selectedBusinessEmail.value,
      phoneNumber1: LocalStorage.selectedBusinessPhone1.value,
      phoneNumber2: LocalStorage.selectedBusinessPhone2.value,
      logo: LocalStorage.selectedBusinessLogo.value,
      website: LocalStorage.selectedBusinessWebsite.value,
    );
    imageUrl.value = Get.arguments[0];
    connectivityManager.isConnected.listen((isConnected) {
      if (isConnected) {
        noInternet.value = false;
      } else {
        noInternet.value = true;
      }
    });

    super.onInit();
  }

  RxBool isMenuVisible = false.obs;

  void toggleMenuVisibility() {
    isMenuVisible.value = !isMenuVisible.value;
  }

  @override
  void onClose() {
    super.onClose();
    dispose();
  }

  RxBool dragChange = false.obs;
  RxString imageUrl = ''.obs;

  RxBool isLoading = false.obs;
  RxBool isDataLoading = false.obs;
  RxBool isBusinessDataLoading = false.obs;
  RxBool isStickerDataLoading = false.obs;
  RxBool isName = true.obs;
  RxBool isLogo = true.obs;
  RxBool isEmail = true.obs;
  RxBool isMobileNumber = true.obs;
  RxBool isAddress = true.obs;
  RxBool isFrame = true.obs;
  RxBool isWebsite = true.obs;
  RxString selectedBusiness = ''.obs;
  RxInt acceptedData = 10.obs;
  RxInt selectedFrame = 0.obs;
  updateframevalue(RxInt index) {
    selectedFrame.value = index.value;
  }

  RxDouble scale = 0.6.obs;
  RxDouble rotateAngle = 0.0.obs;

  RxInt selectStickerType = 0.obs;
  //RxInt selectLanguage = 0.obs;
  RxInt selectFontStyle = 0.obs;

  RxList deleteSticker = [].obs;
  RxList<Sticker> selectSticker = RxList([
    Sticker(
      url:
          'https://images.pexels.com/photos/2899097/pexels-photo-2899097.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
      xPosition: RxDouble(0.0),
      yPosition: RxDouble(0.0),
    ),
    Sticker(
      url:
          'https://images.pexels.com/photos/2899097/pexels-photo-2899097.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
      xPosition: RxDouble(100.0), // Change the x position to 100.0
      yPosition: RxDouble(0.0), // Keep the y position as 0.0
    ),
    Sticker(
      url:
          'https://images.pexels.com/photos/2899097/pexels-photo-2899097.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
      xPosition: RxDouble(0.0), // Keep the x position as 0.0
      yPosition: RxDouble(100.0), // Change the y position to 100.0
    ),
    Sticker(
      url:
          'https://images.pexels.com/photos/2899097/pexels-photo-2899097.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
      xPosition: RxDouble(100.0), // Change the x position to 100.0
      yPosition: RxDouble(100.0), // Change the y position to 100.0
    ),
    Sticker(
      url:
          'https://images.pexels.com/photos/2899097/pexels-photo-2899097.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
      xPosition: RxDouble(200.0), // Change the x position to 200.0
      yPosition: RxDouble(200.0), // Change the y position to 200.0
    )
  ]);

  RxList<Widget> movableItems = <Widget>[].obs;

  RxList<FrameModel> frameList = RxList([
    FrameModel(
      frameID: '00',
      frameUrl: 'assets/image/frame_1.png',
      position: Positions(
        address: Side(
          color: Colors.white,
          alignment: MainAxisAlignment.center,
          bottom: '0.02',
          left: '0.54',
          iconSize: '0.03',
          right: '0.15',
          fontSize: '0.02',
          maxLine: '1',
          top: '',
        ),
        companyName: Side(
          color: Colors.white,
          left: '0.03',
          top: '0.025',
          bottom: '',
          maxLine: '1',
          iconSize: '0.04',
          right: '',
          fontSize: '0.028',
        ),
        email: Side(
          color: Colors.white,
          alignment: MainAxisAlignment.center,
          bottom: '0.02',
          left: '0.22',
          right: '0.46',
          iconSize: '0.03',
          maxLine: '1',
          top: '',
          fontSize: '0.02',
        ),
        logo: Side(
          bottom: '',
          left: '-10',
          right: '',
          maxLine: '1',
          top: '10',
        ),
        mobileNumber: Side(
          color: Colors.white,
          bottom: '0.02',
          iconSize: '0.03',
          left: '0.02',
          right: '0.75',
          maxLine: '1',
          fontSize: '0.02',
          top: '',
        ),
        website: Side(
            color: Colors.white,
            alignment: MainAxisAlignment.start,
            bottom: '0.08',
            iconSize: '0.04',
            maxLine: '1',
            right: '0.5',
            left: '0.02',
            top: '',
            fontSize: '0.02'),
      ),
    ),
    FrameModel(
      frameID: '01',
      frameUrl: 'assets/image/frame_2.png',
      position: Positions(
        address: Side(
          color: Colors.white,
          alignment: MainAxisAlignment.center,
          bottom: '0.006',
          left: '0.02',
          maxLine: '1',
          right: '0.38',
          iconSize: '0.025',
          top: '',
          fontSize: '0.02',
        ),
        companyName: Side(
          color: Colors.white,
          bottom: '',
          right: '',
          top: '0.025',
          iconSize: '0.025',
          left: '0.03',
          maxLine: '1',
          fontSize: '0.028',
        ),
        email: Side(
          color: Colors.white,
          bottom: '0.006',
          left: '0.64',
          right: '0.01',
          maxLine: '1',
          iconSize: '0.03',
          top: '',
          fontSize: '0.02',
          alignment: MainAxisAlignment.start,
        ),
        logo: Side(
          bottom: '',
          left: '-10',
          right: '',
          maxLine: '1',
          top: '10',
        ),
        mobileNumber: Side(
          color: Colors.white,
          bottom: ' 0.044',
          left: '0.02',
          maxLine: '1',
          right: '0.68',
          iconSize: '0.03',
          fontSize: '0.02',
          top: '',
        ),
        website: Side(
          color: Colors.white,
          alignment: MainAxisAlignment.center,
          top: '',
          right: '0.02',
          iconSize: '0.03',
          maxLine: '1',
          bottom: ' 0.044',
          fontSize: '0.02',
          left: '0.65',
        ),
      ),
    ),
    FrameModel(
      frameID: '02',
      frameUrl: AppImage.frame_3,
      position: Positions(
        address: Side(
          color: Colors.white,
          alignment: MainAxisAlignment.start,
          bottom: '0.035',
          right: '0.35',
          left: '0.24',
          fontSize: '0.02',
          top: '',
          iconSize: '0.025',
          maxLine: '1',
        ),
        companyName: Side(
          color: Colors.white,
          bottom: '',
          right: '',
          maxLine: '1',
          top: '0.025',
          left: '0.03',
          iconSize: '0.03',
          fontSize: '0.028',
        ),
        email: Side(
          color: Colors.white,
          alignment: MainAxisAlignment.start,
          bottom: '0.004',
          left: '0.44',
          right: '0.2',
          maxLine: '1',
          iconSize: '0.025',
          fontSize: '0.02',
          top: '',
        ),
        logo: Side(
          bottom: '',
          maxLine: '1',
          left: '-10',
          right: '',
          top: '10',
        ),
        mobileNumber: Side(
          color: Colors.white,
          bottom: '0.035',
          left: '0.02',
          maxLine: '1',
          right: '0.68',
          iconSize: '0.025',
          fontSize: '0.02',
          top: '',
        ),
        website: Side(
          color: Colors.white,
          alignment: MainAxisAlignment.start,
          bottom: '0.004',
          left: '0.02',
          maxLine: '1',
          right: '0.58',
          iconSize: '0.025',
          top: '',
          fontSize: '0.02',
        ),
      ),
    ),
    FrameModel(
      frameID: '03',
      frameUrl: AppImage.frame_4,
      position: Positions(
        address: Side(
          color: Colors.white,
          alignment: MainAxisAlignment.start,
          bottom: '0.088',
          left: '0.60',
          right: '0.01',
          iconSize: '0.03',
          maxLine: '1',
          fontSize: '0.02',
          top: '',
        ),

        companyName: Side(
          color: Colors.white,
          left: '0.03',
          top: '0.025',
          bottom: '',
          iconSize: '0.03',
          right: '',
          maxLine: '1',
          fontSize: '0.028',
        ),

        //  email: {icon
        //_color: , top: , left: 0.01, font_color: , bottom: 0.085, icon: , right: 0.57}}
        email: Side(
          color: Colors.white,
          alignment: MainAxisAlignment.start,
          bottom: '0.088',
          left: '0.02',
          maxLine: '1',
          iconSize: '0.03',
          right: '0.58',
          fontSize: '0.02',
          top: '',
        ),

        // logo: {top: 10, icon_color: , left: -10, font_color: , bottom: , icon: , right: },
        logo: Side(bottom: '', left: '-10', right: '', top: '10'),

        // mobile_number: {top: , icon_color: , font_color: , left:
        // 0.01, bottom: 0.008, icon: , right: 0.65},
        mobileNumber: Side(
          color: Colors.white,
          bottom: '0.014',
          left: '0.02',
          iconSize: '0.03',
          top: '',
          maxLine: '1',
          fontSize: '0.02',
          right: '0.65',
        ),

        //  {website: {icon_color: , top: , left: , font_color: , bottom: , icon: , right: },
        website: Side(
            color: Colors.white,
            alignment: MainAxisAlignment.start,
            bottom: '0.15',
            maxLine: '1',
            right: '0.65',
            iconSize: '0.03',
            left: '0.02',
            fontSize: '0.02'),
      ),
    ),
    FrameModel(
      frameID: '04',
      frameUrl: AppImage.frame_5,
      position: Positions(
        //     address: {top: , icon_color: , font_color: , left: 0.46, bottom: 0.015, icon: , right:
        //  0.01},
        address: Side(
          color: Colors.white,
          alignment: MainAxisAlignment.start,
          top: '',
          iconSize: '0.025',
          bottom: '0.02',
          maxLine: '1',
          left: '0.46',
          fontSize: '0.02',
          right: '0.01',
        ),

//  company_name: {top: 0.025, icon_color: , left: 0.03, font_color: , bottom: , icon: , right: },
        companyName: Side(
          color: Colors.white,
          left: '0.03',
          top: '0.025',
          bottom: '',
          maxLine: '1',
          iconSize: '0.025',
          right: '',
          fontSize: '0.028',
        ),

// email: {top: , icon_color: , left: 0.02, font_color: , bottom: 0.004, icon: , right: 0.55}}
        email: Side(
          color: Colors.white,
          alignment: MainAxisAlignment.start,
          bottom: '0.01',
          left: '0.02',
          right: '0.55',
          fontSize: '0.02',
          iconSize: '0.025',
          maxLine: '1',
          top: '',
        ),

// logo: {icon_color: , top: 10, left: -10, font_color: , bottom: , icon: , right: 0},
        logo: Side(
          bottom: '',
          left: '-10',
          maxLine: '1',
          right: '0',
          top: '10',
        ),

// mobile_number: {top: , icon_color: , left: 0.02, font_color: , bottom: 0.038, icon: , right: 0.58},
        mobileNumber: Side(
          color: Colors.white,
          bottom: '0.04',
          left: '0.02',
          maxLine: '1',
          top: '',
          iconSize: '0.025',
          right: '0.58',
          fontSize: '0.02',
        ),

//  {website: {top: , icon_color: #111526, font_color: #111526, left: 0.02, bottom: 0.089, icon: , right: 0.47},
        website: Side(
          color: Colors.blue,
          alignment: MainAxisAlignment.center,
          bottom: '0.094',
          right: '0.47',
          left: '0.02',
          top: '',
          iconSize: '0.025',
          fontSize: '0.02',
          maxLine: '1',
        ),
      ),
    ),
    FrameModel(
      frameID: '05',
      frameUrl: AppImage.frame_6,
      position: Positions(
        //  address: {top: , icon_color: , font_color: , left: 0.35, bottom: 0.05, icon: , right: 0.2},
        address: Side(
            color: Colors.white,
            alignment: MainAxisAlignment.center,
            bottom: '0.009',
            left: '0.02',
            right: '0.02',
            top: '',
            maxLine: '1',
            iconSize: '0.025',
            fontSize: '0.02'),

        // company_name: {top: 0.025, icon_color: , font_color: , left: 0.03, bottom: , icon: , right: },
        companyName: Side(
          color: Colors.white,
          left: '0.03',
          top: '0.025',
          maxLine: '1',
          iconSize: '0.03',
          bottom: '',
          fontSize: '0.028',
        ),

        //  email: {top: , icon_color: , left: 0.01, font_color: , bottom: 0.003, icon: , right: 0.45}}
        email: Side(
          color: Colors.white,
          alignment: MainAxisAlignment.center,
          bottom: '0.05',
          iconSize: '0.025',
          maxLine: '1',
          left: '0.28',
          right: '0.45',
          fontSize: '0.02',
          top: '',
        ),

        // logo: {top: 10, icon_color: , font_color: , left: -10, bottom: , icon: , right: },
        logo: Side(
          bottom: '',
          maxLine: '1',
          left: '-10',
          right: '',
          top: '10',
        ),

        //  mobile_number: {top: , icon_color: , left: 0.1, font_color: , bottom: 0.05, icon: , right: 0.68},
        mobileNumber: Side(
            color: Colors.white,
            bottom: '0.05',
            left: '0.1',
            right: '0.68',
            maxLine: '1',
            top: '',
            iconSize: '0.025',
            fontSize: '0.02'),

        // {website: {icon_color: , top: , font_color: , left: 0.57, bottom: 0.003, icon: , right: 0.01}
        website: Side(
          color: Colors.white,
          alignment: MainAxisAlignment.start,
          bottom: '0.05',
          maxLine: '1',
          right: '0.18',
          iconSize: '0.025',
          left: '0.57',
          top: '',
          fontSize: '0.02',
        ),
      ),
    ),
    FrameModel(
      frameID: '06',
      frameUrl: AppImage.frame_7,
      position: Positions(
        // address: {top: , icon_color: , font_color: , left: 0.14, bottom: 0.04, icon: , right: 0.49},
        address: Side(
          color: Colors.black,
          alignment: MainAxisAlignment.center,
          bottom: '0.0',
          left: '0.02',
          iconSize: '0.025',
          right: '0.02',
          top: '',
          maxLine: '1',
          fontSize: '0.02',
        ),

        // company_name: {icon_color: , top: 0.025, font_color: , left: 0.03, bottom: , icon: , right: },
        companyName: Side(
          color: Colors.white,
          left: '0.02',
          top: '0.025',
          bottom: '',
          iconSize: '0.03',
          maxLine: '1',
          right: '',
          fontSize: '0.028',
        ),
        // email: {icon_color: , top: , left: 0.17, font_color: , bottom: 0.082, icon: , right: 0.15}}
        email: Side(
          color: Colors.white,
          alignment: MainAxisAlignment.start,
          bottom: '0.08',
          iconSize: '0.025',
          maxLine: '1',
          left: '0.2',
          right: '0.42',
          fontSize: '0.02',
          top: '',
        ),

        // logo: {icon_color: , top: 10, font_color: , left: -10, bottom: , icon: , right: }
        logo: Side(bottom: '', left: '-10', right: '', top: '10', maxLine: '1'),

        // mobile_number: {icon_color: , top: , left: 0.64, font_color: , bottom: 0.038, icon: , right: 0.15},
        mobileNumber: Side(
          color: Colors.white,
          bottom: '0.04',
          left: '0.66',
          right: '0.15',
          maxLine: '1',
          fontSize: '0.02',
          iconSize: '0.025',
          top: '0.889',
        ),

        // {website: {top: , icon_color: , left: , font_color: , bottom: , icon: , right: },
        website: Side(
            color: Colors.white,
            alignment: MainAxisAlignment.start,
            bottom: '0.04',
            left: '0.14',
            right: '0.49',
            maxLine: '1',
            iconSize: '0.025',
            fontSize: '0.02'),
      ),
    ),
    FrameModel(
      frameID: '07',
      frameUrl: AppImage.frame_8,
      position: Positions(
        // address: {icon_color: , top: , left: 0.64, font_color: , bottom: 0.042, icon: , right: 0.01},
        address: Side(
          color: Colors.white,
          alignment: MainAxisAlignment.start,
          bottom: '0.004',
          maxLine: '1',
          left: '0.02',
          right: '0.4',
          iconSize: '0.025',
          fontSize: '0.02',
          top: '',
        ),

        // company_name: {top: 0.025, icon_color: , left: 0.03, font_color: , bottom: , icon: , right: },
        companyName: Side(
          color: Colors.white,
          left: '0.03',
          top: '0.025',
          maxLine: '1',
          bottom: '',
          iconSize: '0.03',
          right: '',
          fontSize: '0.028',
        ),

        // email: {top: , icon_color: , font_color: , left: 0.01, bottom: 0.002, icon: , right: 0.45}}
        email: Side(
          color: Colors.white,
          alignment: MainAxisAlignment.start,
          bottom: '0.004',
          left: '0.64',
          maxLine: '1',
          right: '0.02',
          iconSize: '0.025',
          fontSize: '0.02',
          top: '',
        ),

        // logo: {icon_color: , top: 10, font_color: , left: -10, bottom: , icon: , right: },
        logo: Side(
          bottom: '',
          left: '-10',
          right: '',
          maxLine: '1',
          top: '10',
        ),

        // mobile_number: {icon_color: , top: , left: 0.01, font_color: , bottom: 0.042, icon: , right: 0.70},
        mobileNumber: Side(
          color: Colors.white,
          bottom: '0.044',
          left: '0.02',
          right: '0.70',
          fontSize: '0.02',
          iconSize: '0.025',
          maxLine: '1',
          top: '',
        ),

        //  {website: {top: , icon_color: , left: 0.57, font_color: , bottom: 0.002, icon: , right: 0.01},
        website: Side(
          color: Colors.white,
          alignment: MainAxisAlignment.start,
          bottom: '0.044',
          iconSize: '0.025',
          maxLine: '1',
          left: '0.64',
          right: '0.01',
          fontSize: '0.02',
          top: '',
        ),
      ),
    ),
    FrameModel(
      frameID: '08',
      frameUrl: AppImage.frame_9,
      position: Positions(
        //  address: {top: , icon_color: , left: 0.45, font_color: , bottom: 0.01, icon: , right: 0.02},
        address: Side(
          color: Colors.white,
          alignment: MainAxisAlignment.start,
          bottom: '0.077',
          left: '0.02',
          right: '0.2',
          fontSize: '0.025',
          iconSize: '0.03',
          maxLine: '1',
          top: '',
        ),

        // company_name: {top: 0.025, icon_color: , font_color: , left: 0.03, bottom: , icon: , right: },
        companyName: Side(
          color: Colors.white,
          left: '0.03',
          top: '0.025',
          iconSize: '0.03',
          maxLine: '1',
          bottom: '',
          right: '',
          fontSize: '0.028',
        ),

        //  email: {icon_color: , top: , font_color: , left: 0.02, bottom: 0.075, icon: , right: 0.20}}
        email: Side(
            color: Colors.white,
            alignment: MainAxisAlignment.start,
            bottom: '0.032',
            left: '0.45',
            maxLine: '1',
            iconSize: '0.025',
            right: '0.02',
            top: '',
            fontSize: '0.02'),

        // logo: {top: 10, icon_color: , left: -10, font_color: , bottom: , icon: , right: },
        logo: Side(
          bottom: '',
          left: '-10',
          right: '',
          maxLine: '1',
          top: '10',
        ),

        // mobile_number: {icon_color: , top: , font_color: , left: 0.02, bottom: 0.01, icon: , right: 0.72},
        mobileNumber: Side(
          color: Colors.white,
          iconSize: '0.03',
          bottom: '0.015',
          maxLine: '1',
          left: '0.02',
          right: '0.72',
          fontSize: '0.02',
          top: '',
        ),

        // : {website: {icon_color: , top: , font_color: , left: , bottom: , icon: , right: },
        website: Side(
          color: Colors.white,
          alignment: MainAxisAlignment.start,
          bottom: '0.005',
          maxLine: '1',
          right: '0.2',
          left: '0.45',
          iconSize: '0.025',
          fontSize: '0.02',
          top: '0.0',
        ),
      ),
    ),
    FrameModel(
      frameID: '09',
      frameUrl: AppImage.frame_10,
      position: Positions(
        // address: {icon_color: , top: , left: 0.34, font_color: , bottom: 0.006, icon: , right: 0.3},
        address: Side(
            color: Colors.lightBlue,
            alignment: MainAxisAlignment.start,
            bottom: '0.09',
            maxLine: '1',
            left: '0.02',
            right: '0.20',
            iconSize: '0.025',
            top: '',
            fontSize: '0.02'),

        // company_name: {icon_color: , top: 0.025, font_color: , left: 0.03, bottom: , icon: , right: },
        companyName: Side(
          color: Colors.white,
          left: '0.03',
          top: '0.025',
          iconSize: '0.03',
          bottom: '',
          right: '',
          maxLine: '1',
          fontSize: '0.028',
        ),

        // email: {icon_color: , top: , left: 0.69, font_color: , bottom: 0.018, icon: , right: 0.01}}
        email: Side(
          color: Colors.white,
          alignment: MainAxisAlignment.start,
          bottom: '0.024',
          left: '0.69',
          maxLine: '1',
          right: '0.01',
          fontSize: '0.02',
          iconSize: '0.025',
          top: '',
        ),

        // logo: {icon_color: , top: 10, left: -10, font_color: , bottom: , icon: , right: },
        logo: Side(
          bottom: '',
          left: '-10',
          right: '',
          top: '10',
        ),

        // mobile_number: {top: , icon_color: , left: 0.02, font_color: , bottom: 0.018, icon: , right: 0.72},
        mobileNumber: Side(
          color: Colors.white,
          bottom: '0.0',
          maxLine: '1',
          left: '0.02',
          right: '0.72',
          iconSize: '0.025',
          top: ' 0.923',
          fontSize: '0.022',
        ),

        // {website: {icon_color: , top: , left: 0.02, font_color: , bottom: 0.088, icon: , right: 0.20}
        website: Side(
          color: Colors.white,
          alignment: MainAxisAlignment.center,
          bottom: '0.014',
          right: '0.32',
          maxLine: '1',
          left: '0.34',
          iconSize: '0.025',
          fontSize: '0.02',
          top: '',
        ),
      ),
    ),
    FrameModel(
      frameID: '10',
      frameUrl: AppImage.frame_12,
      position: Positions(
        //  address: {top: , icon_color: , left: 0.64, font_color: , bottom: 0.003, icon: , right: 0.01},
        address: Side(
          color: Colors.white,
          alignment: MainAxisAlignment.start,
          iconSize: '0.025',
          bottom: '0.003',
          left: '0.64',
          fontSize: '0.02',
          right: '0.01',
          maxLine: '1',
          top: '',
        ),

        // company_name: {icon_color: , top: 0.025, left: 0.03, font_color: , bottom: , icon: , right: },
        companyName: Side(
          color: Colors.white,
          left: '0.03',
          top: '0.025',
          iconSize: '0.03',
          bottom: '',
          maxLine: '1',
          right: '',
          fontSize: '0.028',
        ),

        // email: {top: , icon_color: , font_color: , left: 0.01, bottom: 0.048, icon: , right: 0.58}}
        email: Side(
          color: Colors.white,
          alignment: MainAxisAlignment.start,
          bottom: '0.048',
          left: '0.02',
          right: '0.58',
          fontSize: '0.02',
          iconSize: '0.025',
          maxLine: '1',
          top: '',
        ),

        // logo: {top: 10, icon_color: , left: -10, font_color: , bottom: , icon: , right: },
        logo: Side(
          bottom: '',
          maxLine: '1',
          left: '-10',
          right: '',
          top: '10',
        ),

        // mobile_number: {icon_color: , top: , left: 0.01, font_color: , bottom: 0.006, icon: , right: 0.65},
        mobileNumber: Side(
          color: Colors.white,
          bottom: '0.015',
          left: '0.02',
          right: '0.65',
          fontSize: '0.02',
          iconSize: '0.025',
          maxLine: '1',
          top: '',
        ),

        //  {website: {icon_color: , top: , fon	t_color: , left: 0.47, bottom: 0.076, icon: , right: 0.02},
        website: Side(
          color: Colors.white,
          alignment: MainAxisAlignment.center,
          bottom: '0.015',
          left: '0.2',
          right: '0.59',
          iconSize: '0.025',
          maxLine: '1',
          fontSize: '0.02',
          top: '',
        ),
      ),
    ),
    FrameModel(
      frameID: '11',
      frameUrl: AppImage.frame_14,
      position: Positions(
        //  address: {top: , icon_color: , left: 0.64, font_color: , bottom: 0.003, icon: , right: 0.01},
        address: Side(
          color: Colors.white,
          alignment: MainAxisAlignment.center,
          iconSize: '0.025',
          bottom: '0.025',
          left: '0.15',
          fontSize: '0.02',
          right: '0.19',
          maxLine: '1',
          top: '',
        ),

        // company_name: {icon_color: , top: 0.025, left: 0.03, font_color: , bottom: , icon: , right: },
        companyName: Side(
          color: Colors.white,
          left: '0.03',
          top: '0.025',
          iconSize: '0.03',
          bottom: '',
          maxLine: '1',
          right: '',
          fontSize: '0.028',
        ),

        // email: {top: , icon_color: , font_color: , left: 0.01, bottom: 0.048, icon: , right: 0.58}}
        email: Side(
          color: Colors.white,
          alignment: MainAxisAlignment.center,
          bottom: '0.076',
          left: '0.64',
          right: '0.05',
          fontSize: '0.02',
          iconSize: '0.025',
          maxLine: '1',
          top: '',
        ),

        // logo: {top: 10, icon_color: , left: -10, font_color: , bottom: , icon: , right: },
        logo: Side(
          bottom: '',
          maxLine: '1',
          left: '-10',
          right: '',
          top: '10',
        ),

        // mobile_number: {icon_color: , top: , left: 0.01, font_color: , bottom: 0.006, icon: , right: 0.65},
        mobileNumber: Side(
          color: Colors.white,
          bottom: '0.076',
          left: '0.095',
          right: '0.65',
          fontSize: '0.02',
          iconSize: '0.025',
          maxLine: '1',
          top: '',
        ),

        //  {website: {icon_color: , top: , fon	t_color: , left: 0.47, bottom: 0.076, icon: , right: 0.02},
        website: Side(
          color: Colors.white,
          alignment: MainAxisAlignment.center,
          bottom: '0.076',
          right: '0.38',
          iconSize: '0.025',
          maxLine: '1',
          left: '0.29',
          fontSize: '0.02',
          top: '',
        ),
      ),
    ),
    FrameModel(
      frameID: '12',
      frameUrl: AppImage.frame_15,
      position: Positions(
        //  address: {top: , icon_color: , left: 0.64, font_color: , bottom: 0.003, icon: , right: 0.01},
        address: Side(
          color: Colors.white,
          alignment: MainAxisAlignment.center,
          iconSize: '0.025',
          bottom: '0.025',
          left: '0.15',
          fontSize: '0.02',
          right: '0.19',
          maxLine: '1',
          top: '',
        ),

        // company_name: {icon_color: , top: 0.025, left: 0.03, font_color: , bottom: , icon: , right: },
        companyName: Side(
          color: Colors.white,
          left: '0.03',
          top: '0.025',
          iconSize: '0.03',
          bottom: '',
          maxLine: '1',
          right: '',
          fontSize: '0.028',
        ),

        // email: {top: , icon_color: , font_color: , left: 0.01, bottom: 0.048, icon: , right: 0.58}}
        email: Side(
          color: Colors.white,
          alignment: MainAxisAlignment.center,
          bottom: '0.076',
          left: '0.64',
          right: '0.1',
          fontSize: '0.02',
          iconSize: '0.025',
          maxLine: '1',
          top: '',
        ),

        // logo: {top: 10, icon_color: , left: -10, font_color: , bottom: , icon: , right: },
        logo: Side(
          bottom: '',
          maxLine: '1',
          left: '-10',
          right: '',
          top: '10',
        ),

        // mobile_number: {icon_color: , top: , left: 0.01, font_color: , bottom: 0.006, icon: , right: 0.65},
        mobileNumber: Side(
          color: Colors.white,
          bottom: '0.076',
          left: '0.15',
          right: '0.65',
          fontSize: '0.02',
          iconSize: '0.025',
          maxLine: '1',
          top: '',
        ),

        //  {website: {icon_color: , top: , fon	t_color: , left: 0.47, bottom: 0.076, icon: , right: 0.02},
        website: Side(
          color: Colors.white,
          alignment: MainAxisAlignment.center,
          bottom: '0.076',
          right: '0.366',
          iconSize: '0.025',
          maxLine: '1',
          left: '0.35',
          fontSize: '0.02',
          top: '',
        ),
      ),
    ),
    FrameModel(
      frameID: '13',
      frameUrl: AppImage.frame_16,
      position: Positions(
        //  address: {top: , icon_color: , left: 0.64, font_color: , bottom: 0.003, icon: , right: 0.01},
        address: Side(
          color: Colors.white,
          alignment: MainAxisAlignment.start,
          iconSize: '0.03',
          bottom: '0.04',
          left: '0.35',
          fontSize: '0.025',
          right: '0.01',
          maxLine: '1',
          top: '',
        ),

        // company_name: {icon_color: , top: 0.025, left: 0.03, font_color: , bottom: , icon: , right: },
        companyName: Side(
          color: Colors.white,
          left: '0.03',
          top: '0.025',
          iconSize: '0.03',
          bottom: '',
          maxLine: '1',
          right: '',
          fontSize: '0.028',
        ),

        // email: {top: , icon_color: , font_color: , left: 0.01, bottom: 0.048, icon: , right: 0.58}}
        email: Side(
          color: Colors.white,
          alignment: MainAxisAlignment.start,
          bottom: '0.1',
          left: '0.7',
          right: '0.01',
          fontSize: '0.025',
          iconSize: '0.03',
          maxLine: '1',
          top: '',
        ),

        // logo: {top: 10, icon_color: , left: -10, font_color: , bottom: , icon: , right: },
        logo: Side(
          bottom: '',
          maxLine: '1',
          left: '-10',
          right: '',
          top: '10',
        ),

        // mobile_number: {icon_color: , top: , left: 0.01, font_color: , bottom: 0.006, icon: , right: 0.65},
        mobileNumber: Side(
          color: Colors.lightBlue,
          bottom: '0.04',
          left: '0.06',
          right: '0.65',
          fontSize: '0.02',
          iconSize: '0.025',
          maxLine: '1',
          top: '',
        ),

        //  {website: {icon_color: , top: , fon	t_color: , left: 0.47, bottom: 0.076, icon: , right: 0.02},
        website: Side(
          color: Colors.white,
          alignment: MainAxisAlignment.center,
          bottom: '0.1',
          right: '0.33',
          iconSize: '0.03',
          maxLine: '1',
          left: '0.32',
          fontSize: '0.025',
          top: '',
        ),
      ),
    ),
    FrameModel(
      frameID: '14',
      frameUrl: AppImage.frame_17,
      position: Positions(
        //  address: {top: , icon_color: , left: 0.64, font_color: , bottom: 0.003, icon: , right: 0.01},
        address: Side(
          color: Colors.white,
          alignment: MainAxisAlignment.start,
          iconSize: '0.025',
          bottom: '0.05',
          left: '0.3',
          fontSize: '0.02',
          right: '0.04',
          maxLine: '1',
          top: '',
        ),

        // company_name: {icon_color: , top: 0.025, left: 0.03, font_color: , bottom: , icon: , right: },
        companyName: Side(
          color: Colors.white,
          left: '0.03',
          top: '0.025',
          iconSize: '0.03',
          bottom: '',
          maxLine: '1',
          right: '',
          fontSize: '0.028',
        ),

        // email: {top: , icon_color: , font_color: , left: 0.01, bottom: 0.048, icon: , right: 0.58}}
        email: Side(
          color: Colors.white,
          alignment: MainAxisAlignment.start,
          bottom: '0.085',
          left: '0.7',
          right: '0.04',
          fontSize: '0.02',
          iconSize: '0.025',
          maxLine: '1',
          top: '',
        ),

        // logo: {top: 10, icon_color: , left: -10, font_color: , bottom: , icon: , right: },
        logo: Side(
          bottom: '',
          maxLine: '1',
          left: '-10',
          right: '',
          top: '10',
        ),

        // mobile_number: {icon_color: , top: , left: 0.01, font_color: , bottom: 0.006, icon: , right: 0.65},
        mobileNumber: Side(
          color: Colors.white,
          bottom: '0.01',
          left: '0.085',
          right: '0.75',
          fontSize: '0.02',
          iconSize: '0.025',
          maxLine: '1',
          top: '0.84',
        ),

        //  {website: {icon_color: , top: , fon	t_color: , left: 0.47, bottom: 0.076, icon: , right: 0.02},
        website: Side(
          color: Colors.white,
          alignment: MainAxisAlignment.center,
          bottom: '0.085',
          right: '0.33',
          iconSize: '0.025',
          maxLine: '1',
          left: '0.3',
          fontSize: '0.02',
          top: '',
        ),
      ),
    ),
    FrameModel(
      frameID: '15',
      frameUrl: AppImage.frame_18,
      position: Positions(
        //  address: {top: , icon_color: , left: 0.64, font_color: , bottom: 0.003, icon: , right: 0.01},
        address: Side(
          color: Colors.black,
          alignment: MainAxisAlignment.start,
          iconSize: '0.025',
          bottom: '0.009',
          left: '0.4',
          fontSize: '0.02',
          right: '0.2',
          maxLine: '1',
          top: '',
        ),

        // company_name: {icon_color: , top: 0.025, left: 0.03, font_color: , bottom: , icon: , right: },
        companyName: Side(
          color: Colors.white,
          left: '0.03',
          top: '0.025',
          iconSize: '0.03',
          bottom: '',
          maxLine: '1',
          right: '',
          fontSize: '0.028',
        ),

        // email: {top: , icon_color: , font_color: , left: 0.01, bottom: 0.048, icon: , right: 0.58}}
        email: Side(
          color: Colors.black,
          alignment: MainAxisAlignment.start,
          bottom: '0.04',
          left: '0.74',
          right: '0.05',
          fontSize: '0.02',
          iconSize: '0.025',
          maxLine: '1',
          top: '',
        ),

        // logo: {top: 10, icon_color: , left: -10, font_color: , bottom: , icon: , right: },
        logo: Side(
          bottom: '',
          maxLine: '1',
          left: '-10',
          right: '',
          top: '10',
        ),

        // mobile_number: {icon_color: , top: , left: 0.01, font_color: , bottom: 0.006, icon: , right: 0.65},
        mobileNumber: Side(
          color: Colors.white,
          bottom: '0.01',
          left: '0.14',
          right: '0.65',
          fontSize: '0.02',
          iconSize: '0.025',
          maxLine: '1',
          top: '0.92',
        ),

        //  {website: {icon_color: , top: , fon	t_color: , left: 0.47, bottom: 0.076, icon: , right: 0.02},
        website: Side(
          color: Colors.black,
          alignment: MainAxisAlignment.start,
          bottom: '0.04',
          right: '0.28',
          iconSize: '0.025',
          maxLine: '1',
          left: '0.4',
          fontSize: '0.02',
          top: '',
        ),
      ),
    ),
  ]);

  RxList<StickerModel> stickerList = RxList([
    StickerModel(
        id: '01',
        stickerUrl: [
          'https://images.pexels.com/photos/2899097/pexels-photo-2899097.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
          'https://images.pexels.com/photos/2899097/pexels-photo-2899097.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
          'https://images.pexels.com/photos/2899097/pexels-photo-2899097.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
          'https://images.pexels.com/photos/2899097/pexels-photo-2899097.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500'
        ],
        title: 'this is tittle one'),
    StickerModel(
        id: '02',
        stickerUrl: [
          'https://images.pexels.com/photos/2899097/pexels-photo-2899097.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
          'https://images.pexels.com/photos/2899097/pexels-photo-2899097.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
          'https://images.pexels.com/photos/2899097/pexels-photo-2899097.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
          'https://images.pexels.com/photos/2899097/pexels-photo-2899097.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500'
        ],
        title: 'this is tittle two'),
    StickerModel(
        id: '03',
        stickerUrl: [
          'https://images.pexels.com/photos/2899097/pexels-photo-2899097.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
          'https://images.pexels.com/photos/2899097/pexels-photo-2899097.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
          'https://images.pexels.com/photos/2899097/pexels-photo-2899097.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
          'https://images.pexels.com/photos/2899097/pexels-photo-2899097.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500'
        ],
        title: 'this is tittle three'),
    StickerModel(
        id: '04',
        stickerUrl: [
          'https://images.pexels.com/photos/2899097/pexels-photo-2899097.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
          'https://images.pexels.com/photos/2899097/pexels-photo-2899097.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
          'https://images.pexels.com/photos/2899097/pexels-photo-2899097.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
          'https://images.pexels.com/photos/2899097/pexels-photo-2899097.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500'
        ],
        title: 'this is tittle four'),
    StickerModel(
        id: '05',
        stickerUrl: [
          'https://images.pexels.com/photos/2899097/pexels-photo-2899097.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
          'https://images.pexels.com/photos/2899097/pexels-photo-2899097.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
          'https://images.pexels.com/photos/2899097/pexels-photo-2899097.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
          'https://images.pexels.com/photos/2899097/pexels-photo-2899097.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500'
        ],
        title: 'this is tittle four'),
  ]);
  RxList fontFamilyList = [
    "serif",
    "monospace",
    "cursive",
    "fantasy",
    "Oswald",
    "Gloock",
    "Pacifico",
    "ShantellSans",
    "TiltNeon",
    "TiltWarp",
    "Raleway",
    'PT Serif',
    "Noto Sans",
    'Jacquard'
  ].obs;

  RxDouble zoom = 0.4.obs;
  Rx<Offset> offset = Offset(Get.width - 105, -10).obs;
  Rx<Offset> startingFocalPoint = Offset.zero.obs;
  Rx<Offset> previousOffset = Offset.zero.obs;
  RxDouble previousZoom = 1.0.obs;

  Rx<Color> currentColor = const Color(0xffffffff).obs;
  Rx<Color?> pickerColor = Rx<Color?>(null);

  RxList<Color> defaultColors = [
    Colors.red,
    Colors.pink,
    Colors.purple,
    Colors.deepPurple,
    Colors.indigo,
    Colors.blue,
    Colors.white,
    Colors.cyan,
    Colors.teal,
    Colors.green,
    Colors.lightGreen,
    Colors.lime,
    Colors.yellow,
    Colors.amber,
    Colors.orange,
    Colors.deepOrange,
    Colors.brown,
    Colors.grey,
    Colors.blueGrey,
    Colors.black,
  ].obs;
}

class Sticker {
  String? url;
  RxDouble? xPosition;
  RxDouble? yPosition;

  Sticker({
    this.url,
    this.xPosition,
    this.yPosition,
  });
}
