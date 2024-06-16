// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/home_models/coupon.dart';
import '../../utils/color_app.dart';
import '../../utils/helper.dart';
import '../../view_models/tab_view_models/bag_tab_view_models/bag_tab_viewmodel.dart';

class DiscountCodeItem extends StatelessWidget {
  DiscountCodeItem({
    super.key,
    required this.coupon,
    this.event,
  });

  final Coupon coupon;
  final void Function()? event;
  final BagTabViewmodel _bagTabViewModel = Get.find<BagTabViewmodel>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Opacity(
          opacity: _bagTabViewModel.totalPrice.value < coupon.for_sum ? 0.5 : 1,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    blurRadius: 25,
                    offset: const Offset(0, 1),
                    color: const Color(0xFF000000).withOpacity(0.08),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    width: Get.width * 0.25,
                    height: Get.width * 0.25,
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      shape: BoxShape.rectangle,
                      color: ColorApp.primary,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          coupon.coupon_type == 0
                              ? Helper.formatNumber(coupon.price)
                              : '${coupon.price}%',
                          style: const TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: ColorApp.white,
                          ),
                        ),
                        const SizedBox(width: 5),
                        const Text(
                          'off',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: ColorApp.white,
                          ),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            // mainAxisSize: MainAxisSize.min,
                            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                coupon.name,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: ColorApp.black,
                                ),
                              ),
                              Text(
                                coupon.code,
                                style: const TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w400,
                                  color: ColorApp.black,
                                ),
                              ),
                              Text(
                                'HSD: ${coupon.expired}',
                                style: const TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w400,
                                  color: ColorApp.gray,
                                ),
                              ),
                            ],
                          ),
                          FilledButton(
                            onPressed: () {
                              if (_bagTabViewModel.totalPrice.value >
                                  coupon.for_sum) {
                                event!();
                              }
                            },
                            style: FilledButton.styleFrom(
                              backgroundColor: ColorApp.primary,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25),
                              ),
                              minimumSize: Size.zero,
                              padding: const EdgeInsets.symmetric(
                                vertical: 4,
                                horizontal: 15,
                              ),
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                            child: const Text(
                              'Áp dụng',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        Visibility(
          visible: _bagTabViewModel.totalPrice.value < coupon.for_sum,
          child: Column(
            children: [
              const SizedBox(height: 5),
              Text(
                'Áp dụng cho đơn hàng trên ${Helper.formatMonney(coupon.for_sum)}',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: ColorApp.primary,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
