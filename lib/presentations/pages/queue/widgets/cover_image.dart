import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CoverImage extends StatelessWidget {
  final double overlayOpacity;
  final String? imageUrl;

  const CoverImage({
    Key? key,
    required this.imageUrl,
    this.overlayOpacity = 0.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 160,
      height: 160,
      child: DecoratedBox(
        decoration: BoxDecoration(
          image: DecorationImage(
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(overlayOpacity),
              BlendMode.srcATop,
            ),
            image: CachedNetworkImageProvider(
              imageUrl ??
                  "http://sonphuoc.com/wp-content/themes/fox/images/placeholder.jpg",
            ),
            fit: BoxFit.cover,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          boxShadow: const <BoxShadow>[
            BoxShadow(
              color: Colors.black38,
              blurRadius: 10.0,
              offset: Offset(0, 6),
            ),
          ],
        ),
      ),
    );
  }
}
