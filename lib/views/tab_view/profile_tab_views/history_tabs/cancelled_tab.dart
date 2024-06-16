import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../services/response/api_status.dart';
import '../../../../utils/color_app.dart';
import '../../../../view_models/profile_view_models/history_tabs/cancelled_tab_viewmodel.dart';
import '../../../widgets/history_container_item.dart';
import '../../../widgets/list_empty.dart';
import '../../../widgets/loadmore.dart';
import '../../../widgets/show_dialog_error.dart';

class CancelledTab extends StatelessWidget {
  CancelledTab({super.key});
  final CancelledTabViewmodel _cancelledTabViewmodel =
      Get.find<CancelledTabViewmodel>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (_cancelledTabViewmodel.orderRes.value.status == Status.error) {
        showDialogError(error: _cancelledTabViewmodel.orderRes.value.message!);
      }

      if (_cancelledTabViewmodel.orderRes.value.status == Status.completed) {
        return Loadmore(
          refreshController: _cancelledTabViewmodel.refreshController,
          onLoading: _cancelledTabViewmodel.onLoading,
          onRefresh: _cancelledTabViewmodel.onRefresh,
          widget: _cancelledTabViewmodel.listData.isEmpty
              ? const ListEmpty()
              : ListView.builder(
                  itemCount: _cancelledTabViewmodel.listData.length,
                  padding: const EdgeInsets.only(
                    left: 14,
                    right: 14,
                    top: 16,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 24),
                      child: HistoryContainerItem(
                        order: _cancelledTabViewmodel.listData[index],
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
