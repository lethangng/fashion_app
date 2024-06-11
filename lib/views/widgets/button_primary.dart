// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../../utils/color_app.dart';

class ButtonPrimary extends StatelessWidget {
  const ButtonPrimary({
    super.key,
    required this.title,
    this.background = ColorApp.primary,
    this.isUpperCase = false,
    this.size = double.infinity,
    this.fontSize = 14,
    this.padding = 14,
    this.color = ColorApp.white,
    this.event,
  });

  final String title;
  final Color background;
  final bool isUpperCase;
  final double size;
  final double fontSize;
  final double padding;
  final Color color;
  final void Function()? event;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      child: FilledButton(
        onPressed: event,
        style: FilledButton.styleFrom(
          backgroundColor: background,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          minimumSize: Size.zero,
          padding: EdgeInsets.symmetric(
            vertical: padding,
          ),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
        child: Text(
          isUpperCase ? title.toUpperCase() : title,
          // style: TextThemes.text_14_500.copyWith(color: Colors.white),
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.w500,
            color: color,
          ),
        ),
      ),
    );
  }
}
