import 'package:flutter/material.dart';
import 'package:muzik/core/constants/dimension_constant.dart';

class Header extends StatelessWidget {
  final String headingText;
  final Widget coverImage;
  final Widget? backgroundImage;
  final List<Widget> actions;

  const Header({
    Key? key,
    required this.headingText,
    required this.coverImage,
    this.backgroundImage,
    this.actions = const [],
  }) : super(key: key);

  final Widget _gradientEffect = const SizedBox(
    width: double.infinity,
    height: double.infinity,
    child: DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.grey,
            Colors.black,
          ],
        ),
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      expandedHeight: 290,
      actions: actions,
      flexibleSpace: FlexibleSpaceBar(
        title: Padding(
          padding: DimensionConstants.defaultPadding,
          child: Text(
            headingText,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        background: Stack(
          children: <Widget>[
            if (backgroundImage != null) backgroundImage!,
            _gradientEffect,
            Center(
              child: SizedBox(
                width: 192,
                height: 192,
                child: coverImage,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
