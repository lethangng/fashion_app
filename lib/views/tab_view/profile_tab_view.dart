import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../app/routes.dart';
import '../../utils/color_app.dart';

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
          rowInfo(
            title: 'Lịch sử mua hàng',
            desc: 'Đã có ${12} đơn hàng',
            event: () => Get.toNamed(Routes.historyView),
          ),
          rowInfo(title: 'Địa chỉ giao hàng', desc: '${3} địa chỉ'),
          rowInfo(title: 'Cài đặt', desc: 'Thông tin cá nhân, mật khẩu'),
        ],
      ),
    );
  }

  Widget rowInfo({
    required String title,
    required String desc,
    void Function()? event,
  }) {
    return Padding(
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
          IconButton(
            onPressed: event,
            style: IconButton.styleFrom(
              minimumSize: Size.zero,
              padding: EdgeInsets.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            icon: SvgPicture.asset('assets/icons/arrow-right-2.svg'),
          )
        ],
      ),
    );
  }
}
