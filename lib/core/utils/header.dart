import 'package:flutter/material.dart';
import 'package:postervibe/core/app_export.dart';
import 'package:postervibe/presentation/widget/app_text.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({
    Key? key,
    required this.title,
    required this.postLength,
    required this.onTap,
    this.showViewAll = true,
  }) : super(key: key);

  final String title;
  final int postLength;
  final Function() onTap;
  final bool showViewAll;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Expanded(child: capitalizeWords(title)),
          if (showViewAll && postLength > 3)
            InkWell(
              onTap: onTap,
              child: Ink(
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: AppColors.appBluePurple),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  child: Row(
                    children: [
                      Text(
                        'View All'.tr,
                        style: const TextStyle(
                          color: Color(0xff312B67),
                          fontSize: 10,
                        ),
                      ),
                      const Icon(
                        Icons.chevron_right,
                        size: 18,
                        color: Color(0xff312B67),
                      )
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
