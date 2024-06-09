// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../models/home_models/evaluate.dart';
import 'avatar_container.dart';

class ReviewContainer extends StatelessWidget {
  const ReviewContainer({
    super.key,
    required this.evaluate,
  });

  final Evaluate evaluate;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
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
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  AvatarContainer(
                    image: evaluate.image_url,
                    radius: 32,
                    replaceImage: 'assets/images/avatar-review.png',
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        evaluate.fullname,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF222222),
                        ),
                      ),
                      Row(
                        children: [
                          for (int i = 0; i < 5; i++)
                            Padding(
                              padding: const EdgeInsets.only(right: 2),
                              child: SvgPicture.asset(
                                  'assets/icons/${(i < evaluate.star_number) ? 'star-full' : 'star-empty'}.svg'),
                            ),
                        ],
                      )
                    ],
                  ),
                ],
              ),
              Text(
                evaluate.created_at,
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF9B9B9B),
                ),
              )
            ],
          ),
          const SizedBox(height: 11),
          Visibility(
            visible: evaluate.content != null,
            child: Column(
              children: [
                Text(
                  '${evaluate.content}',
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
        ],
      ),
    );
  }
}
