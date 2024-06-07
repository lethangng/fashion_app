import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app/routes.dart';
import '../../../view_models/tab_view_models/shop_tab_viewmodel.dart';
import '../../widgets/category_container.dart';
import '../../widgets/sale_container.dart';

class WomenTab extends StatelessWidget {
  WomenTab({super.key});

  final ShopTabViewModel shopTabViewModel = Get.find<ShopTabViewModel>();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: shopTabViewModel.listDataWomen.length + 1,
      padding: const EdgeInsets.all(16),
      itemBuilder: (BuildContext context, int index) {
        return index == 0
            ? const SaleContainer(
                title: 'Giảm giá cho mùa hè này',
                sub: 'Lên tới 50%',
              )
            : CategoryContainer(
                category: shopTabViewModel.listDataWomen[index - 1],
                event: () => Get.toNamed(Routes.categryDetail),
              );
      },
    );
  }
}
