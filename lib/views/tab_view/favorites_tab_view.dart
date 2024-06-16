import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';

import '../../services/response/api_status.dart';
import '../../utils/color_app.dart';
import '../../view_models/tab_view_models/favorite_tab_viewmodel.dart';
import '../widgets/list_empty.dart';
import '../widgets/loadmore.dart';
import '../widgets/product_container.dart';
import '../widgets/show_dialog_error.dart';

class FavoritesTabView extends StatelessWidget {
  FavoritesTabView({super.key});
  final FavoriteTabViewmodel _favoriteTabViewmodel =
      Get.put(FavoriteTabViewmodel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      appBar: AppBar(
        backgroundColor: Colors.white,
        scrolledUnderElevation: 0,
        title: const Text(
          'Yêu thích',
          style: TextStyle(
            fontSize: 18,
            color: Color(0xFF222222),
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Obx(() {
        if (_favoriteTabViewmodel.favoritesRes.value.status == Status.error) {
          showDialogError(
              error: _favoriteTabViewmodel.favoritesRes.value.message!);
        }

        if (_favoriteTabViewmodel.favoritesRes.value.status ==
            Status.completed) {
          return Loadmore(
            refreshController: _favoriteTabViewmodel.refreshController,
            onLoading: _favoriteTabViewmodel.onLoading,
            onRefresh: _favoriteTabViewmodel.onRefresh,
            widget: _favoriteTabViewmodel.listFavorite.isEmpty
                ? const ListEmpty()
                : MasonryGridView.count(
                    padding: const EdgeInsets.all(16),
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 16,
                    itemCount: _favoriteTabViewmodel.listFavorite.length,
                    itemBuilder: (context, index) {
                      return ProductContainer(
                        product: _favoriteTabViewmodel.listFavorite[index],
                        productType: ProductType.favarite,
                        eventDelete: () =>
                            _favoriteTabViewmodel.handleLoadDeleteFavorite(
                          _favoriteTabViewmodel.listFavorite[index].id,
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
      }),
    );
  }

  // Widget chip({
  //   required String title,
  //   required event,
  // }) {
  //   return TextButton(
  //     onPressed: event,
  //     style: TextButton.styleFrom(
  //       shape: RoundedRectangleBorder(
  //         borderRadius: BorderRadius.circular(30),
  //       ),
  //       backgroundColor: const Color(0xFF222222),
  //       foregroundColor: Colors.white,
  //     ),
  //     child: Text(
  //       title,
  //       style: const TextStyle(
  //         fontSize: 14,
  //         fontWeight: FontWeight.w400,
  //       ),
  //     ),
  //   );
  // }
}
