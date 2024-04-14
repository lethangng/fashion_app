import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../app/routes.dart';
import '../../../utils/color_app.dart';
import '../../../view_models/tab_view_models/bag_tab_view_models/bag_tab_controller.dart';
import '../../widgets/discount_code_item.dart';
import '../../widgets/product_bag_container.dart';

class BagTabView extends StatelessWidget {
  BagTabView({super.key});
  final BagTabController bagTabViewModel = Get.put(BagTabController());

  final TextEditingController discountCodeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // final height = MediaQuery.of(context).viewPadding.top;
    final appBarHeight = AppBar().preferredSize.height;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: appBarHeight),
          const Text(
            'Giỏ hàng',
            style: TextStyle(
              fontSize: 34,
              fontWeight: FontWeight.w700,
              color: ColorApp.black,
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: Obx(
              () => ListView.builder(
                itemCount: bagTabViewModel.listDataBag.length,
                padding: EdgeInsets.zero,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 24),
                    child: ProductBagContainer(
                      bagModel: bagTabViewModel.listDataBag[index],
                    ),
                  );
                },
              ),
            ),
          ),
          Stack(
            children: [
              Container(
                width: Get.width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 8,
                      offset: const Offset(0, 1),
                      color: const Color(0xFF000000).withOpacity(0.05),
                    ),
                  ],
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(8),
                    bottomLeft: Radius.circular(8),
                    topRight: Radius.circular(35),
                    bottomRight: Radius.circular(35),
                  ),
                ),
                child: TextField(
                  controller: discountCodeController,
                  style: const TextStyle(
                    color: ColorApp.black,
                  ),
                  onTap: () => onShowSelectDiscountCode(),
                  readOnly: true,
                  textAlignVertical: TextAlignVertical.center,
                  textAlign: TextAlign.left,
                  decoration: const InputDecoration(
                    isDense: true, // Cho chu can giua theo chieu doc
                    hintText: 'Nhập mã giảm giá',
                    hintStyle: TextStyle(
                      color: ColorApp.colorGrey2,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 12,
                    ),
                  ),
                ),
              ),
              Positioned.fill(
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    width: 36,
                    height: 36,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: ColorApp.black,
                    ),
                    child: IconButton(
                      onPressed: () {},
                      icon: SvgPicture.asset('assets/icons/arrow-right.svg'),
                    ),
                  ),
                ),
              )
            ],
          ),
          const SizedBox(height: 28),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Tổng: ',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: ColorApp.gray,
                ),
              ),
              Obx(
                () => Text(
                  '${bagTabViewModel.totalPrice.value}\$',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: ColorApp.black,
                  ),
                ),
              )
            ],
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: () => Get.toNamed(Routes.pay),
              style: OutlinedButton.styleFrom(
                side: const BorderSide(
                  width: 0,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                foregroundColor: Colors.white,
                backgroundColor: const Color(0xFFDB3022),
                padding: const EdgeInsets.symmetric(vertical: 15),
              ),
              child: const Text(
                'Mua hàng',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(height: 22),
        ],
      ),
    );
  }

  void onShowSelectDiscountCode() {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 5),
            Container(
              width: Get.width * 0.2,
              height: 5,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: const Color(0xFF979797),
              ),
            ),
            const SizedBox(height: 32),
            Stack(
              children: [
                Container(
                  width: Get.width,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 8,
                        offset: const Offset(0, 1),
                        color: const Color(0xFF000000).withOpacity(0.05),
                      ),
                    ],
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(8),
                      bottomLeft: Radius.circular(8),
                      topRight: Radius.circular(35),
                      bottomRight: Radius.circular(35),
                    ),
                  ),
                  child: TextField(
                    controller: discountCodeController,
                    style: const TextStyle(
                      color: ColorApp.black,
                    ),
                    onTap: () {},
                    textAlignVertical: TextAlignVertical.center,
                    textAlign: TextAlign.left,
                    decoration: const InputDecoration(
                      isDense: true, // Cho chu can giua theo chieu doc
                      hintText: 'Nhập mã giảm giá',
                      hintStyle: TextStyle(
                        color: ColorApp.colorGrey2,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 12,
                      ),
                    ),
                  ),
                ),
                Positioned.fill(
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      width: 36,
                      height: 36,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: ColorApp.black,
                      ),
                      child: IconButton(
                        onPressed: () {},
                        icon: SvgPicture.asset('assets/icons/arrow-right.svg'),
                      ),
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(height: 15),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Mã giảm giá của bạn',
                style: TextStyle(
                  color: Color(0xFF222222),
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: bagTabViewModel.listDiscountCode.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 24),
                    child: DiscountCodeItem(
                      discountCode: bagTabViewModel.listDiscountCode[index],
                      event: () {},
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
      backgroundColor: ColorApp.background,
    );
  }
}
