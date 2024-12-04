import 'package:flutter/material.dart';

import 'package:postervibe/core/app_export.dart';
import 'package:postervibe/core/network/network_info.dart';

/// this widget is stateless widget for base scaffold
/// [child] and [padding] are required parameters
/// [padding] are used for giving padding to a [child] widget
/// [floatingWidget] are used for floating action button widget
class AppBaseScaffold extends StatelessWidget {
  AppBaseScaffold(
      {super.key,
      required this.child,
      this.appbar,
      this.padding,
      this.backgroundColor,
      this.floatingWidget,
      this.bottomNavigationBar,
      this.floatingButtonLocation,
      this.resizeToAvoidBottomInset});

  /// child widget
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final Widget? appbar;
  final Color? backgroundColor;
  final bool? resizeToAvoidBottomInset;

  /// floatingWidget widget
  final Widget? floatingWidget;

  /// for [bottomNavigationBar]  widget
  final Widget? bottomNavigationBar;
  final FloatingActionButtonLocation? floatingButtonLocation;
  final ConnectivityManager connectivityManager = Get.find();

  ///padding EdgeInsets
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        backgroundColor: Theme.of(context).colorScheme.onSecondary,
        resizeToAvoidBottomInset: resizeToAvoidBottomInset,
        appBar: appbar != null
            ? PreferredSize(
                preferredSize: const Size(double.infinity, 60),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 15.0, vertical: 10),
                  child: Column(
                    children: [
                      const SizedBox(
                        width: 24,
                        height: 24,
                      ),
                      appbar ?? const SizedBox.shrink()
                    ],
                  ),
                ),
              )
            : null,
        floatingActionButton: floatingWidget,
        body: Padding(
          padding: padding ?? const EdgeInsets.all(16),
          child: connectivityManager.isConnected.value
              ? child
              : const Center(
                  child: Text('No Internet'),
                ),
        ),
        floatingActionButtonLocation:
            floatingButtonLocation ?? FloatingActionButtonLocation.centerTop,
        bottomNavigationBar: bottomNavigationBar ?? const SizedBox(),
      ),
    );
  }
}
