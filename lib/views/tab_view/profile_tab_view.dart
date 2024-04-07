import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../app/routes.dart';
import '../../utils/color_app.dart';
import '../../utils/text_themes.dart';

class ProfileTabView extends StatelessWidget {
  const ProfileTabView({super.key});

  @override
  Widget build(BuildContext context) {
    final appBarHeight = AppBar().preferredSize.height;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: appBarHeight + 18),
          const Text(
            'Thông tin cá nhân',
            style: TextStyle(
              fontSize: 34,
              fontWeight: FontWeight.bold,
              color: ColorApp.black,
            ),
          ),
          const SizedBox(height: 18),
          const Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                backgroundColor: Colors.grey,
                radius: 64 / 2,
                backgroundImage: AssetImage('assets/images/avatar-profile.png'),
              ),
              SizedBox(width: 18),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Matilda Brown',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: ColorApp.black,
                    ),
                  ),
                  Text(
                    'matildabrown@mail.com',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: ColorApp.gray,
                    ),
                  ),
                ],
              )
            ],
          ),
          const SizedBox(height: 28),
          Container(
            height: 1,
            width: double.infinity,
            color: ColorApp.gray,
          ),
          rowInfo(
            title: 'Đơn hàng',
            desc: 'Đã có ${12} đơn hàng',
            event: () => Get.toNamed(Routes.historyView),
          ),
          Container(
            height: 1,
            width: double.infinity,
            color: ColorApp.gray,
          ),
          rowInfo(
              title: 'Địa chỉ giao hàng',
              desc: '${3} địa chỉ',
              event: () => Get.toNamed(Routes.address)),
          Container(
            height: 1,
            width: double.infinity,
            color: ColorApp.gray,
          ),
          rowInfo(
            title: 'Cài đặt',
            desc: 'Thông tin cá nhân, mật khẩu',
            event: () => Get.toNamed(Routes.setting),
          ),
          Container(
            height: 1,
            width: double.infinity,
            color: ColorApp.gray,
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: () => Get.toNamed(Routes.changePassword),
              style: OutlinedButton.styleFrom(
                side: const BorderSide(
                  color: ColorApp.black,
                  width: 1,
                ),
                minimumSize: Size.zero,
                padding: const EdgeInsets.symmetric(
                  vertical: 14,
                ),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: Text(
                'Đổi mật khẩu',
                style: TextThemes.text_14_500.copyWith(color: ColorApp.black),
              ),
            ),
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: FilledButton(
              onPressed: () {},
              style: FilledButton.styleFrom(
                backgroundColor: ColorApp.primary,
                minimumSize: Size.zero,
                padding: const EdgeInsets.symmetric(
                  vertical: 14,
                ),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: Text(
                'Đăng xuất',
                style: TextThemes.text_14_500.copyWith(color: Colors.white),
              ),
            ),
          ),
        ],
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
                    fontSize: 11,
                    fontWeight: FontWeight.w400,
                    color: ColorApp.gray,
                  ),
                ),
              ],
            ),
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
