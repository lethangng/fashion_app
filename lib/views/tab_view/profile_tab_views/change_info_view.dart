import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../utils/color_app.dart';
import '../../widgets/button_primary.dart';

class ChangeInfoView extends StatelessWidget {
  const ChangeInfoView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: SvgPicture.asset('assets/icons/arrow-back.svg'),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            const SizedBox(height: 24),
            containerInfo(
              title: 'Họ và tên',
              value: 'Lê Ngọc Thắng',
              textHind: 'Nhập họ và tên',
            ),
            const SizedBox(height: 24),
            containerInfo(
              title: 'Email',
              value: 'email@gmail.com',
              textHind: 'Nhập email',
            ),
            const SizedBox(height: 24),
            containerInfo(
              title: 'Ngày sinh',
              value: '12/12/1989',
              textHind: 'Nhập ngày sinh',
            ),
            const SizedBox(height: 24),
            ButtonPrimary(
              title: 'Lưu',
              isUpperCase: true,
              event: () {},
            ),
          ],
        ),
      ),
    );
  }

  Widget containerInfo({
    required String title,
    required String value,
    required String textHind,
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
          TextField(
            // controller: controller,
            // obscureText: isPassword,
            cursorColor: ColorApp.colorGrey2,
            style: const TextStyle(color: Colors.white),
            textAlignVertical: TextAlignVertical.center,
            textAlign: TextAlign.left,
            decoration: InputDecoration(
              isDense: true, // Cho chu can giua theo chieu doc
              hintText: textHind,
              hintStyle: const TextStyle(
                color: ColorApp.colorGrey2,
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
              border: InputBorder.none,
              contentPadding: EdgeInsets.zero,
            ),
          ),
        ],
      ),
    );
  }
}
