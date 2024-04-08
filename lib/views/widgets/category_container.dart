// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class CategoryContainer extends StatelessWidget {
  const CategoryContainer({
    super.key,
    required this.title,
    required this.image,
    this.event,
  });

  final String title;
  final String image;
  final void Function()? event;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: GestureDetector(
        onTap: event,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  blurRadius: 25,
                  offset: const Offset(0, 4),
                  color: const Color(0xFF000000).withOpacity(0.25),
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      const SizedBox(width: 23),
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF222222),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Image.asset(
                    image,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
