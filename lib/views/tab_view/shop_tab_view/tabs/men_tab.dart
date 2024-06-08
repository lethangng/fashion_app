import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';

import '../../../../services/response/api_status.dart';
import '../../../../utils/color_app.dart';
import '../../../../view_models/tab_view_models/shop_tab_view_models/tabs/men_tab_viewmodel.dart';
import '../../../widgets/loadmore.dart';
import '../../../widgets/product_container.dart';
import '../../../widgets/show_dialog_error.dart';

class MenTab extends StatelessWidget {
  MenTab({super.key});

  final MenTabViewmodel _menTabViewmodel = Get.put(MenTabViewmodel());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (_menTabViewmodel.productRes.value.status == Status.error) {
        showDialogError(error: _menTabViewmodel.productRes.value.message!);
      }

      if (_menTabViewmodel.productRes.value.status == Status.completed) {
        return Loadmore(
          refreshController: _menTabViewmodel.refreshController,
          onLoading: _menTabViewmodel.onLoading,
          onRefresh: _menTabViewmodel.onRefresh,
          widget: MasonryGridView.count(
            padding: const EdgeInsets.all(16),
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 16,
            itemCount: _menTabViewmodel.listProduct.length,
            itemBuilder: (context, index) {
              return ProductContainer(
                product: _menTabViewmodel.listProduct[index],
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
