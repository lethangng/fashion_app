// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../utils/color_app.dart';

class TextInputContainer extends StatelessWidget {
  const TextInputContainer({
    super.key,
    required this.textController,
    required this.title,
    required this.des,
    required this.errorString,
    required this.isTrue,
    required this.isPassword,
    this.showPassword,
    this.event,
  });

  final TextEditingController textController;
  final String title;
  final String des;
  final String errorString;
  final bool isTrue;
  final bool isPassword;
  final bool? showPassword;
  final void Function()? event;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(4),
            border: Border.all(
              width: errorString.isEmpty ? 0 : 1,
              color:
                  errorString.isEmpty ? Colors.white : const Color(0xFFF01F0E),
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        color: errorString.isEmpty
                            ? const Color(0xFFD9D9D9)
                            : const Color(0xFFF01F0E),
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: textController,
                            obscureText: isPassword && showPassword == true,
                            cursorColor: ColorApp.colorGrey2,
                            style: const TextStyle(color: Colors.black),
                            textAlignVertical: TextAlignVertical.center,
                            textAlign: TextAlign.left,
                            decoration: InputDecoration(
                              isDense: true, // Cho chu can giua theo chieu doc
                              hintText: des,
                              hintStyle: const TextStyle(
                                color: ColorApp.colorGrey2,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.only(
                                right: size.width * 0.03,
                              ),
                            ),
                          ),
                        ),
                        isPassword
                            ? IconButton(
                                onPressed: event,
                                style: IconButton.styleFrom(
                                  minimumSize: Size.zero,
                                  padding: EdgeInsets.zero,
                                  tapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                ),
                                icon: SvgPicture.asset(
                                  'assets/icons/${(showPassword == true) ? 'eye_fill_icon' : 'eye_slash_fill_icon'}.svg',
                                  colorFilter: const ColorFilter.mode(
                                    Colors.grey,
                                    BlendMode.srcIn,
                                  ),
                                ),
                              )
                            : const SizedBox(),
                      ],
                    ),
                  ],
                ),
              ),
              Visibility(
                visible: isPassword == false &&
                    isTrue == false &&
                    errorString.isEmpty == false,
                child: SvgPicture.asset(
                    'assets/icons/${(errorString.isEmpty) ? 'success' : 'error'}.svg'),
              ),
            ],
          ),
        ),
        Visibility(
          visible: errorString.isNotEmpty,
          child: Text(
            errorString,
            style: const TextStyle(
              color: Color(0xFFF01F0E),
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        )
      ],
    );
  }
}
