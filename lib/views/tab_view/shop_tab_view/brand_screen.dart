import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../view_models/tab_view_models/shop_tab_models/brand_view_model.dart';

class BrandScreen extends StatelessWidget {
  BrandScreen({super.key});
  final BrandViewModel brandViewModel = Get.find<BrandViewModel>();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Hãng',
          style: TextStyle(
            color: Color(0xFF222222),
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: SvgPicture.asset('assets/icons/arrow-back.svg'),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            const SizedBox(height: 21),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(23),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 8,
                    offset: const Offset(0, 1),
                    color: const Color(0xFF000000).withOpacity(0.05),
                  )
                ],
              ),
              child: TextField(
                cursorColor: const Color(0xFF9B9B9B),
                style: const TextStyle(color: Colors.white),
                textAlignVertical: TextAlignVertical.center,
                textAlign: TextAlign.left,
                decoration: InputDecoration(
                  isDense: true, // Cho chu can giua theo chieu doc
                  hintText: 'Tìm kiếm',
                  hintStyle: const TextStyle(
                    color: Color(0xFF9B9B9B),
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: size.width * 0.03,
                    vertical: 10,
                  ),
                  prefixIcon: Container(
                    width: 24,
                    alignment: Alignment.center,
                    child: SvgPicture.asset(
                      'assets/icons/search-icon.svg',
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 15),
            Expanded(
              child: Obx(
                () => ListView.builder(
                  itemCount: brandViewModel.listData.length,
                  itemBuilder: (BuildContext context, int index) {
                    return rowContainer(
                      id: brandViewModel.listData[index].id,
                      title: brandViewModel.listData[index].title,
                      isChecked: brandViewModel.listData[index].isChecked,
                    );
                  },
                ),
              ),
            ),
            Container(
              width: Get.width,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              decoration: BoxDecoration(color: Colors.white, boxShadow: [
                BoxShadow(
                  blurRadius: 8,
                  offset: const Offset(0, -4),
                  color: const Color(0xFF000000).withOpacity(0.1),
                )
              ]),
              child: Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        brandViewModel.handleDiscard();
                      },
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(
                          color: Color(0xFF222222),
                          width: 2,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                        foregroundColor: const Color(0xFF222222),
                      ),
                      child: const Text(
                        'Loại bỏ',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 25),
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Get.back(),
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(
                          width: 0,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                        foregroundColor: Colors.white,
                        backgroundColor: const Color(0xFFDB3022),
                      ),
                      child: const Text(
                        'Áp dụng',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget rowContainer({
    required int id,
    required String title,
    required bool isChecked,
  }) {
    return Row(
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w400,
            color:
                isChecked ? const Color(0xFfDB3022) : const Color(0xFF222222),
          ),
        ),
        const Spacer(),
        Checkbox(
          checkColor: Colors.white,
          activeColor: const Color(0xFFDB3022),
          value: isChecked,
          onChanged: (bool? value) => brandViewModel.handleOnCheck(id),
        ),
      ],
    );
  }
}
