import 'package:flutter/material.dart';
// import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../services/response/api_status.dart';
import '../../../utils/color_app.dart';
import '../../../view_models/tab_view_models/shop_tab_view_models/reviews_viewmodel.dart';
import '../../widgets/loadmore.dart';
import '../../widgets/review_container.dart';
import '../../widgets/show_dialog_error.dart';

class ReviewsScreen extends StatelessWidget {
  ReviewsScreen({super.key});
  final ReviewsViewmodel _reviewsViewmodel = Get.put(ReviewsViewmodel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: ColorApp.background,
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: SvgPicture.asset('assets/icons/arrow-back.svg'),
        ),
      ),
      // floatingActionButton: Padding(
      //   padding: const EdgeInsets.only(bottom: 50),
      //   child: FilledButton(
      //     onPressed: () => onWriteReview(),
      //     style: FilledButton.styleFrom(
      //       backgroundColor: ColorApp.primary,
      //       foregroundColor: ColorApp.white,
      //       shape: RoundedRectangleBorder(
      //         borderRadius: BorderRadius.circular(25),
      //       ),
      //       minimumSize: Size.zero,
      //       padding: const EdgeInsets.symmetric(
      //         horizontal: 14,
      //         vertical: 10,
      //       ),
      //       tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      //     ),
      //     child: Row(
      //       mainAxisSize: MainAxisSize.min,
      //       children: [
      //         SvgPicture.asset('assets/icons/edit.svg'),
      //         const SizedBox(width: 4),
      //         const Text(
      //           'Thêm bình luận',
      //           style: TextStyle(
      //             fontSize: 14,
      //             fontWeight: FontWeight.w700,
      //           ),
      //         )
      //       ],
      //     ),
      //   ),
      // ),
      body: Obx(() {
        if (_reviewsViewmodel.evaluateRes.value.status == Status.error) {
          showDialogError(error: _reviewsViewmodel.evaluateRes.value.message!);
        }

        if (_reviewsViewmodel.evaluateRes.value.status == Status.completed) {
          return Loadmore(
            refreshController: _reviewsViewmodel.refreshController,
            onLoading: _reviewsViewmodel.onLoading,
            onRefresh: _reviewsViewmodel.onRefresh,
            widget: screen(),
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

  Widget screen() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 18),
            const Text(
              'Xếp hạng & Đánh giá',
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.w700,
                color: ColorApp.black,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const SizedBox(width: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      '${_reviewsViewmodel.average_evaluate}',
                      style: const TextStyle(
                        fontSize: 44,
                        fontWeight: FontWeight.w700,
                        color: ColorApp.black,
                      ),
                    ),
                    Text(
                      '${_reviewsViewmodel.count} đánh giá',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: ColorApp.gray,
                      ),
                    )
                  ],
                ),
                // const Spacer(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    starContainer(
                      starCount: 5,
                      count: _reviewsViewmodel.star_5,
                    ),
                    starContainer(
                      starCount: 4,
                      count: _reviewsViewmodel.star_4,
                    ),
                    starContainer(
                      starCount: 3,
                      count: _reviewsViewmodel.star_3,
                    ),
                    starContainer(
                      starCount: 2,
                      count: _reviewsViewmodel.star_2,
                    ),
                    starContainer(
                      starCount: 1,
                      count: _reviewsViewmodel.star_1,
                    ),
                  ],
                ),
                const SizedBox(width: 20),
              ],
            ),
            const SizedBox(height: 30),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                '${_reviewsViewmodel.listEvaluate.length} đánh giá',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF222222),
                ),
              ),
            ),
            const SizedBox(height: 10),
            ListView.builder(
              itemCount: _reviewsViewmodel.listEvaluate.length,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: EdgeInsets.only(bottom: index != 1 ? 20 : 0),
                  child: ReviewContainer(
                    evaluate: _reviewsViewmodel.listEvaluate[index],
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }

  Widget reviewsContainer({
    required int id,
    required String image,
    required String name,
    required int star,
    required String time,
    required String content,
  }) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  blurRadius: 25,
                  offset: const Offset(0, 1),
                  color: const Color(0xFF000000).withOpacity(0.05),
                )
              ],
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF222222),
                          ),
                        ),
                        Row(
                          children: [
                            for (int i = 0; i < 5; i++)
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SvgPicture.asset(
                                      'assets/icons/${(i < star) ? 'star-full' : 'star-empty'}.svg'),
                                  const SizedBox(width: 2),
                                ],
                              ),
                          ],
                        )
                      ],
                    ),
                    Text(
                      time,
                      style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF9B9B9B),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 11),
                Text(
                  content,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF222222),
                  ),
                ),
                const SizedBox(height: 10),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/images/review-1.png',
                      ),
                      const SizedBox(width: 16),
                      Image.asset(
                        'assets/images/review-1.png',
                      ),
                      const SizedBox(width: 16),
                      Image.asset(
                        'assets/images/review-1.png',
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        Positioned(
          top: -20,
          left: 0,
          child: Image.asset(image),
        ),
      ],
    );
  }

  Widget starContainer({required int starCount, required int count}) {
    return Row(
      children: [
        for (int i = 0; i < starCount; i++)
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset('assets/icons/star-full.svg'),
              const SizedBox(width: 2),
            ],
          ),
        const SizedBox(width: 20),
        SizedBox(
          width: 20,
          child: Text(
            count.toString(),
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Color(0xFF4F4F4F),
            ),
          ),
        ),
      ],
    );
  }
}
