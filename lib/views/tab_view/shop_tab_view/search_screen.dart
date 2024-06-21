import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../app/routes.dart';
import '../../../models/home_models/search_history.dart';
import '../../../utils/color_app.dart';
import '../../../view_models/tab_view_models/shop_tab_view_models/search_view_viewmodel.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({super.key});
  final SearchViewViewmodel _searchViewModel = Get.put(SearchViewViewmodel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      appBar: AppBar(
        elevation: 0,
        titleSpacing: 0,
        scrolledUnderElevation: 0,
        backgroundColor: Colors.transparent,
        title: Container(
          margin: const EdgeInsets.only(right: 16),
          padding: EdgeInsets.only(left: Get.width * 0.05, right: 10),
          // padding: EdgeInsets.zero,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(57),
            boxShadow: [
              BoxShadow(
                blurRadius: 8,
                offset: const Offset(0, 4),
                color: const Color(0xFF000000).withOpacity(0.08),
              )
            ],
          ),
          child: TextField(
            controller: _searchViewModel.searchController,
            onTapOutside: (event) =>
                FocusManager.instance.primaryFocus?.unfocus(),
            cursorColor: ColorApp.black,
            style: const TextStyle(color: ColorApp.black),
            textAlignVertical: TextAlignVertical.center,
            textAlign: TextAlign.left,
            decoration: InputDecoration(
              isDense: true, // Cho chu can giua theo chieu doc
              hintText: 'Tìm kiếm...',
              hintStyle: const TextStyle(
                color: ColorApp.colorGrey2,
                fontSize: 15,
                fontWeight: FontWeight.w400,
              ),
              border: InputBorder.none,
              suffixIcon: IconButton(
                onPressed: () async {
                  if (_searchViewModel.searchController.text.isNotEmpty) {
                    await _searchViewModel.insert();
                    Get.toNamed(Routes.categryDetail);
                  }
                },
                style: IconButton.styleFrom(
                  minimumSize: Size.zero,
                  padding: EdgeInsets.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                icon: Container(
                  width: 24,
                  alignment: Alignment.center,
                  child: SvgPicture.asset(
                    'assets/icons/search-icon.svg',
                    width: 24,
                  ),
                ),
              ),
            ),
            // onSubmitted: (_) {
            //   if (_searchViewModel.searchController.text.isNotEmpty) {
            //     Get.toNamed(Routes.categryDetail);
            //   }
            // },
          ),
        ),
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: SvgPicture.asset('assets/icons/arrow-back.svg'),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              const Text(
                'Gần đây',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: ColorApp.black,
                ),
              ),
              const SizedBox(height: 12),
              Obx(
                () => ListView.builder(
                  itemCount: _searchViewModel.listSearchHistory.length,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    return chip(_searchViewModel.listSearchHistory[index]);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // padding: const EdgeInsets.symmetric(vertical: 10),
  Widget chip(SearchHistory searchHistory) {
    return GestureDetector(
      onTap: () {
        _searchViewModel.searchController.text = searchHistory.content;
        Get.toNamed(Routes.categryDetail);
      },
      child: Container(
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(
              width: 1,
              color: Colors.grey,
            ),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  searchHistory.content,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(width: 5),
              IconButton(
                onPressed: () => _searchViewModel.delete(searchHistory.id!),
                style: IconButton.styleFrom(
                  minimumSize: Size.zero,
                  padding: EdgeInsets.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                icon: const Icon(Icons.close),
              )
            ],
          ),
        ),
      ),
    );
  }
}
