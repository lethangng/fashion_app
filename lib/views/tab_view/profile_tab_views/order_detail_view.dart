import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../utils/color_app.dart';
import '../../../utils/text_themes.dart';
import '../../../view_models/tab_view_models/bag_tab_view_models/bag_tab_viewmodel.dart';
// import '../../widgets/product_detail_history.dart';

class OrderDetailView extends StatelessWidget {
  OrderDetailView({super.key});
  final BagTabViewmodel bagTabViewModel = Get.put(BagTabViewmodel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: Colors.transparent,
        title: const Text(
          'Thông tin đơn hàng',
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  rowInfo(
                    title: 'Mã đơn hàng: ',
                    value: 'IW3475453455',
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
              ),
              const SizedBox(height: 16),
              const Text(
                '${3} sản phẩm',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: ColorApp.black,
                ),
              ),
              const SizedBox(height: 18),
              // ListView.builder(
              //   physics: const NeverScrollableScrollPhysics(),
              //   shrinkWrap: true,
              //   itemCount: bagTabViewModel.listCart.length,
              //   padding: EdgeInsets.zero,
              //   itemBuilder: (BuildContext context, int index) {
              //     return Padding(
              //       padding: const EdgeInsets.only(bottom: 24),
              //       child: ProductDetailHistory(
              //         bagModel: bagTabViewModel.listCart[index],
              //       ),
              //     );
              //   },
              // ),
              Text(
                'Thông tin chi tiết',
                style: TextThemes.text_14_500,
              ),
              const SizedBox(height: 15),
              rowInfoDetail(
                title: 'Địa chỉ giao hàng: ',
                value:
                    '3 Newbridge Court ,Chino Hills, CA 91709, United States',
              ),
              const SizedBox(height: 24),
              rowInfoDetail(title: 'Giảm giá: ', value: '10%'),
              const SizedBox(height: 24),
              rowInfoDetail(
                  title: 'Thời gian đặt hàng: ', value: '04-03-2024 10:20'),
              const SizedBox(height: 24),
              rowInfoDetail(
                  title: 'Thời gian thanh toán: ', value: '06-03-2024 16:20'),
              const SizedBox(height: 24),
              rowInfoDetail(title: 'Tổng: ', value: '113\$'),
              const SizedBox(height: 30),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {},
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(
                          color: ColorApp.black,
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 10),
                      ),
                      child: const Text(
                        'Mua lại',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: ColorApp.black,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 24),
                  Expanded(
                    child: FilledButton(
                      onPressed: () {},
                      style: FilledButton.styleFrom(
                        backgroundColor: ColorApp.primary,
                        padding: const EdgeInsets.symmetric(
                          vertical: 10,
                        ),
                      ),
                      child: const Text(
                        'Đánh giá',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: ColorApp.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }

  Widget button({
    required String title,
    required bool isOutlineButton,
    void Function()? event,
  }) {
    return OutlinedButton(
      onPressed: event,
      style: OutlinedButton.styleFrom(
        side: const BorderSide(color: ColorApp.black),
      ),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: ColorApp.black,
        ),
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

  Widget rowInfoDetail({
    required String title,
    required String value,
  }) {
    return Row(
      children: [
        SizedBox(
          width: Get.width * 0.4,
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: ColorApp.gray,
            ),
          ),
        ),
        Flexible(
          child: Text(
            value,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: ColorApp.black,
            ),
          ),
        )
      ],
    );
  }
}
