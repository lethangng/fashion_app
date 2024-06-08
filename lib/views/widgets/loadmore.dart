// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../utils/color_app.dart';
import '../../utils/text_themes.dart';

class Loadmore extends StatelessWidget {
  const Loadmore({
    super.key,
    required this.refreshController,
    this.onRefresh,
    this.onLoading,
    required this.widget,
  });

  final RefreshController refreshController;
  final void Function()? onRefresh;
  final void Function()? onLoading;
  final Widget widget;

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      controller: refreshController,
      enablePullDown: true,
      enablePullUp: true,
      physics: const BouncingScrollPhysics(),
      header: const MaterialClassicHeader(
        color: ColorApp.primary,
      ),
      footer: CustomFooter(
        builder: (BuildContext context, LoadStatus? mode) {
          Widget body;
          if (mode == LoadStatus.loading) {
            body = Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    color: ColorApp.primary,
                    strokeWidth: 2,
                  ),
                ),
                const SizedBox(width: 4),
                Text(
                  'Đang tải...',
                  style: TextThemes.text14_600.copyWith(
                    color: ColorApp.primary,
                  ),
                ),
              ],
            );
          } else if (mode == LoadStatus.failed) {
            body = Text(
              "Tải thất bại. Thử lại!",
              style: TextThemes.text14_600.copyWith(color: ColorApp.primary),
            );
          } else if (mode == LoadStatus.canLoading) {
            body = Text(
              "Kéo lên để tải thêm.",
              style: TextThemes.text14_600.copyWith(color: ColorApp.primary),
            );
          } else {
            body = Text(
              'Không còn dữ liệu.',
              style: TextThemes.text14_600.copyWith(color: ColorApp.primary),
            );
          }
          return SizedBox(
            height: 55,
            child: Center(child: body),
          );
        },
      ),
      onRefresh: onRefresh,
      onLoading: onLoading,
      child: widget,
    );
  }
}
