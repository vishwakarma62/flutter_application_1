import 'package:flutter/material.dart';

enum DeviceType {
  smallPhone,
  averagePhone,
  largePhone,
  tablet,
}

class Dsize {
  static Size? size;

  static double? height;
  static double? width;

  static DeviceType? dtype;

  static void init(Size size) {
    if (Dsize.size == null) {
      /// * set Device size
      Dsize.size = size;

      height = size.height;
      width = size.width;

      /// * set Device type
      if (width! > 550) {
        dtype = DeviceType.tablet;
      } else if (height! < 670)
        dtype = DeviceType.smallPhone;
      else
        dtype = DeviceType.averagePhone;
    }
  }

  static double getSize(double defaultSize, {double diffSize = 2.0}) {
    if (dtype == DeviceType.smallPhone) {
      return defaultSize - diffSize;
    } else {
      return defaultSize;
    }
  }
}
