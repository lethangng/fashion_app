import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../app/routes.dart';
import '../../../services/response/api_status.dart';
import '../../../utils/color_app.dart';
import '../../../view_models/tab_view_models/bag_tab_view_models/address_viewmodel.dart';
import '../../widgets/address_container.dart';
import '../../widgets/show_dialog_error.dart';

class AddressView extends StatelessWidget {
  AddressView({super.key});
  final AddressController _addressViewModel = Get.put(AddressController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Địa chỉ nhận hàng',
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
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 50),
        child: FloatingActionButton(
          onPressed: () =>
              Get.toNamed(Routes.addAddress, arguments: {'address': null}),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
          backgroundColor: ColorApp.black,
          child: SvgPicture.asset(
            'assets/icons/add.svg',
            colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
            width: 20,
          ),
        ),
      ),
      body: Obx(() {
        if (_addressViewModel.deliveryAddressRes.value.status == Status.error) {
          showDialogError(
              error: _addressViewModel.deliveryAddressRes.value.message!);
        }

        if (_addressViewModel.deliveryAddressRes.value.status ==
            Status.completed) {
          return ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            itemCount: _addressViewModel.listData.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 24),
                child: AddressContainer(
                  address: _addressViewModel.listData[index],
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
      }),
    );
  }
}
