import 'package:flutter/material.dart';

class ZoomBuilt extends StatelessWidget {
  const ZoomBuilt({
    Key? key,
    required this.child,
    required this.childKey,
    required this.constrained,
    required this.matrix,
  }) : super(key: key);

  final Widget child;
  final GlobalKey childKey;
  final bool constrained;
  final Matrix4 matrix;

  @override
  Widget build(BuildContext context) {
    Widget child = Transform(
      transform: matrix,
      child: KeyedSubtree(
        key: childKey,
        child: this.child,
      ),
    );

    if (!constrained) {
      child = OverflowBox(
        // alignment: Alignment.center,
        minWidth: 150,
        minHeight: 150,
        maxWidth: double.infinity,
        maxHeight: double.infinity,
        child: child,
      );
    }

    return child;
  }
}
