import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:muzik/config/app_color.dart';

class FullWidthPrimaryButton extends StatelessWidget {
  final String label;
  final void Function()? onPressed;
  final Color? bgColor;
  final Color? textColor;
  final Widget? icon;
  final bool uppercaseLabel;

  const FullWidthPrimaryButton({
    Key? key,
    required this.label,
    this.onPressed,
    this.bgColor,
    this.icon,
    this.textColor,
    this.uppercaseLabel = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 65.h,
      width: double.infinity,
      child: OutlinedButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          backgroundColor: bgColor ?? AppColor.primaryBgr,
          elevation: 2,
          shape: const RoundedRectangleBorder(),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) icon!,
            Visibility(
              visible: icon != null,
              child: SizedBox(width: 10.w),
            ),
            Text(
              uppercaseLabel ? label.toUpperCase() : label,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: textColor ?? AppColor.white,
                fontSize: 24.h,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
