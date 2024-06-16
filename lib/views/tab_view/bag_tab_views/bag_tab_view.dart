import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../app/routes.dart';
import '../../../models/home_models/coupon.dart';
import '../../../services/response/api_status.dart';
import '../../../utils/color_app.dart';
import '../../../utils/helper.dart';
import '../../../view_models/tab_view_models/bag_tab_view_models/bag_tab_viewmodel.dart';
import '../../widgets/discount_code_item.dart';
import '../../widgets/list_empty.dart';
import '../../widgets/loadmore.dart';
import '../../widgets/product_bag_container.dart';
import '../../widgets/show_dialog_error.dart';

class BagTabView extends StatelessWidget {
  BagTabView({super.key});
  final BagTabViewmodel _bagTabViewModel = Get.put(BagTabViewmodel());

  final TextEditingController discountCodeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // final height = MediaQuery.of(context).viewPadding.top;
    final appBarHeight = AppBar().preferredSize.height;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // SizedBox(height: appBarHeight),
          // const Text(
          //   'Giỏ hàng',
          //   style: TextStyle(
          //     fontSize: 34,
          //     fontWeight: FontWeight.w700,
          //     color: ColorApp.black,
          //   ),
          // ),
          // const SizedBox(height: 10),
          Expanded(
            child: Obx(
              () {
                if (_bagTabViewModel.cartRes.value.status == Status.error) {
                  showDialogError(
                      error: _bagTabViewModel.cartRes.value.message!);
                }

                if (_bagTabViewModel.cartRes.value.status == Status.completed) {
                  return Loadmore(
                    refreshController: _bagTabViewModel.refreshController,
                    onLoading: _bagTabViewModel.onLoading,
                    onRefresh: _bagTabViewModel.onRefresh,
                    widget: _bagTabViewModel.listCart.isEmpty
                        ? const ListEmpty(
                            title: 'Chưa có sản phẩm nào trong giỏ hàng',
                          )
                        : ListView.builder(
                            itemCount: _bagTabViewModel.listCart.length,
                            padding: EdgeInsets.only(top: appBarHeight),
                            itemBuilder: (BuildContext context, int index) {
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 24),
                                child: ProductBagContainer(
                                  cart: _bagTabViewModel.listCart[index],
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
              },
            ),
          ),
          const SizedBox(height: 16),
          GestureDetector(
            onTap: () {
              _bagTabViewModel.onRefreshCoupon();
              onShowSelectDiscountCode();
              discountCodeController.clear();
            },
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    width: Get.width,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 8,
                          offset: const Offset(0, 1),
                          color: const Color(0xFF000000).withOpacity(0.05),
                        ),
                      ],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Obx(
                      () {
                        Coupon? coupon = _bagTabViewModel.selectCoupon.value;
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 13,
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(coupon == null
                                    ? 'Chọn mã giảm giá'
                                    : 'Đã áp dụng mã: ${coupon.name}'),
                              ),
                              Visibility(
                                visible: coupon != null,
                                child: IconButton(
                                  onPressed: () =>
                                      _bagTabViewModel.handleSetCoupon(null),
                                  style: IconButton.styleFrom(
                                    minimumSize: Size.zero,
                                    padding: EdgeInsets.zero,
                                    tapTargetSize:
                                        MaterialTapTargetSize.shrinkWrap,
                                  ),
                                  icon: const Icon(Icons.close),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  width: 36,
                  height: 36,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: ColorApp.black,
                  ),
                  child: SvgPicture.asset('assets/icons/arrow-right.svg'),
                )
              ],
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Giảm giá:',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: ColorApp.black,
                ),
              ),
              Obx(
                () => Text(
                  '-${Helper.formatMonney(_bagTabViewModel.discount.value)}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: ColorApp.primary,
                  ),
                ),
              )
            ],
          ),
          const SizedBox(height: 14),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Tổng:',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: ColorApp.black,
                ),
              ),
              Obx(
                () => Text(
                  Helper.formatMonney(_bagTabViewModel.totalPrice.value),
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: ColorApp.primary,
                  ),
                ),
              )
            ],
          ),

          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: () => Get.toNamed(Routes.pay),
              style: OutlinedButton.styleFrom(
                side: const BorderSide(
                  width: 0,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                foregroundColor: Colors.white,
                backgroundColor: const Color(0xFFDB3022),
                padding: const EdgeInsets.symmetric(vertical: 15),
              ),
              child: const Text(
                'Mua hàng',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  void onShowSelectDiscountCode() {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 10),
            Container(
              width: Get.width * 0.2,
              height: 5,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: const Color(0xFF979797),
              ),
            ),
            // const SizedBox(height: 32),
            // Row(
            //   children: [
            //     Expanded(
            //       child: Container(
            //         width: Get.width,
            //         decoration: BoxDecoration(
            //           color: Colors.white,
            //           boxShadow: [
            //             BoxShadow(
            //               blurRadius: 8,
            //               offset: const Offset(0, 1),
            //               color: const Color(0xFF000000).withOpacity(0.05),
            //             ),
            //           ],
            //           borderRadius: BorderRadius.circular(8),
            //         ),
            //         child: TextField(
            //           controller: discountCodeController,
            //           style: const TextStyle(
            //             color: ColorApp.black,
            //           ),
            //           onTap: () {},
            //           textAlignVertical: TextAlignVertical.center,
            //           textAlign: TextAlign.left,
            //           decoration: const InputDecoration(
            //             isDense: true, // Cho chu can giua theo chieu doc
            //             hintText: 'Nhập mã giảm giá',
            //             hintStyle: TextStyle(
            //               color: ColorApp.colorGrey2,
            //               fontSize: 14,
            //               fontWeight: FontWeight.w400,
            //             ),
            //             border: InputBorder.none,
            //             contentPadding: EdgeInsets.symmetric(
            //               horizontal: 20,
            //               vertical: 12,
            //             ),
            //           ),
            //         ),
            //       ),
            //     ),
            //     const SizedBox(width: 8),
            //     Container(
            //       width: 36,
            //       height: 36,
            //       decoration: const BoxDecoration(
            //         shape: BoxShape.circle,
            //         color: ColorApp.black,
            //       ),
            //       child: IconButton(
            //         onPressed: () {},
            //         icon: SvgPicture.asset('assets/icons/arrow-right.svg'),
            //       ),
            //     )
            //   ],
            // ),
            const SizedBox(height: 15),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Mã giảm giá của bạn',
                style: TextStyle(
                  color: Color(0xFF222222),
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: Obx(
                () {
                  if (_bagTabViewModel.couponRes.value.status == Status.error) {
                    showDialogError(
                        error: _bagTabViewModel.couponRes.value.message!);
                  }

                  if (_bagTabViewModel.couponRes.value.status ==
                      Status.completed) {
                    return _bagTabViewModel.listCoupon.isEmpty
                        ? const Center(
                            child: Text(
                              'Không có mã giảm giá nào',
                              style: TextStyle(
                                color: ColorApp.black,
                                fontSize: 16,
                              ),
                            ),
                          )
                        : ListView.builder(
                            itemCount: _bagTabViewModel.listCoupon.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 24),
                                child: DiscountCodeItem(
                                  coupon: _bagTabViewModel.listCoupon[index],
                                  event: () {
                                    _bagTabViewModel.handleSetCoupon(
                                        _bagTabViewModel.listCoupon[index]);
                                    Get.back();
                                  },
                                ),
                              );
                            },
                          );
                  }
                  return const Center(
                    child: CircularProgressIndicator(
                      color: ColorApp.primary,
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
      backgroundColor: ColorApp.background,
    );
  }
}
