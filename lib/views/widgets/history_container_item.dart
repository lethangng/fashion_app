// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../app/routes.dart';
import '../../models/profile_models/order.dart';
import '../../utils/color_app.dart';
import '../../utils/helper.dart';
import 'order_product_item.dart';

class HistoryOrderType {
  final String title;
  final Color color;

  HistoryOrderType({required this.title, required this.color});
}

class HistoryContainerItem extends StatelessWidget {
  const HistoryContainerItem({
    super.key,
    required this.order,
  });

  final Order order;

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
                value: '${order.id}',
              ),
              Text(
                order.created_at,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: ColorApp.gray,
                ),
              ),
            ],
          ),
          const SizedBox(height: 13),
          OrderProductItem(orderProduct: order.order_info),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              rowInfo(
                title: 'Sản phẩm: ',
                value: order.count.toString(),
              ),
              rowInfo(
                title: 'Tổng tiền: ',
                value: Helper.formatMonney(order.total_price),
                isMoney: true,
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              OutlinedButton(
                onPressed: () => Get.toNamed(
                  Routes.orderDetail,
                  arguments: {'orderId': order.id},
                ),
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
              Text(
                order.status_title,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: orderTypeColor(order.status),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  Color orderTypeColor(int status) {
    if (status == 5) {
      return ColorApp.primary;
    } else if (status == 4) {
      return ColorApp.success;
    } else {
      return ColorApp.origin;
    }
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
