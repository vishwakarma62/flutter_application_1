import 'package:octo_image/octo_image.dart';
import 'package:postervibe/presentation/widget/shimmer.dart';
import 'package:flutter/material.dart';

import '../../core/app_export.dart';

class CircularImageWidget extends StatelessWidget {
  final String imageUrl;
  final double height;
  final double width;

  final Function()? onTap;

  const CircularImageWidget({
    super.key,
    required this.imageUrl,
    required this.height,
    required this.width,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        children: [
          Container(
            height: width,
            width: height,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    offset: const Offset(0, 3),
                    blurRadius: 16,
                    spreadRadius: 2),
              ],
            ),
            child: ClipOval(
              child: OctoImage(
                image: NetworkImage(imageUrl),
                fit: BoxFit.cover,
                placeholderBuilder: (context) {
                  return mainImageShimmer(Size(width, height), false);
                }, // Provide the size for shimmer
                errorBuilder: (context, error, stackTrace) {
                  return Image.asset(
                    AppImage.defaultImage,
                    filterQuality: FilterQuality.low,
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
