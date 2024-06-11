import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';

import '../../../../services/response/api_status.dart';
import '../../../../utils/color_app.dart';
import '../../../../view_models/tab_view_models/shop_tab_view_models/tabs/kid_tab_viewmodel.dart';
import '../../../widgets/list_empty.dart';
import '../../../widgets/loadmore.dart';
import '../../../widgets/product_container.dart';
import '../../../widgets/show_dialog_error.dart';

class KidTab extends StatelessWidget {
  KidTab({super.key});

  final KidTabViewmodel _kidTabViewmodel = Get.put(KidTabViewmodel());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (_kidTabViewmodel.productRes.value.status == Status.error) {
        showDialogError(error: _kidTabViewmodel.productRes.value.message!);
      }

      if (_kidTabViewmodel.productRes.value.status == Status.completed) {
        return Loadmore(
          refreshController: _kidTabViewmodel.refreshController,
          onLoading: _kidTabViewmodel.onLoading,
          onRefresh: _kidTabViewmodel.onRefresh,
          widget: _kidTabViewmodel.listProduct.isEmpty
              ? const ListEmpty()
              : MasonryGridView.count(
                  padding: const EdgeInsets.all(16),
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 16,
                  itemCount: _kidTabViewmodel.listProduct.length,
                  itemBuilder: (context, index) {
                    return ProductContainer(
                      product: _kidTabViewmodel.listProduct[index],
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
