import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../utils/color_app.dart';

class EditAddressView extends StatelessWidget {
  const EditAddressView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorApp.background,
      appBar: AppBar(
        title: const Text(
          'Thêm địa chỉ',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: ColorApp.black,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: SvgPicture.asset('assets/icons/arrow-back.svg'),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            inputContainer(
              textHind: 'Họ tên',
            ),
            const SizedBox(height: 20),
            inputContainer(
              textHind: 'Địa chỉ',
            ),
            const SizedBox(height: 20),
            inputContainer(
              textHind: 'Tỉnh/Thành phố',
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  side: BorderSide.none,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  foregroundColor: Colors.white,
                  backgroundColor: const Color(0xFFDB3022),
                  padding: const EdgeInsets.symmetric(vertical: 15),
                ),
                child: const Text(
                  'Lưu địa chỉ',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }

  Widget inputContainer({
    required String textHind,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 15,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4),
        boxShadow: [
          BoxShadow(
            blurRadius: 8,
            offset: const Offset(0, 1),
            color: const Color(0xFF000000).withOpacity(0.05),
          ),
        ],
      ),
      child: TextField(
        textAlignVertical: TextAlignVertical.center,
        textAlign: TextAlign.left,
        decoration: InputDecoration(
          labelText: textHind,

          labelStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: ColorApp.gray,
          ),
          isDense: true, // Cho chu can giua theo chieu doc
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(
            horizontal: Get.width * 0.01,
          ),
        ),
      ),
    );
  }
}
