import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:postervibe/core/utils/app_image.dart';

class NoDataWidget extends StatelessWidget {
  final String message;
  const NoDataWidget({
    super.key,
   required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(AppImage.noData),
          const SizedBox(height: 20),
          Text(
            message,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}