import 'package:octo_image/octo_image.dart';
import 'package:postervibe/presentation/widget/shimmer.dart';

import 'package:flutter/material.dart';

import '../../core/app_export.dart';

class ImageCard extends StatelessWidget {
  final String imageUrl;
  final bool isVideo;
  final bool isNetwork;
  final String date;
  final bool roundedborder;
  final double height;
  final double width;
  final Function()? onImageClick;
  final Function()? onDeleteClick;

  const ImageCard({
    super.key,
    required this.imageUrl,
    this.roundedborder = true,
    this.date = '',
    this.onImageClick,
    this.onDeleteClick,
    required this.height,
    required this.width,
    this.isVideo = false,
    this.isNetwork = false,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(Get.context!).size;

    return GestureDetector(
      onTap: onImageClick,
      child: Stack(
        children: [
          Container(
            height: height,
            width: width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    offset: const Offset(0, 2),
                    blurRadius: 16,
                    spreadRadius: 2),
              ],
            ),
            child: ClipRRect(
              borderRadius:
                  roundedborder ? BorderRadius.circular(10) : BorderRadius.zero,
              child: OctoImage(
                errorBuilder: (context, error, stackTrace) {
                  return Image.asset(
                    AppImage.defaultImage,
                    filterQuality: FilterQuality.low,
                  );
                },
                fit: BoxFit.cover,
                image: NetworkImage(imageUrl),
                placeholderBuilder: (context) {
                  return mainImageShimmer(size, true);
                },
              ),
            ),
          ),
          if (date.isNotEmpty)
            Positioned(
              right: 0,
              bottom: 0,
              child: Container(
                height: 20,
                width: 50,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppColors.darkShadeBlue,
                      AppColors.darkShadeBlue,
                      AppColors.darkShadeBlue.withOpacity(0.5),
                      AppColors.darkShadeLightBlue.withOpacity(0.3),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8),
                      bottomRight: Radius.circular(8)),
                ),
                child: Center(
                    child: Text(
                  date,
                  style: const TextStyle(fontSize: 10, color: Colors.white),
                )),
              ),
            ),
        ],
      ),
    );
  }
}
