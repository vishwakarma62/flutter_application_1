import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class AppShimmer extends StatelessWidget {
  final double height;
  final double width;
  final Color? color;
  final double? radius;
  final double? hMargin;

  const AppShimmer(
      {super.key,
      required this.height,
      required this.width,
      this.color,
      this.radius,
      this.hMargin});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.withOpacity(0.1),
      highlightColor: color ?? Colors.white,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(radius ?? 0),
            color: Colors.grey),
        margin: EdgeInsets.symmetric(vertical: 6, horizontal: hMargin ?? 0),
        height: height,
        width: width,
      ),
    );
  }
}

class AppShimmerRounded extends StatelessWidget {
  final double height;
  final double width;
  final Color? color;
  final double? hMargin;

  const AppShimmerRounded(
      {super.key,
      required this.height,
      required this.width,
      this.color,
      this.hMargin});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.withOpacity(0.1),
      highlightColor: color ?? Colors.white,
      child: Container(
        decoration:
            const BoxDecoration(shape: BoxShape.circle, color: Colors.grey),
        margin: EdgeInsets.symmetric(vertical: 6, horizontal: hMargin ?? 0),
        height: height,
        width: width,
      ),
    );
  }
}

Widget mainImageShimmer(Size size, bool value) {
  return Shimmer.fromColors(
      highlightColor: Colors.grey[100]!,
      baseColor: Colors.grey[400]!,
      child: Container(
          height: size.height / 2,
          width: size.width,
          decoration: BoxDecoration(
              borderRadius: value == true ? BorderRadius.circular(7) : null,
              color: Colors.grey),
          child: const Text(" ")));
}

Widget homeScreenShimmer(Size size) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20),
    child: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppShimmer(
            height: Get.height / 4.5,
            width: Get.width,
            radius: 10,
            color: Colors.grey[300],
          ),
          AppShimmer(
            height: 10,
            width: Get.width / 3,
            radius: 1,
            color: Colors.grey[300],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              postBox(),
              postBox(),
              postBox(),
            ],
          ),
          AppShimmer(
            height: 10,
            width: Get.width / 3,
            radius: 1,
            color: Colors.grey[300],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              postCircle(),
              postCircle(),
              postCircle(),
            ],
          ),
          AppShimmer(
            height: 10,
            width: Get.width / 3,
            radius: 1,
            color: Colors.grey[300],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              postBox(),
              postBox(),
              postBox(),
            ],
          ),
          AppShimmer(
            height: 10,
            width: Get.width / 3,
            radius: 1,
            color: Colors.grey[300],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              postBox(),
              postBox(),
              postBox(),
            ],
          ),
          AppShimmer(
            height: 10,
            width: Get.width / 3,
            radius: 1,
            color: Colors.grey[300],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              postBox(),
              postBox(),
              postBox(),
            ],
          )
        ],
      ),
    ),
  );
}

Widget postShimmer(Size size) {
  return Padding(
    padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20, top: 10),
    child: SingleChildScrollView(
      physics: NeverScrollableScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppShimmer(
            height: Get.width - 20,
            width: Get.width - 20,
            radius: 10,
            color: Colors.grey[300],
          ),
          AppShimmer(
            height: 10,
            width: Get.width / 3,
            radius: 1,
            color: Colors.grey[300],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              postBox(),
              postBox(),
              postBox(),
            ],
          ),
          AppShimmer(
            height: 10,
            width: Get.width / 3,
            radius: 1,
            color: Colors.grey[300],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              postBox(),
              postBox(),
              postBox(),
            ],
          ),
        ],
      ),
    ),
  );
}

Widget categorBox(Size size) {
  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: SingleChildScrollView(
      physics: NeverScrollableScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              postCircle(),
              postCircle(),
              postCircle(),
            ],
          ),
          AppShimmer(
            height: 10,
            width: Get.width / 3,
            radius: 1,
            color: Colors.grey[300],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              postCircle(),
              postCircle(),
              postCircle(),
            ],
          ),
          AppShimmer(
            height: 10,
            width: Get.width / 3,
            radius: 1,
            color: Colors.grey[300],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              postCircle(),
              postCircle(),
              postCircle(),
            ],
          ),
          AppShimmer(
            height: 10,
            width: Get.width / 3,
            radius: 1,
            color: Colors.grey[300],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              postCircle(),
              postCircle(),
              postCircle(),
            ],
          ),
        ],
      ),
    ),
  );
}

Widget gridBox(Size size) {
  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: SingleChildScrollView(
      physics: NeverScrollableScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              postBox(),
              postBox(),
              postBox(),
            ],
          ),
          AppShimmer(
            height: 10,
            width: Get.width / 3,
            radius: 1,
            color: Colors.grey[300],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              postBox(),
              postBox(),
              postBox(),
            ],
          ),
          AppShimmer(
            height: 10,
            width: Get.width / 3,
            radius: 1,
            color: Colors.grey[300],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              postBox(),
              postBox(),
              postBox(),
            ],
          ),
          AppShimmer(
            height: 10,
            width: Get.width / 3,
            radius: 1,
            color: Colors.grey[300],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              postBox(),
              postBox(),
              postBox(),
            ],
          ),
        ],
      ),
    ),
  );
}

Widget primaryShimmer(Size size) {
  return Padding(
    padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20, top: 10),
    child: SingleChildScrollView(
      physics: NeverScrollableScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppShimmer(
            height: 10,
            width: Get.width / 3,
            radius: 1,
            color: Colors.grey[300],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              postBox(),
              postBox(),
              postBox(),
            ],
          ),
          AppShimmer(
            height: 10,
            width: Get.width / 3,
            radius: 1,
            color: Colors.grey[300],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              postBox(),
              postBox(),
              postBox(),
            ],
          ),
          AppShimmer(
            height: 10,
            width: Get.width / 3,
            radius: 1,
            color: Colors.grey[300],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              postBox(),
              postBox(),
              postBox(),
            ],
          )
        ],
      ),
    ),
  );
}

AppShimmer postBox() {
  return AppShimmer(
    height: Get.width / 3.5,
    width: Get.width / 3.5,
    radius: 10,
    color: Colors.grey[300],
  );
}

AppShimmerRounded postCircle() {
  return AppShimmerRounded(
    height: Get.width / 4,
    width: Get.width / 4,
    color: Colors.grey[300],
  );
}
