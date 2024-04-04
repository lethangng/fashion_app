import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../app/routes.dart';
import '../../../utils/color_app.dart';
import '../../../view_models/tab_view_models/bag_tab_models/bag_tab_view_model.dart';
import '../../widgets/product_bag_container.dart';

class BagTabView extends StatelessWidget {
  BagTabView({super.key});
  final BagTabViewModel bagTabViewModel = Get.put(BagTabViewModel());

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).viewPadding.top;
    final appBarHeight = AppBar().preferredSize.height;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: height + appBarHeight),
          const Text(
            'Giỏ hàng',
            style: TextStyle(
              fontSize: 34,
              fontWeight: FontWeight.w700,
              color: ColorApp.black,
            ),
          ),
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
                child: const Expanded(
                  child: TextField(
                    style: TextStyle(
                      color: ColorApp.black,
                    ),
                    textAlignVertical: TextAlignVertical.center,
                    textAlign: TextAlign.left,
                    decoration: InputDecoration(
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
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Tổng: ',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: ColorApp.gray,
                ),
              ),
              Text(
                '141\$',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: ColorApp.black,
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
}
