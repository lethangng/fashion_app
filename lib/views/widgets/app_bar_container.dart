import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class AppBarContainer extends StatelessWidget {
  const AppBarContainer({super.key, this.title, this.event});
  final String? title;
  final void Function()? event;

  @override
  Widget build(BuildContext context) {
    final heightStatusBar = MediaQuery.of(context).viewPadding.top;
    final appBarHeight = AppBar().preferredSize.height;
    return Column(
      children: [
        SizedBox(
          height: heightStatusBar,
          width: double.infinity,
        ),
        Stack(
          children: [
            SizedBox(
              height: appBarHeight,
              width: double.infinity,
            ),
            Positioned.fill(
              child: Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  onPressed: event ??
                      () {
                        Get.back();
                      },
                  icon: SvgPicture.asset('assets/icons/arrow-back.svg'),
                ),
              ),
            ),
            Positioned.fill(
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  title ?? '',
                  style: const TextStyle(
                    // color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
