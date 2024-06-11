import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../services/response/api_status.dart';
import '../../../utils/color_app.dart';
import '../../../utils/helper.dart';
import '../../../view_models/tab_view_models/bag_tab_view_models/bag_tab_viewmodel.dart';
import '../../../view_models/tab_view_models/bag_tab_view_models/pay_viewmodel.dart';
import '../../widgets/address_container.dart';
import '../../widgets/button_primary.dart';
import '../../widgets/product_bag_container.dart';
import '../../widgets/show_dialog_error.dart';

class PayView extends StatelessWidget {
  PayView({super.key});
  final PayController _payViewModel = Get.put(PayController());
  final BagTabViewmodel _bagTabViewModel = Get.find<BagTabViewmodel>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorApp.background,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: Colors.white,
        title: const Text(
          'Thanh toán',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: ColorApp.black,
          ),
        ),
        centerTitle: true,
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
              const SizedBox(height: 15),
              const Text(
                'Địa chỉ giao hàng',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: ColorApp.black,
                ),
              ),
              const SizedBox(height: 20),
              Obx(() {
                if (_payViewModel.deliveryAddressRes.value.status ==
                    Status.error) {
                  showDialogError(
                      error: _payViewModel.deliveryAddressRes.value.message!);
                }

                if (_payViewModel.deliveryAddressRes.value.status ==
                    Status.completed) {
                  return AddressContainer(
                    address: _payViewModel.deliveryAddressRes.value.data!,
                    event: () {},
                    addressType: AddressType.pay,
                  );
                }
                return const Center(
                  child: CircularProgressIndicator(
                    color: ColorApp.primary,
                  ),
                );
              }),
              const SizedBox(height: 20),
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: _bagTabViewModel.listCart.length,
                padding: EdgeInsets.zero,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 24),
                    child: ProductBagContainer(
                      cart: _bagTabViewModel.listCart[index],
                      isPay: true,
                    ),
                  );
                },
              ),
              const SizedBox(height: 20),
              const Text(
                'Chi tiết thanh toán',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 10),
              rowInfo(
                title: 'Tổng tiền hàng',
                monney: _bagTabViewModel.totalPriceValue,
              ),
              const SizedBox(height: 20),
              rowInfo(
                title: 'Giảm giá',
                monney: _bagTabViewModel.discount.value,
              ),
              const SizedBox(height: 20),
              rowInfo(
                title: 'Phí vận chuyển',
                monney: 0,
              ),
              const SizedBox(height: 20),
              rowInfo(
                title: 'Tổng thanh toán',
                monney: _bagTabViewModel.totalPrice.value,
              ),
              const SizedBox(height: 23),
              Obx(
                () {
                  if (_payViewModel.addOrderRes.value.status == Status.error) {
                    showDialogError(
                      error: _payViewModel.addOrderRes.value.message!,
                    );
                  }

                  if (_payViewModel.addOrderRes.value.status ==
                      Status.completed) {
                    return ButtonPrimary(
                      title: 'Đặt hàng',
                      event: () => _payViewModel.handleLoadAddOrder(),
                      fontSize: 16,
                    );
                  }
                  return const Center(
                    child: CircularProgressIndicator(
                      color: ColorApp.primary,
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget rowInfo({
    required String title,
    required int monney,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: ColorApp.black,
          ),
        ),
        Text(
          Helper.formatMonney(monney),
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: ColorApp.primary,
          ),
        )
      ],
    );
  }
}
