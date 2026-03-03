import 'package:flutter/material.dart';
import 'package:quiz_app/core/consts.dart';

class CustomIcon extends StatelessWidget {
  final double radius;
  final IconData? icon;
  final Color? iconcolor;
  final Color? backgroundColor;
  final double? iconsize;
  const CustomIcon({
    super.key,
    required this.radius,
    required this.icon,
    this.iconcolor,
    this.backgroundColor,
    this.iconsize,
  });

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      backgroundColor:
          backgroundColor ?? AppConsts.secondarycolor.withValues(alpha: .3),
      child: Icon(
        icon,
        color: iconcolor ?? AppConsts.secondarycolor,
        size: iconsize ?? 70,
      ),
    );
  }
}
