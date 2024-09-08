import 'package:flutter/material.dart';

class ButtonCustom extends StatelessWidget {
  final String title;
  final double? borderRadius;
  final Color? backgroundColor;
  final Color? colorText;
  final Color? colorIcon;
  final IconData? iconData;
  final MainAxisAlignment? mainAxisAlignment;
  final Function()? onTap;

  const ButtonCustom(
      {super.key,
      required this.title,
      this.backgroundColor,
      this.onTap,
      this.borderRadius,
      this.colorText,
      this.colorIcon,
      this.iconData,
      this.mainAxisAlignment});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ButtonStyle(
        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
          const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 8,
          ),
        ),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? 8),
          ),
        ),
        backgroundColor:
            MaterialStateProperty.all<Color>(backgroundColor ?? Colors.white),
        foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
      ),
      child: Row(
        mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            title,
            style: TextStyle(
              fontFamily: 'Overpass',
              fontSize: 18,
              color: colorText ?? Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          Icon(
            iconData,
            size: 24,
            color: colorIcon,
          )
        ],
      ),
    );
  }
}
