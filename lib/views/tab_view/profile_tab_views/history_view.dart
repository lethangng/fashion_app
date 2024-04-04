import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../utils/color_app.dart';

class HistoryView extends StatelessWidget {
  const HistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {},
            icon: SvgPicture.asset('assets/icons/search.svg'),
          ),
        ],
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: SvgPicture.asset('assets/icons/arrow-back.svg'),
        ),
      ),
      body: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 14),
        child: Column(
          children: [
            SizedBox(height: 18),
            Text(
              'Lịch sử mua hàng',
              style: TextStyle(
                fontSize: 34,
                fontWeight: FontWeight.bold,
                color: ColorApp.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
