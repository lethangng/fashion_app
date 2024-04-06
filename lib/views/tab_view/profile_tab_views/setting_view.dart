import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../app/routes.dart';
import '../../../utils/color_app.dart';
import '../../../utils/text_themes.dart';

class SettingView extends StatelessWidget {
  const SettingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: Colors.transparent,
        // actions: [
        //   IconButton(
        //     onPressed: () {},
        //     icon: SvgPicture.asset('assets/icons/search.svg'),
        //   ),
        // ],
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: SvgPicture.asset('assets/icons/arrow-back.svg'),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 14),
            const Text(
              'Cài đặt',
              style: TextStyle(
                fontSize: 34,
                fontWeight: FontWeight.bold,
                color: ColorApp.black,
              ),
            ),
            const Text(
              'Thông tin cá nhân',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: ColorApp.black,
              ),
            ),
            const SizedBox(height: 19),
            containerInfo(title: 'Họ và tên', value: 'Lê Ngọc Thắng'),
            const SizedBox(height: 19),
            containerInfo(title: 'Email', value: 'email@gmail.com'),
            const SizedBox(height: 24),
            containerInfo(title: 'Ngày sinh', value: '12/12/1989'),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: () => Get.toNamed(Routes.changeInfo),
                style: FilledButton.styleFrom(
                  backgroundColor: ColorApp.primary,
                  minimumSize: Size.zero,
                  padding: const EdgeInsets.symmetric(
                    vertical: 14,
                  ),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: Text(
                  'Thay đổi',
                  style: TextThemes.text_14_500.copyWith(color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget containerInfo({
    required String title,
    required String value,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4),
        boxShadow: [
          BoxShadow(
            blurRadius: 8,
            offset: const Offset(0, 1),
            color: Colors.black.withOpacity(0.05),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w400,
              color: ColorApp.gray,
            ),
          ),
          const SizedBox(height: 3),
          Text(
            value,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: ColorApp.black,
            ),
          ),
        ],
      ),
    );
  }
}
