import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../models/home_models/delivery_address.dart';
import '../../../services/response/api_status.dart';
import '../../../utils/color_app.dart';
import '../../../view_models/tab_view_models/bag_tab_view_models/address_viewmodel.dart';
import '../../../view_models/tab_view_models/bag_tab_view_models/edit_address_viewmodel.dart';
import '../../widgets/button_primary.dart';
import '../../widgets/show_dialog_error.dart';

class EditAddressView extends StatelessWidget {
  EditAddressView({super.key});
  final AddressController _addressViewmodel = Get.find<AddressController>();
  final EditAddressViewmodel _editAddressViewmodel =
      Get.put(EditAddressViewmodel());
  final TextEditingController _fullnameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    if (_editAddressViewmodel.address != null) {
      DeliveryAddress address = _editAddressViewmodel.address!;
      _fullnameController.text = address.fullname;
      _phoneController.text = address.phone_number;
      _addressController.text = address.address;
    }

    return Scaffold(
      backgroundColor: ColorApp.background,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          '${_editAddressViewmodel.title} địa chỉ',
          style: const TextStyle(
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
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              const SizedBox(height: 16),
              inputContainer(
                textHind: 'Họ và tên',
                controller: _fullnameController,
              ),
              const SizedBox(height: 20),
              inputContainer(
                textHind: 'Số điện thoại',
                controller: _phoneController,
              ),
              // const SizedBox(height: 20),
              // inputContainer(
              //   textHind: 'Tỉnh/Thành phố',
              //   controller: _cityController,
              // ),
              const SizedBox(height: 20),
              inputContainer(
                textHind: 'Địa chỉ cụ thể',
                controller: _addressController,
              ),
              // const Spacer(),
              const SizedBox(height: 40),
              Obx(
                () {
                  if (_addressViewmodel.addAddressRes.value.status ==
                      Status.error) {
                    showDialogError(
                        error: _addressViewmodel.addAddressRes.value.message!);
                  }
                  if (_addressViewmodel.updateAddressRes.value.status ==
                      Status.error) {
                    showDialogError(
                        error:
                            _addressViewmodel.updateAddressRes.value.message!);
                  }

                  if (_addressViewmodel.addAddressRes.value.status ==
                          Status.completed &&
                      _addressViewmodel.updateAddressRes.value.status ==
                          Status.completed) {
                    return ButtonPrimary(
                      title: 'Lưu địa chỉ',
                      event: () async {
                        if (_editAddressViewmodel.address == null) {
                          await _addressViewmodel.handleLoadAddAddress(
                            fullname: _fullnameController.text,
                            phoneNumber: _phoneController.text,
                            address: _addressController.text,
                          );
                        } else {
                          DeliveryAddress deliveryAddress =
                              _editAddressViewmodel.address!;

                          deliveryAddress.fullname = _fullnameController.text;
                          deliveryAddress.phone_number = _phoneController.text;
                          deliveryAddress.address = _addressController.text;

                          await _addressViewmodel.handleLoadUpdateAddredd(
                            address: _editAddressViewmodel.address!,
                            isSelect: deliveryAddress.is_select,
                          );
                        }
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
              // const SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }

  Widget inputContainer({
    required String textHind,
    required TextEditingController controller,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 15,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4),
        boxShadow: [
          BoxShadow(
            blurRadius: 8,
            offset: const Offset(0, 1),
            color: const Color(0xFF000000).withOpacity(0.05),
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        onTapOutside: (event) => FocusManager.instance.primaryFocus?.unfocus(),
        textAlignVertical: TextAlignVertical.center,
        textAlign: TextAlign.left,
        decoration: InputDecoration(
          labelText: textHind,
          labelStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: ColorApp.gray,
          ),
          isDense: true, // Cho chu can giua theo chieu doc
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(
            horizontal: Get.width * 0.01,
          ),
        ),
      ),
    );
  }
}
