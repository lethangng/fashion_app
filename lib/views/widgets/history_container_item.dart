import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../app/routes.dart';
import '../../utils/color_app.dart';

class HistoryContainerItem extends StatelessWidget {
  const HistoryContainerItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 18,
        horizontal: 24,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            blurRadius: 24,
            offset: const Offset(0, 1),
            color: Colors.black.withOpacity(0.12),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              rowInfo(
                title: 'Mã đơn hàng: ',
                value: 'IW3475453455',
              ),
              const Text(
                '05-12-2019',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: ColorApp.gray,
                ),
              ),
            ],
          ),
          const SizedBox(height: 13),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                'assets/images/product-2.png',
                width: Get.width * 0.3,
                height: Get.width * 0.3,
                fit: BoxFit.cover,
              ),
              const SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Pullover',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: ColorApp.black,
                    ),
                  ),
                  const Text(
                    'Mango',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w400,
                      color: ColorApp.gray,
                    ),
                  ),
                  const SizedBox(height: 15),
                  Row(
                    children: [
                      rowInfo(
                        title: 'Màu: ',
                        value: 'Xám',
                      ),
                      const SizedBox(width: 22),
                      rowInfo(
                        title: 'Cỡ: ',
                        value: 'L',
                      ),
                    ],
                  ),
                  const SizedBox(height: 7),
                  rowInfo(
                    title: 'Số lượng: ',
                    value: '1',
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              rowInfo(
                title: 'Sản phẩm: ',
                value: '3',
              ),
              rowInfo(
                title: 'Tổng tiền: ',
                value: '112\$',
              ),
            ],
          ),
          const SizedBox(height: 14),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              OutlinedButton(
                onPressed: () => Get.toNamed(Routes.orderDetail),
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: ColorApp.black),
                ),
                child: const Text(
                  'Chi tiết',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: ColorApp.black,
                  ),
                ),
              ),
              const Text(
                'Đã giao hàng',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: ColorApp.success,
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget rowInfo({
    required String title,
    required String value,
  }) {
    return RichText(
      text: TextSpan(
        text: title,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: ColorApp.gray,
        ),
        children: [
          TextSpan(
            text: value,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              color: ColorApp.black,
            ),
          )
        ],
      ),
    );
  }
}
