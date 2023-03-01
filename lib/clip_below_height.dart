import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ClipBelowHeight extends SingleChildRenderObjectWidget {
  const ClipBelowHeight({
    super.key,
    super.child,
    required this.clipHeight,
    required this.opacityFactor,
  });

  /// The minimum height the [child] must have, as well as the height at which
  /// clipping begins.
  final double clipHeight;

  /// The opacity factor to apply when the height decreases.
  final double opacityFactor;

  @override
  RenderObject createRenderObject(BuildContext context) {
    return RenderClipBelowHeight(clipHeight: clipHeight, factor: opacityFactor);
  }

  @override
  void updateRenderObject(
    BuildContext context,
    RenderClipBelowHeight renderObject,
  ) {
    renderObject
      ..clipHeight = clipHeight
      ..factor = opacityFactor;
  }
}

class RenderClipBelowHeight extends RenderBox with RenderObjectWithChildMixin {
  RenderClipBelowHeight({required double clipHeight, required double factor})
      : _clipHeight = clipHeight,
        _factor = factor;

  double _clipHeight;

  double get clipHeight => _clipHeight;

  set clipHeight(double value) {
    assert(value >= .0);
    if (_clipHeight == value) return;
    _clipHeight = value;
    markNeedsLayout();
  }

  double _factor;

  double get factor => _factor;

  set factor(double value) {
    assert(value >= .0);
    if (_factor == value) return;
    _factor = value;
    markNeedsLayout();
  }

  @override
  bool get sizedByParent => false;

  @override
  void performLayout() {
    /// The child contraints depend on whether [constraints.maxHeight] is less
    /// than [clipHeight]. This RenderObject's responsibility is to ensure that
    /// the child's height is never below [clipHeight], because when the
    /// child's height is below [clipHeight], then there will be visual
    /// overflow.
    final childConstraints = constraints.maxHeight < _clipHeight
        ? BoxConstraints.tight(Size(constraints.maxWidth, _clipHeight))
        : constraints;

    (child as RenderBox).layout(childConstraints, parentUsesSize: true);

    size = Size(constraints.maxWidth, constraints.maxHeight);
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    final theChild = child as RenderBox;

    /// Clip the painted area to [size], which allows the [child] height to
    /// be greater than [size] without overflowing.
    context.pushClipRect(
      true,
      offset,
      Offset.zero & size,
      (PaintingContext context, Offset offset) {
        /// (optional) Set the opacity by applying the specified factor.
        context.pushOpacity(
          offset,

          /// The opacity begins to take effect at approximately half [size].
          ((255.0 + 128.0) * _factor).toInt(),
          (context, offset) {
            /// Ensure the child remains centered vertically based on [size].
            final centeredOffset =
                Offset(.0, (size.height - theChild.size.height) / 2.0);

            context.paintChild(theChild, centeredOffset + offset);
          },
        );
      },
    );
  }

  @override
  bool hitTestChildren(BoxHitTestResult result, {required Offset position}) {
    final theChild = child as RenderBox;
    var childParentData = theChild.parentData as BoxParentData;

    final isHit = result.addWithPaintOffset(
      offset: childParentData.offset,
      position: position,
      hitTest: (BoxHitTestResult result, Offset transformed) {
        assert(transformed == position - childParentData.offset);
        return theChild.hitTest(result, position: transformed);
      },
    );

    return isHit;
  }

  @override
  Size computeDryLayout(BoxConstraints constraints) => constraints.biggest;

  @override
  double computeMinIntrinsicWidth(double height) =>
      (child as RenderBox).getMinIntrinsicWidth(height);

  @override
  double computeMaxIntrinsicWidth(double height) =>
      (child as RenderBox).getMaxIntrinsicWidth(height);

  @override
  double computeMinIntrinsicHeight(double width) =>
      (child as RenderBox).getMinIntrinsicHeight(width);

  @override
  double computeMaxIntrinsicHeight(double width) =>
      (child as RenderBox).getMaxIntrinsicHeight(width);
}
