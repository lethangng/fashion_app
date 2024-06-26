import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../utils/color_app.dart';
import '../../../view_models/profile_view_models/history_viewmodel.dart';
import 'history_tabs/cancelled_tab.dart';
import 'history_tabs/delivered_tab.dart';
import 'history_tabs/processing_tab.dart';

class HistoryView extends StatelessWidget {
  HistoryView({super.key});
  final HistoryViewModel _historyViewModel = Get.put(HistoryViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        // actions: [
        //   IconButton(
        //     onPressed: () {},
        //     icon: SvgPicture.asset('assets/icons/search.svg'),
        //   ),
        // ],
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: SvgPicture.asset('assets/icons/arrow-back.svg'),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 18),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 14),
            child: Text(
              'Lịch sử mua hàng',
              style: TextStyle(
                fontSize: 34,
                fontWeight: FontWeight.bold,
                color: ColorApp.black,
              ),
            ),
          ),
          const SizedBox(height: 24),
          Container(
            decoration: const BoxDecoration(color: Color(0xFFFFFFFF)),
            child: TabBar(
              controller: _historyViewModel.tabController,
              isScrollable: false,
              tabs: _historyViewModel.listTap,
              physics: const BouncingScrollPhysics(),
              labelColor: const Color(0xFFDB3022),
              dividerColor: Colors.transparent,
              indicatorSize: TabBarIndicatorSize.tab,
              indicatorColor: const Color(0xFFDB3022),
              unselectedLabelColor: Colors.black,
              labelStyle: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _historyViewModel.tabController,
              children: [
                DeliveredTab(),
                ProcessingTab(),
                CancelledTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
