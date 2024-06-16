// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/profile_models/order_product.dart';
import '../../utils/color_app.dart';
import 'image_container.dart';

class OrderProductItem extends StatelessWidget {
  const OrderProductItem({
    super.key,
    required this.orderProduct,
  });
  final OrderProduct orderProduct;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ImageContainer(
          image: orderProduct.image_url,
          width: Get.width * 0.3,
          height: Get.width * 0.3,
          replaceImage: '',
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                orderProduct.product_name,
                maxLines: 2,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: ColorApp.black,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              // const SizedBox(height: 5),
              Text(
                orderProduct.brand,
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w400,
                  color: ColorApp.gray,
                ),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  rowInfo(
                    title: 'Màu sắc: ',
                    value: orderProduct.color.name,
                  ),
                  const SizedBox(width: 22),
                  rowInfo(
                    title: 'Kích thước: ',
                    value: orderProduct.size.size,
                  ),
                ],
              ),
              const SizedBox(height: 7),
              rowInfo(
                title: 'Số lượng: ',
                value: orderProduct.quantity.toString(),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget rowInfo({
    required String title,
    required String value,
    bool isMoney = false,
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
            style: TextStyle(
              fontWeight: FontWeight.w500,
              color: isMoney ? ColorApp.primary : ColorApp.black,
            ),
          )
        ],
      ),
    );
  }
}
