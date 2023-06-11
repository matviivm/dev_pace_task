import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class CalculateSizeWidget extends SingleChildRenderObjectWidget {
  final Function(Size size) onSizeChange;

  const CalculateSizeWidget({
    Key? key,
    required this.onSizeChange,
    required Widget child,
  }) : super(key: key, child: child);

  @override
  RenderObject createRenderObject(BuildContext context) {
    return CalculateSizeRenderObject(onSizeChange);
  }

  @override
  void updateRenderObject(
    BuildContext context,
    covariant CalculateSizeRenderObject renderObject,
  ) {
    renderObject.onSizeChange = onSizeChange;
  }
}

class CalculateSizeRenderObject extends RenderBox
    with RenderObjectWithChildMixin<RenderBox>, RenderProxyBoxMixin<RenderBox> {
  void Function(Size size) onSizeChange;

  Size? oldSize;

  CalculateSizeRenderObject(this.onSizeChange);

  @override
  void performLayout() {
    super.performLayout();

    Size newSize = child!.size;
    if (oldSize == newSize) return;

    oldSize = newSize;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      onSizeChange(newSize);
    });
  }
}
