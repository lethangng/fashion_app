// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../../utils/color_app.dart';

class ListEmpty extends StatelessWidget {
  const ListEmpty({
    super.key,
    this.title = 'Chưa có sản phẩm nào',
  });

  final String? title;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        '$title',
        style: const TextStyle(
          color: ColorApp.black,
          fontSize: 16,
        ),
      ),
    );
  }
}
