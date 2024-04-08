import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../app/routes.dart';
import '../../../utils/color_app.dart';
import '../../../view_models/tab_view_models/shop_tab_models/search_view_model.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({super.key});

  final SearchViewModel searchViewModel = Get.find<SearchViewModel>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      appBar: AppBar(
        elevation: 0,
        titleSpacing: 0,
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
            controller: searchViewModel.searchController,
            // focusNode: searchViewViewModel.focus,
            cursorColor: ColorApp.black,
            style: const TextStyle(color: ColorApp.black),
            textAlignVertical: TextAlignVertical.center,
            textAlign: TextAlign.left,
            decoration: InputDecoration(
              isDense: true, // Cho chu can giua theo chieu doc
              hintText: 'Tìm kiếm',
              hintStyle: const TextStyle(
                color: ColorApp.colorGrey2,
                fontSize: 15,
                fontWeight: FontWeight.w400,
              ),
              border: InputBorder.none,
              suffixIcon: IconButton(
                onPressed: () => Get.toNamed(Routes.categryDetail),
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
            onSubmitted: (_) => Get.toNamed(Routes.categryDetail),
          ),
        ),
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: SvgPicture.asset('assets/icons/arrow-back.svg'),
        ),
      ),
      body: Padding(
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
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                chip(title: 'Áo sơ mi', event: () {}),
                chip(title: 'Quần jean', event: () {}),
                chip(title: 'Áo khoác gió nam', event: () {}),
              ],
            ),
            const SizedBox(height: 20),
            const Text(
              'Các tìm kiếm phổ biến',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: ColorApp.black,
              ),
            ),
            const SizedBox(height: 12),
            ...searchViewModel.listSearch.map(
              (item) => Padding(
                padding: const EdgeInsets.only(bottom: 15),
                child: GestureDetector(
                  onTap: () {
                    // print('ok');
                  },
                  child: Text(
                    item,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      color: ColorApp.black,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget chip({
    required String title,
    required void Function()? event,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(33),
        color: ColorApp.black,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w400,
              color: Colors.white,
            ),
          ),
          const SizedBox(width: 3),
          IconButton(
            onPressed: event,
            style: IconButton.styleFrom(
              minimumSize: Size.zero,
              padding: EdgeInsets.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            icon: SvgPicture.asset(
              'assets/icons/close-2.svg',
            ),
          )
        ],
      ),
    );
  }
}
