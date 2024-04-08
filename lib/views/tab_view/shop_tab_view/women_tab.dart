import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app/routes.dart';
import '../../../view_models/tab_view_models/shop_tab_models/woment_tav_view_model.dart';

class WomenTab extends StatelessWidget {
  WomenTab({super.key});

  final WomentTavViewModel womentTavViewModel = Get.put(WomentTavViewModel());

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: womentTavViewModel.listData.length + 1,
      padding: const EdgeInsets.all(16),
      itemBuilder: (BuildContext context, int index) {
        return index == 0
            ? Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: saleContainer(
                  title: 'Giảm giá cho mùa hè',
                  sub: 'Lên tới 50%',
                ),
              )
            : Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: categoryContainer(
                  title: womentTavViewModel.listData[index - 1].title,
                  image: womentTavViewModel.listData[index - 1].image,
                  event: () => Get.toNamed(Routes.categryDetail),
                ),
              );
      },
    );
  }

  Widget saleContainer({required String title, required String sub}) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 28),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: const Color(0xFFDB3022),
      ),
      child: Column(
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            sub,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.white,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }

  Widget categoryContainer({
    required String title,
    required String image,
    required void Function()? event,
  }) {
    return GestureDetector(
      onTap: event,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                blurRadius: 25,
                offset: const Offset(0, 4),
                color: const Color(0xFF000000).withOpacity(0.08),
              ),
            ],
          ),
          child: Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    const SizedBox(width: 23),
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF222222),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Image.asset(
                  image,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
