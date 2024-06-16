import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

// import '../../../app/routes.dart';
import '../../../models/request/user.dart';
import '../../../services/response/api_status.dart';
import '../../../utils/color_app.dart';
import '../../../view_models/controllers/user_controller.dart';
import '../../../view_models/profile_view_models/setting_viewmodel.dart';
import '../../widgets/avatar_container.dart';
import '../../widgets/button_primary.dart';
import '../../widgets/show_dialog_error.dart';

class SettingView extends StatelessWidget {
  SettingView({super.key});
  final SettingViewmodel _settingViewmodel = Get.put(SettingViewmodel());
  final UserController _userController = Get.find<UserController>();
  final TextEditingController _fullnameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  Future<void> _pickImageFromGallery() async {
    final returnedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (returnedImage == null) return;
    _settingViewmodel.setSelectImage(File(returnedImage.path));
  }

  @override
  Widget build(BuildContext context) {
    User user = _userController.userRes.value.data!;
    _fullnameController.text = user.fullname;
    _phoneController.text = user.phone_number ?? '';
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: Colors.white,
        title: const Text(
          'Thông tin cá nhân',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
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
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // const SizedBox(height: 14),
              // const Text(
              //   'Cài đặt',
              //   style: TextStyle(
              //     fontSize: 34,
              //     fontWeight: FontWeight.bold,
              //     color: ColorApp.black,
              //   ),
              // ),
              // const Text(
              //   'Thông tin cá nhân',
              //   style: TextStyle(
              //     fontSize: 16,
              //     fontWeight: FontWeight.w700,
              //     color: ColorApp.black,
              //   ),
              // ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Obx(
                    () => GestureDetector(
                      onTap: () async => await _pickImageFromGallery(),
                      child: _settingViewmodel.selectedImage.value == null
                          ? AvatarContainer(
                              image: _userController.userRes.value.data!.image,
                              radius: 100,
                              replaceImage: 'assets/images/avatar-image.jpg',
                            )
                          : ClipOval(
                              child: Image.file(
                                _settingViewmodel.selectedImage.value!,
                                width: 100,
                                height: 100,
                                fit: BoxFit.cover,
                              ),
                            ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              containerInfo(
                title: 'Email',
                value: user.email,
              ),
              const SizedBox(height: 20),
              inputContainer(
                controller: _fullnameController,
                textHind: 'Họ và tên',
              ),
              const SizedBox(height: 20),
              inputContainer(
                controller: _phoneController,
                textHind: 'Số điện thoại',
              ),
              const SizedBox(height: 30),

              Obx(
                () {
                  if (_settingViewmodel.updateInfoRes.value.status ==
                      Status.error) {
                    showDialogError(
                      error: _settingViewmodel.updateInfoRes.value.message!,
                    );
                  }

                  if (_settingViewmodel.uploadImageRes.value.status ==
                      Status.error) {
                    showDialogError(
                      error: _settingViewmodel.uploadImageRes.value.message!,
                    );
                  }

                  if (_settingViewmodel.updateInfoRes.value.status ==
                      Status.loading) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: ColorApp.primary,
                      ),
                    );
                  }

                  return ButtonPrimary(
                    title: 'Thay đổi',
                    event: () => _settingViewmodel.handleUpdate(
                      fullname: _fullnameController.text,
                      phoneNumber: _phoneController.text,
                    ),
                  );
                },
              ),

              // SizedBox(
              //   width: double.infinity,
              //   child: FilledButton(
              //     onPressed: () => Get.toNamed(Routes.changeInfo),
              //     style: FilledButton.styleFrom(
              //       backgroundColor: ColorApp.primary,
              //       minimumSize: Size.zero,
              //       padding: const EdgeInsets.symmetric(
              //         vertical: 14,
              //       ),
              //       tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              //     ),
              //     child: Text(
              //       'Thay đổi',
              //       style: TextThemes.text_14_500.copyWith(color: Colors.white),
              //     ),
              //   ),
              // ),
              // const SizedBox(height: 24),
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
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: ColorApp.black,
        ),
      ),
    );
  }

  Widget containerInfo({
    required String title,
    required String value,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        vertical: 15,
        horizontal: 15,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4),
        boxShadow: [
          BoxShadow(
            blurRadius: 8,
            offset: const Offset(0, 1),
            color: Colors.black.withOpacity(0.05),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: ColorApp.gray,
            ),
          ),
          const SizedBox(height: 3),
          Text(
            value,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: ColorApp.black,
            ),
          ),
        ],
      ),
    );
  }
}
