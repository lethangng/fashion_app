import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../app/routes.dart';
import '../../../models/profile_models/order_detail.dart';
import '../../../services/response/api_status.dart';
import '../../../utils/color_app.dart';
import '../../../utils/helper.dart';
import '../../../utils/text_themes.dart';
import '../../../view_models/profile_view_models/order_detail_viewmodel.dart';
import '../../widgets/button_primary.dart';
import '../../widgets/button_second.dart';
import '../../widgets/order_product_item.dart';
import '../../widgets/show_dialog_error.dart';

class OrderDetailView extends StatelessWidget {
  OrderDetailView({super.key});
  final OrderDetailViewmodel _orderDetailViewmodel =
      Get.put(OrderDetailViewmodel());
  final TextEditingController _elaluatesConroller = TextEditingController();
  final TextEditingController _cancelElaluatesConroller =
      TextEditingController();
  final RxInt _countStar = 3.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: Colors.white,
        title: const Text(
          'Thông tin đơn hàng',
          style: TextStyle(
            color: Color(0xFF222222),
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: SvgPicture.asset('assets/icons/arrow-back.svg'),
        ),
      ),
      body: Obx(() {
        if (_orderDetailViewmodel.orderDetailRes.value.status == Status.error) {
          showDialogError(
              error: _orderDetailViewmodel.orderDetailRes.value.message!);
        }

        if (_orderDetailViewmodel.addEvaluatesRes.value.status ==
            Status.error) {
          showDialogError(
              error: _orderDetailViewmodel.addEvaluatesRes.value.message!);
        }

        if (_orderDetailViewmodel.updateStatusRes.value.status ==
            Status.error) {
          showDialogError(
              error: _orderDetailViewmodel.updateStatusRes.value.message!);
        }

        if (_orderDetailViewmodel.cancelOrderRes.value.status == Status.error) {
          showDialogError(
              error: _orderDetailViewmodel.cancelOrderRes.value.message!);
        }

        if (_orderDetailViewmodel.orderDetailRes.value.status ==
            Status.completed) {
          return RefreshIndicator(
            onRefresh: () => _orderDetailViewmodel.handleLoad(),
            color: ColorApp.primary,
            child: screen(),
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

  Widget screen() {
    OrderDetail orderDetail = _orderDetailViewmodel.orderDetailRes.value.data!;
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                rowInfo(
                  title: 'Mã đơn hàng: ',
                  value: '${orderDetail.order_info.id}',
                ),
                Text(
                  orderDetail.order_info.status_title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: orderTypeColor(orderDetail.order_info.status),
                  ),
                )
              ],
            ),
            const SizedBox(height: 18),
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: orderDetail.order_list.length,
              padding: EdgeInsets.zero,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 24),
                  child: OrderProductItem(
                    orderProduct: orderDetail.order_list[index],
                  ),
                );
              },
            ),
            Text(
              'Thông tin chi tiết',
              style: TextThemes.text_14_500,
            ),
            const SizedBox(height: 15),
            rowInfoDetail(
              title: 'Số lượng sản phẩm: ',
              value: orderDetail.order_info.count.toString(),
            ),
            const SizedBox(height: 24),
            rowInfoDetail(
              title: 'Địa chỉ giao hàng: ',
              value: orderDetail.order_info.delivery_address,
            ),
            const SizedBox(height: 24),
            rowInfoDetail(
              title: 'Giảm giá: ',
              value: Helper.formatMonney(orderDetail.order_info.price_off),
            ),
            const SizedBox(height: 24),
            rowInfoDetail(
                title: 'Thời gian đặt hàng: ',
                value: orderDetail.order_info.created_at),
            const SizedBox(height: 24),
            // rowInfoDetail(
            //     title: 'Thời gian thanh toán: ', value: '06-03-2024 16:20'),
            // const SizedBox(height: 24),
            rowInfoDetail(
              title: 'Tổng thanh toán: ',
              value: Helper.formatMonney(orderDetail.order_info.total_price),
            ),
            const SizedBox(height: 30),
            Row(
              children: [
                Expanded(
                  child: ButtonSecond(
                    title: 'Mua lại',
                    event: () => Get.toNamed(
                      Routes.productDetail,
                      arguments: {
                        'productId': orderDetail.order_list.first.product_id
                      },
                    ),
                  ),
                ),
                Visibility(
                  visible: orderDetail.order_info.status == 0 ||
                      orderDetail.order_info.status == 3 ||
                      (orderDetail.order_info.status == 4 &&
                          orderDetail.order_info.is_evaluate == 0),
                  child: const SizedBox(width: 20),
                ),
                handleButton(
                  status: orderDetail.order_info.status,
                  isEvaluate: orderDetail.order_info.is_evaluate,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget handleButton({required int status, required int isEvaluate}) {
    if (status == 0) {
      return Expanded(
        child: ButtonPrimary(
          title: 'Hủy đơn',
          event: () {
            handleShow();
          },
        ),
      );
    } else if (status == 3) {
      return Expanded(
        child: ButtonPrimary(
          title: 'Đã nhận được hàng',
          event: () {
            _orderDetailViewmodel.handleUpdateStatus();
          },
        ),
      );
    } else if (status == 4 && isEvaluate == 0) {
      return Expanded(
        child: ButtonPrimary(
          title: 'Đánh giá',
          event: () {
            onWriteReview();
          },
        ),
      );
    } else {
      return const SizedBox();
    }
  }

  void handleShow() {
    Get.dialog(
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              decoration: const BoxDecoration(
                color: ColorApp.background,
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              child: Material(
                color: Colors.transparent,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                            onPressed: () => Get.back(),
                            style: IconButton.styleFrom(
                              minimumSize: Size.zero,
                              padding: EdgeInsets.zero,
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                            icon: SvgPicture.asset(
                              'assets/icons/close.svg',
                            ),
                          ),
                        ],
                      ),
                      SvgPicture.asset(
                        'assets/icons/sad-icon.svg',
                        height: Get.height * 0.3,
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        'Bạn chắc chắn muốn hủy đơn chứ ?',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        height: Get.height * 0.2,
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: ColorApp.white,
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFF000000).withOpacity(0.05),
                              offset: const Offset(0, 1),
                              blurRadius: 8,
                            ),
                          ],
                        ),
                        child: TextField(
                          controller: _cancelElaluatesConroller,
                          style: const TextStyle(color: Colors.black),
                          onTapOutside: (event) =>
                              FocusManager.instance.primaryFocus?.unfocus(),
                          textAlignVertical: TextAlignVertical.center,
                          textAlign: TextAlign.left,
                          maxLines: null,
                          keyboardType: TextInputType.multiline,
                          decoration: InputDecoration(
                            isDense: true, // Cho chu can giua theo chieu doc
                            hintText: 'Nhập lý do...',
                            hintStyle: const TextStyle(
                              color: ColorApp.colorGrey2,
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: Get.width * 0.01,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            child: ButtonPrimary(
                              title: 'Quay lại',
                              event: () => Get.back(),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: ButtonSecond(
                              title: 'Đồng ý',
                              event: () {
                                if (_cancelElaluatesConroller.text.isEmpty) {
                                  Get.snackbar(
                                    'Thông báo',
                                    'Vui lòng nhập lý do hủy đơn',
                                    colorText: Colors.white,
                                    backgroundColor: Colors.black87,
                                  );
                                  return;
                                }
                                Get.back();
                                _orderDetailViewmodel.handleCancelOrderRes(
                                  _cancelElaluatesConroller.text,
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      barrierDismissible: false,
    );
  }

  void onWriteReview() {
    Get.bottomSheet(
      isScrollControlled: true, // Cho chieu cao cua bottomSheet tu dong
      backgroundColor: ColorApp.background,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      Container(
        // height: Get.height * 0.8,
        padding: const EdgeInsets.symmetric(horizontal: 16),
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
            const SizedBox(height: 16),
            const Text(
              'Bạn đánh giá mấy sao?',
              style: TextStyle(
                color: Color(0xFF222222),
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 16),
            RatingBar.builder(
              initialRating: 3,
              minRating: 1,
              direction: Axis.horizontal,
              // allowHalfRating: true,
              itemCount: 5,
              itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
              itemBuilder: (context, _) => const Icon(
                Icons.star,
                color: Colors.amber,
              ),
              onRatingUpdate: (rating) {
                // print(rating);
                _countStar.value = rating.round();
              },
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: Get.width * 0.7,
              child: const Text(
                'Tiếp theo hãy chia sẻ cảm nhận của bạn về sản phẩm',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: ColorApp.black),
              ),
            ),
            const SizedBox(height: 10),
            Container(
              height: Get.height * 0.2,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: ColorApp.white,
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF000000).withOpacity(0.05),
                    offset: const Offset(0, 1),
                    blurRadius: 8,
                  ),
                ],
              ),
              child: TextField(
                controller: _elaluatesConroller,
                style: const TextStyle(color: Colors.black),
                onTapOutside: (event) =>
                    FocusManager.instance.primaryFocus?.unfocus(),
                textAlignVertical: TextAlignVertical.center,
                textAlign: TextAlign.left,
                maxLines: null,
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(
                  isDense: true, // Cho chu can giua theo chieu doc
                  hintText: 'Đánh giá của bạn',
                  hintStyle: const TextStyle(
                    color: ColorApp.colorGrey2,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: Get.width * 0.01,
                  ),
                ),
              ),
            ),
            // const SizedBox(height: 20),
            // Row(
            //   children: [
            //     Container(
            //       width: 104,
            //       height: 104,
            //       alignment: Alignment.center,
            //       decoration: BoxDecoration(
            //         shape: BoxShape.rectangle,
            //         boxShadow: [
            //           BoxShadow(
            //             color: const Color(0xFF000000).withOpacity(0.16),
            //             blurRadius: 16,
            //             offset: const Offset(0, 1),
            //           )
            //         ],
            //         color: ColorApp.white,
            //         borderRadius: BorderRadius.circular(4),
            //       ),
            //       child: Column(
            //         mainAxisSize: MainAxisSize.min,
            //         children: [
            //           Container(
            //             alignment: Alignment.center,
            //             width: 52,
            //             height: 52,
            //             decoration: const BoxDecoration(
            //               shape: BoxShape.circle,
            //               color: ColorApp.primary,
            //             ),
            //             child: SvgPicture.asset('assets/icons/picture.svg'),
            //           ),
            //           const Text(
            //             'Thêm ảnh',
            //             style: TextStyle(
            //               fontSize: 11,
            //               fontWeight: FontWeight.w700,
            //               color: ColorApp.black,
            //             ),
            //           )
            //         ],
            //       ),
            //     )
            //   ],
            // ),
            const SizedBox(height: 20),
            ButtonPrimary(
              title: 'Gửi đánh giá',
              event: () async {
                Get.back();
                await _orderDetailViewmodel.handleAddEvaluatesRes(
                  starNumber: _countStar.value,
                  content: _elaluatesConroller.text,
                );
                await _orderDetailViewmodel.handleLoad();
              },
            ),

            SizedBox(height: Get.height * 0.1),
          ],
        ),
      ),
    );
  }

  Color orderTypeColor(int status) {
    if (status == 5) {
      return ColorApp.primary;
    } else if (status == 4) {
      return ColorApp.success;
    } else {
      return ColorApp.origin;
    }
  }

  Widget button({
    required String title,
    required bool isOutlineButton,
    void Function()? event,
  }) {
    return OutlinedButton(
      onPressed: event,
      style: OutlinedButton.styleFrom(
        side: const BorderSide(color: ColorApp.black),
      ),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: ColorApp.black,
        ),
      ),
    );
  }

  Widget rowInfo({
    required String title,
    required String value,
  }) {
    return RichText(
      text: TextSpan(
        text: title,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: ColorApp.gray,
        ),
        children: [
          TextSpan(
            text: value,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              color: ColorApp.black,
            ),
          )
        ],
      ),
    );
  }

  Widget rowInfoDetail({
    required String title,
    required String value,
  }) {
    return Row(
      children: [
        SizedBox(
          width: Get.width * 0.4,
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: ColorApp.gray,
            ),
          ),
        ),
        Flexible(
          child: Text(
            value,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: ColorApp.black,
            ),
          ),
        )
      ],
    );
  }
}
