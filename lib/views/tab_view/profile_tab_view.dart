import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../app/routes.dart';
import '../../services/auth/auth_service.dart';
import '../../utils/color_app.dart';
import '../../view_models/controllers/user_controller.dart';
import '../widgets/avatar_container.dart';
import '../widgets/button_primary.dart';
import '../widgets/button_second.dart';

class ProfileTabView extends StatelessWidget {
  ProfileTabView({super.key});
  final UserController _userController = Get.find<UserController>();

  @override
  Widget build(BuildContext context) {
    final appBarHeight = AppBar().preferredSize.height;
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: appBarHeight),
            const Text(
              'Thông tin cá nhân',
              style: TextStyle(
                fontSize: 34,
                fontWeight: FontWeight.bold,
                color: ColorApp.black,
              ),
            ),
            const SizedBox(height: 18),
            Obx(
              () => Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  AvatarContainer(
                    image: _userController.userRes.value.data!.image,
                    radius: 64,
                    replaceImage: 'assets/images/avatar-image.jpg',
                  ),
                  const SizedBox(width: 18),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _userController.userRes.value.data!.fullname,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: ColorApp.black,
                        ),
                      ),
                      Text(
                        _userController.userRes.value.data!.email,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: ColorApp.gray,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(height: 28),
            Container(
              height: 1,
              width: double.infinity,
              color: ColorApp.gray,
            ),
            rowInfo(
              title: 'Đơn hàng',
              desc:
                  // 'Đã có ${_userController.userRes.value.data!.total_order} đơn hàng',
                  'Đơn hàng của bạn',
              event: () => Get.toNamed(Routes.historyView),
            ),
            // Container(
            //   height: 1,
            //   width: double.infinity,
            //   color: ColorApp.gray,
            // ),
            // rowInfo(
            //   title: 'Thông báo',
            //   desc: 'Có ${10} thông báo mới',
            //   event: () => Get.toNamed(Routes.historyView),
            // ),
            Container(
              height: 1,
              width: double.infinity,
              color: ColorApp.gray,
            ),
            rowInfo(
                title: 'Địa chỉ nhận hàng',
                desc:
                    // '${_userController.userRes.value.data!.total_order} địa chỉ',
                    'Địa chỉ nhận hàng của bạn',
                event: () => Get.toNamed(Routes.address)),
            Container(
              height: 1,
              width: double.infinity,
              color: ColorApp.gray,
            ),
            rowInfo(
              title: 'Cài đặt',
              desc: 'Thông tin cá nhân',
              event: () => Get.toNamed(Routes.setting),
            ),
            Container(
              height: 1,
              width: double.infinity,
              color: ColorApp.gray,
            ),
            const SizedBox(height: 30),
            Visibility(
              visible:
                  // _userController.userRes.value.data!.login_type == 'password',
                  true,
              child: ButtonSecond(
                title: 'Đổi mật khẩu',
                isUpperCase: true,
                event: () => Get.toNamed(Routes.changePassword),
              ),
            ),
            const SizedBox(height: 20),
            ButtonPrimary(
              title: 'Đăng xuất',
              isUpperCase: true,
              event: () async {
                await AuthService.logout();
                Get.offAllNamed(Routes.login);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget rowInfo({
    required String title,
    required String desc,
    void Function()? event,
  }) {
    return InkWell(
      onTap: event,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: ColorApp.black,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  desc,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                    color: ColorApp.gray,
                  ),
                ),
              ],
            ),
            // const Spacer(),
            // IconButton(
            //   onPressed: event,
            //   style: IconButton.styleFrom(
            //     minimumSize: Size.zero,
            //     padding: EdgeInsets.zero,
            //     tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            //   ),
            //   icon: ,
            // )
            SvgPicture.asset('assets/icons/arrow-right-2.svg')
          ],
        ),
      ),
    );
  }
}
