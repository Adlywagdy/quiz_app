import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final Color textColor;
  final Color backgroundColor;
  final double? shapecircularradius;
  final WidgetStateProperty<Size?>? fixedSize;
  final IconData? icon;
  final Color? iconcolor;
  final void Function()? onPressed;
  const CustomButton({
    super.key,

    required this.text,
    required this.textColor,
    required this.backgroundColor,
    this.fixedSize,
    this.shapecircularradius,
    this.icon,
    this.iconcolor,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        shape: shapecircularradius != null
            ? WidgetStatePropertyAll(
                ContinuousRectangleBorder(
                  borderRadius: BorderRadiusGeometry.circular(
                    shapecircularradius!,
                  ),
                ),
              )
            : null,
        fixedSize: fixedSize,
        backgroundColor: WidgetStatePropertyAll(backgroundColor),
      ),
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: .center,
        children: [
          Icon(icon, color: iconcolor),
          Text(text, style: TextStyle(color: textColor)),
        ],
      ),
    );
  }
}
