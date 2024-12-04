import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:postervibe/core/utils/app_image.dart';

class NoInternetWidget extends StatelessWidget {
  const NoInternetWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 100,
            width: 100,
            child: Lottie.asset(AppImage.noInternet),
          ),
         
        ],
      ),
    );
  }
}
