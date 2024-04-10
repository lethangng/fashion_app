// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/bag_models/bag_item.dart';
import '../../utils/color_app.dart';
import '../../utils/text_themes.dart';

class ProductDetailHistory extends StatelessWidget {
  const ProductDetailHistory({
    super.key,
    required this.bagModel,
  });
  final BagItem bagModel;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Container(
        decoration: const BoxDecoration(color: Colors.white),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              bagModel.product.listImage.first,
              width: Get.width * 0.3,
              fit: BoxFit.cover,
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(11),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          bagModel.product.name,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: ColorApp.black,
                          ),
                        ),
                        // const SizedBox(height: 2),
                        Text(
                          bagModel.product.listBrand.first.brand,
                          style: TextThemes.textGray_11_400,
                        ),
                        const SizedBox(height: 7),
                        Row(
                          children: [
                            rowInfo(
                                title: 'Màu: ',
                                value: bagModel.selectColor.color),
                            const SizedBox(width: 22),
                            rowInfo(
                                title: 'Cỡ: ', value: bagModel.selectSize.size),
                          ],
                        ),
                        const SizedBox(height: 11),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            rowInfo(
                                title: 'Số lượng: ',
                                value: '${bagModel.count}'),
                            Text(
                              '${bagModel.count}\$',
                              style: TextThemes.text_14_500,
                            )
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
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
        style: TextThemes.textGray_11_400,
        children: [
          TextSpan(
            text: value,
            style: TextThemes.textGray_11_400.copyWith(color: ColorApp.black),
          )
        ],
      ),
    );
  }
}
