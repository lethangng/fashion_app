import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../services/response/api_status.dart';
import '../../../../utils/color_app.dart';
import '../../../../view_models/profile_view_models/history_tabs/processing_tab_viewmodel.dart';
import '../../../widgets/history_container_item.dart';
import '../../../widgets/list_empty.dart';
import '../../../widgets/loadmore.dart';
import '../../../widgets/show_dialog_error.dart';

class ProcessingTab extends StatelessWidget {
  ProcessingTab({super.key});
  final ProcessingTabViewmodel _processingTabViewmodel =
      Get.find<ProcessingTabViewmodel>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (_processingTabViewmodel.orderRes.value.status == Status.error) {
        showDialogError(error: _processingTabViewmodel.orderRes.value.message!);
      }

      if (_processingTabViewmodel.orderRes.value.status == Status.completed) {
        return Loadmore(
          refreshController: _processingTabViewmodel.refreshController,
          onLoading: _processingTabViewmodel.onLoading,
          onRefresh: _processingTabViewmodel.onRefresh,
          widget: _processingTabViewmodel.listData.isEmpty
              ? const ListEmpty()
              : ListView.builder(
                  itemCount: _processingTabViewmodel.listData.length,
                  padding: const EdgeInsets.only(
                    left: 14,
                    right: 14,
                    top: 16,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 24),
                      child: HistoryContainerItem(
                        order: _processingTabViewmodel.listData[index],
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
