import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';

import '../../../../services/response/api_status.dart';
import '../../../../utils/color_app.dart';
import '../../../../view_models/tab_view_models/shop_tab_view_models/tabs/accessory_tab_viewmodel.dart';
import '../../../widgets/list_empty.dart';
import '../../../widgets/loadmore.dart';
import '../../../widgets/product_container.dart';
import '../../../widgets/show_dialog_error.dart';

class AccessoryTab extends StatelessWidget {
  AccessoryTab({super.key});

  final AccessoryTabViewmodel _accessoryTabViewmodel =
      Get.put(AccessoryTabViewmodel());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (_accessoryTabViewmodel.productRes.value.status == Status.error) {
        showDialogError(
            error: _accessoryTabViewmodel.productRes.value.message!);
      }

      if (_accessoryTabViewmodel.productRes.value.status == Status.completed) {
        return Loadmore(
          refreshController: _accessoryTabViewmodel.refreshController,
          onLoading: _accessoryTabViewmodel.onLoading,
          onRefresh: _accessoryTabViewmodel.onRefresh,
          widget: _accessoryTabViewmodel.listProduct.isEmpty
              ? const ListEmpty()
              : MasonryGridView.count(
                  padding: const EdgeInsets.all(16),
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 16,
                  itemCount: _accessoryTabViewmodel.listProduct.length,
                  itemBuilder: (context, index) {
                    return ProductContainer(
                      product: _accessoryTabViewmodel.listProduct[index],
                      productType: ProductType.product,
                    );
                  },
                ),
        );
      }
      return const Center(
        child: CircularProgressIndicator(
          color: ColorApp.primary,
        ),
      );
    });
  }
}
