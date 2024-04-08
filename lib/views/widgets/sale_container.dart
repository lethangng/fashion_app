// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../../utils/color_app.dart';

class SaleContainer extends StatelessWidget {
  const SaleContainer({
    super.key,
    required this.title,
    required this.sub,
    this.background = ColorApp.primary,
    this.textColor = ColorApp.white,
    this.event,
  });
  final String title;
  final String sub;
  final Color background;
  final Color textColor;
  final void Function()? event;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 28),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: background,
        ),
        child: Column(
          children: [
            Text(
              title,
              style: TextStyle(
                color: textColor,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              sub,
              style: TextStyle(
                fontSize: 14,
                color: textColor,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
