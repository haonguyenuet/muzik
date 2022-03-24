import 'package:flutter/material.dart';
import 'package:muzik/config/app_color.dart';
import 'package:shimmer/shimmer.dart';

class PlaceHolderWidget extends StatelessWidget {
  final double width;
  final double height;
  final Color shimmerBaseColor;
  final Color shimmerHighlightColor;
  final BorderRadiusGeometry borderRadius;

  final bool autoSize;
  final double ratio;

  const PlaceHolderWidget({
    Key? key,
    this.width = 100.0,
    this.height = 100.0,
    this.shimmerBaseColor = AppColor.shimmerBaseColor,
    this.shimmerHighlightColor = AppColor.shimmerHighlightColor,
    this.borderRadius = BorderRadius.zero,
    this.ratio = 1,
    this.autoSize = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final gradient = LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.centerRight,
        colors: <Color>[
          shimmerBaseColor,
          shimmerBaseColor,
          shimmerHighlightColor,
          shimmerBaseColor,
          shimmerBaseColor,
        ],
        stops: const <double>[
          0.0,
          0.35,
          0.5,
          0.65,
          1.0
        ]);

    return autoSize
        ? _buildDynamicShimmer(gradient)
        : _buildDefaultShimmer(gradient);
  }

  Widget _buildDefaultShimmer(LinearGradient gradient) {
    return Shimmer(
      gradient: gradient,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          borderRadius: borderRadius,
          color: AppColor.shimmerBaseColor,
        ),
      ),
    );
  }

  Widget _buildDynamicShimmer(LinearGradient gradient) {
    return AspectRatio(
      aspectRatio: ratio,
      child: Shimmer(
        gradient: gradient,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: borderRadius,
            color: AppColor.shimmerBaseColor,
          ),
        ),
      ),
    );
  }
}
