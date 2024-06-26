import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

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

  Future<void> _launchUrl(urlVal) async {
    final Uri url = Uri.parse(urlVal);
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }

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
                    image: _userController.userRes.value.data?.image,
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
            rowInfoHelp(
              title: 'Liên hệ',
              desc: 'Liên hệ với chúng tôi',
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
                  _userController.userRes.value.data!.login_type == 'password',
              // true,
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

  Widget rowInfoHelp({
    required String title,
    required String desc,
    void Function()? event,
  }) {
    final RxBool isShow = false.obs;

    void handleShow() {
      isShow.value = !isShow.value;
    }

    return InkWell(
      onTap: () => handleShow(),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Obx(
          () => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
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
                  const Spacer(),
                  SvgPicture.asset(
                      'assets/icons/${isShow.value ? 'top' : 'top-2'}.svg'),
                  const SizedBox(width: 5),
                ],
              ),
              AnimatedSize(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                child: SizedBox(
                  height: isShow.value ? null : 0,
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      SizedBox(
                        width: Get.width * 0.8,
                        child: const Divider(
                          height: 1,
                          color: ColorApp.primary,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          buttonHelp(
                            icon: 'assets/images/help-1.png',
                            event: () => _launchUrl(
                                'https://www.facebook.com/?locale=vi_VN'),
                          ),
                          buttonHelp(
                            icon: 'assets/images/help-3.png',
                            event: () =>
                                _launchUrl('mailto:lethangng@gmail.com'),
                          ),
                          buttonHelp(
                            icon: 'assets/images/help-5.png',
                            event: () => _launchUrl('tel:0987654321'),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  TextButton buttonHelp({
    required String icon,
    void Function()? event,
  }) {
    return TextButton(
      onPressed: event,
      style: TextButton.styleFrom(
        minimumSize: Size.zero,
        padding: EdgeInsets.zero,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      child: Image.asset(icon),
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
