// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../../utils/color_app.dart';
import '../../utils/text_themes.dart';

class ButtonSecond extends StatelessWidget {
  const ButtonSecond({
    super.key,
    required this.title,
    this.borderColor = ColorApp.black,
    this.borderSize = 1.5,
    this.isUpperCase = false,
    this.size = double.infinity,
    this.event,
  });

  final String title;
  final Color borderColor;
  final double borderSize;
  final bool isUpperCase;
  final double size;
  final void Function()? event;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      child: OutlinedButton(
        onPressed: event,
        style: OutlinedButton.styleFrom(
          // backgroundColor: background,
          side: BorderSide(
            color: borderColor,
            width: borderSize,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          minimumSize: Size.zero,
          padding: const EdgeInsets.symmetric(
            vertical: 14,
          ),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
        child: Text(
          isUpperCase ? title.toUpperCase() : title,
          style: TextThemes.text_14_500.copyWith(color: borderColor),
        ),
      ),
    );
  }
}
