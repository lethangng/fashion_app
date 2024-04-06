import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../app/routes.dart';
import '../../../models/bag_models/address_model.dart';
import '../../../utils/color_app.dart';
import '../../../view_models/tab_view_models/bag_tab_models/address_view_model.dart';

class AddressView extends StatelessWidget {
  AddressView({super.key});
  final AddressViewModel addressViewModel = Get.put(AddressViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Địa chỉ',
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
          onPressed: () => Get.toNamed(Routes.addAddress),
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
      body: Obx(
        () => ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          itemCount: addressViewModel.listDataAddress.length,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 24),
              child: addressContainer(
                address: addressViewModel.listDataAddress[index],
                event: () {},
              ),
            );
          },
        ),
      ),
    );
  }

  Widget addressContainer({
    required AddressModel address,
    void Function()? event,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 28,
        vertical: 18,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            blurRadius: 25,
            offset: const Offset(0, 1),
            color: const Color(0xFF000000).withOpacity(0.08),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  address.name,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: ColorApp.black,
                  ),
                ),
                const SizedBox(height: 7),
                RichText(
                  text: TextSpan(
                    text: address.address,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: ColorApp.black,
                    ),
                    children: [TextSpan(text: address.city)],
                  ),
                ),
                const SizedBox(height: 14),
                Row(
                  children: [
                    SizedBox(
                      width: 20,
                      height: 20,
                      child: Checkbox(
                        value: address.isDefault,
                        activeColor: ColorApp.black,
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        onChanged: (value) =>
                            addressViewModel.onSelectAddress(address.id),
                      ),
                    ),
                    const SizedBox(width: 13),
                    const Text(
                      'Sử dụng làm địa chỉ mặc định',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: ColorApp.black,
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
          TextButton(
            onPressed: () {},
            style: TextButton.styleFrom(
              minimumSize: Size.zero,
              padding: EdgeInsets.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              foregroundColor: ColorApp.primary,
            ),
            child: const Text(
              'Sửa',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
