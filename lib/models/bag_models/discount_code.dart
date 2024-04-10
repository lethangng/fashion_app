// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class DiscountCode {
  final int id;
  final int sale;
  final Color backgroundColor;
  final Color saleColor;
  final String name;
  final String code;
  final String time;

  DiscountCode({
    required this.id,
    required this.sale,
    required this.backgroundColor,
    required this.saleColor,
    required this.name,
    required this.code,
    required this.time,
  });
}
