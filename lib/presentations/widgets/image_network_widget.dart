import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:muzik/presentations/widgets/place_holder_widget.dart';

class ImageNetworkWidget extends StatelessWidget {
  final String imageUrl;
  final double width;
  final double height;
  final BoxFit fit;
  final bool autoSize;
  final double ratio;
  final bool hasDefaultErrorBg;

  const ImageNetworkWidget({
    Key? key,
    this.imageUrl = '',
    this.width = 0.0,
    this.height = 0.0,
    this.fit = BoxFit.cover,
    this.autoSize = false,
    this.ratio = 16 / 9,
    this.hasDefaultErrorBg = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return autoSize
        ? _buildDynamicSizeImageWidget()
        : _buildDefaultImageViewWidget();
  }

  Widget _buildDefaultImageViewWidget() {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      width: width,
      height: height,
      fit: fit,
      placeholder: (context, value) {
        return PlaceHolderWidget(
          width: width,
          height: height,
        );
      },
      errorWidget: (context, url, error) {
        return hasDefaultErrorBg ? _defaultErrorWidget(context) : Container();
      },
    );
  }

  Widget _buildDynamicSizeImageWidget() {
    return AspectRatio(
      aspectRatio: ratio,
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        fit: BoxFit.fill,
        placeholder: (context, value) {
          return PlaceHolderWidget(width: width);
        },
        errorWidget: (context, url, error) {
          return hasDefaultErrorBg ? _defaultErrorWidget(context) : Container();
        },
      ),
    );
  }

  Widget _defaultErrorWidget(BuildContext context) {
    return PlaceHolderWidget(
      width: width,
      height: height,
    );
  }
}
