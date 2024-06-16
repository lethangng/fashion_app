import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../services/response/api_status.dart';
import '../../../../utils/color_app.dart';
import '../../../../view_models/profile_view_models/history_tabs/delivered_tab_viewmodel.dart';
import '../../../widgets/history_container_item.dart';
import '../../../widgets/list_empty.dart';
import '../../../widgets/loadmore.dart';
import '../../../widgets/show_dialog_error.dart';

class DeliveredTab extends StatelessWidget {
  DeliveredTab({super.key});
  final DeliveredTabViewmodel _deliveredTabViewmodel =
      Get.find<DeliveredTabViewmodel>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (_deliveredTabViewmodel.orderRes.value.status == Status.error) {
        showDialogError(error: _deliveredTabViewmodel.orderRes.value.message!);
      }

      if (_deliveredTabViewmodel.orderRes.value.status == Status.completed) {
        return Loadmore(
          refreshController: _deliveredTabViewmodel.refreshController,
          onLoading: _deliveredTabViewmodel.onLoading,
          onRefresh: _deliveredTabViewmodel.onRefresh,
          widget: _deliveredTabViewmodel.listData.isEmpty
              ? const ListEmpty()
              : ListView.builder(
                  itemCount: _deliveredTabViewmodel.listData.length,
                  padding: const EdgeInsets.only(
                    left: 14,
                    right: 14,
                    top: 16,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 24),
                      child: HistoryContainerItem(
                        order: _deliveredTabViewmodel.listData[index],
                      ),
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
