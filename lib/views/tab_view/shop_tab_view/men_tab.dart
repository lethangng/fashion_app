import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app/routes.dart';
import '../../../view_models/tab_view_models/shop_tab_models/woment_tav_view_model.dart';
import '../../widgets/category_container.dart';
import '../../widgets/sale_container.dart';

class MenTab extends StatelessWidget {
  MenTab({super.key});

  final WomentTavViewModel womentTavViewModel = Get.put(WomentTavViewModel());

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: womentTavViewModel.listData.length + 1,
      padding: const EdgeInsets.all(16),
      itemBuilder: (BuildContext context, int index) {
        return index == 0
            ? const SaleContainer(
                title: 'Giảm giá cho mùa hè này',
                sub: 'Lên tới 50%',
              )
            : CategoryContainer(
                title: womentTavViewModel.listData[index - 1].title,
                image: womentTavViewModel.listData[index - 1].image,
                event: () => Get.toNamed(Routes.categryDetail),
              );
      },
    );
  }
}
