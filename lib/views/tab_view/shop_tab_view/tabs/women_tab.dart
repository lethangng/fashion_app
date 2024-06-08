import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';

import '../../../../services/response/api_status.dart';
import '../../../../utils/color_app.dart';
import '../../../../view_models/tab_view_models/shop_tab_view_models/tabs/women_tab_viewmodel.dart';
import '../../../widgets/loadmore.dart';
import '../../../widgets/product_container.dart';
import '../../../widgets/show_dialog_error.dart';

class WomenTab extends StatelessWidget {
  WomenTab({super.key});
  final WomenTabViewmodel _womenTabViewmodel = Get.put(WomenTabViewmodel());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (_womenTabViewmodel.productRes.value.status == Status.error) {
        showDialogError(error: _womenTabViewmodel.productRes.value.message!);
      }

      if (_womenTabViewmodel.productRes.value.status == Status.completed) {
        return Loadmore(
          refreshController: _womenTabViewmodel.refreshController,
          onLoading: _womenTabViewmodel.onLoading,
          onRefresh: _womenTabViewmodel.onRefresh,
          widget: MasonryGridView.count(
            padding: const EdgeInsets.all(16),
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 16,
            itemCount: _womenTabViewmodel.listProduct.length,
            itemBuilder: (context, index) {
              return ProductContainer(
                product: _womenTabViewmodel.listProduct[index],
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
