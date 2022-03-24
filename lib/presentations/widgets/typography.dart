import 'package:flutter/material.dart';
import 'package:muzik/core/constants/dimension_constant.dart';

class Heading5 extends StatelessWidget {
  final String text;

  const Heading5({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: DimensionConstants.defaultPadding,
      child: Text(
        text,
        style: Theme.of(context).textTheme.headline1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}

class LargeTitle extends StatelessWidget {
  final String text;

  const LargeTitle({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(color: Colors.white),
    );
  }
}
