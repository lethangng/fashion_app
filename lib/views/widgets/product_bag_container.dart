// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../models/bag_models/bag_model.dart';
import '../../utils/color_app.dart';
import '../../view_models/tab_view_models/bag_tab_models/bag_tab_view_model.dart';

// ignore: must_be_immutable
class ProductBagContainer extends StatelessWidget {
  ProductBagContainer({
    super.key,
    required this.bagModel,
    this.isPay = false,
  });
  final BagModel bagModel;
  bool isPay;
  final BagTabViewModel bagTabViewModel = Get.find<BagTabViewModel>();
  final RxBool isShowDelete = false.obs;

  void onShowDelete() {
    isShowDelete.value = !isShowDelete.value;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Container(
            decoration: const BoxDecoration(color: Colors.white),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  bagModel.image,
                  width: Get.width * 0.3,
                  fit: BoxFit.cover,
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(11),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  bagModel.name,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: ColorApp.black,
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.all(4),
                                  color: ColorApp.gray.withOpacity(0.1),
                                  child: Row(
                                    children: [
                                      RichText(
                                        text: TextSpan(
                                          text: 'Phân loại: ',
                                          style: const TextStyle(
                                            fontSize: 11,
                                            fontWeight: FontWeight.w400,
                                            color: ColorApp.black,
                                          ),
                                          children: [
                                            TextSpan(text: bagModel.color),
                                            const TextSpan(text: ', '),
                                            TextSpan(text: bagModel.size),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(width: 5),
                                      SvgPicture.asset(
                                          'assets/icons/arrow-down.svg'),
                                    ],
                                  ),
                                )
                              ],
                            ),
                            Visibility(
                              visible: isPay == false,
                              child: IconButton(
                                onPressed: () => onShowDelete(),
                                style: IconButton.styleFrom(
                                  minimumSize: Size.zero,
                                  padding: EdgeInsets.zero,
                                  tapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                ),
                                icon: SvgPicture.asset(
                                    'assets/icons/dot-menu.svg'),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        isPay == false
                            ? Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        width: 36,
                                        height: 36,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.white,
                                          boxShadow: [
                                            BoxShadow(
                                              blurRadius: 8,
                                              offset: const Offset(0, 4),
                                              color: const Color(0xFF000000)
                                                  .withOpacity(0.1),
                                            ),
                                          ],
                                        ),
                                        child: IconButton(
                                          onPressed: () =>
                                              bagTabViewModel.handleCount(
                                                  id: bagModel.id, type: ''),
                                          icon: SvgPicture.asset(
                                              'assets/icons/minus.svg'),
                                        ),
                                      ),
                                      const SizedBox(width: 16),
                                      Text(
                                        bagModel.count.toString(),
                                        style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          color: ColorApp.black,
                                        ),
                                      ),
                                      const SizedBox(width: 16),
                                      Container(
                                        width: 36,
                                        height: 36,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.white,
                                          boxShadow: [
                                            BoxShadow(
                                              blurRadius: 8,
                                              offset: const Offset(0, 4),
                                              color: const Color(0xFF000000)
                                                  .withOpacity(0.1),
                                            ),
                                          ],
                                        ),
                                        child: IconButton(
                                          onPressed: () =>
                                              bagTabViewModel.handleCount(
                                            id: bagModel.id,
                                            type: 'add',
                                          ),
                                          icon: SvgPicture.asset(
                                              'assets/icons/add.svg'),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    '${bagModel.price}\$',
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: ColorApp.black,
                                    ),
                                  )
                                ],
                              )
                            : Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    'x${bagModel.count}',
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                      color: ColorApp.black,
                                    ),
                                  ),
                                ],
                              ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        Obx(
          () => Visibility(
            visible: isShowDelete.value,
            child: Positioned(
              top: 10,
              right: 35,
              child: Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 25,
                      offset: const Offset(0, 1),
                      color: const Color(0xFF000000).withOpacity(0.14),
                    )
                  ],
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.white,
                ),
                child: TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    minimumSize: Size.zero,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 34,
                      vertical: 17,
                    ),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: const Text(
                    'Xóa khỏi giỏ hàng',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                      color: ColorApp.black,
                    ),
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
