import 'dart:convert';

import 'package:flutter/material.dart';

import '../api/api_endpoints.dart';
import '../api/api_service.dart';
import '../exceptions/app_exceptions.dart';
import 'base_respository.dart';

class AccessServerRepository implements BaseRepository<Map<String, dynamic>> {
  final ApiService apiService = ApiService();

  @override
  getData(Map<String, dynamic> data) async {
    try {
      dynamic response = await apiService.getResponse(
        ApiEndPoints.endPoint(data['query']),
      );
      if (response is List) {
        // List<DataMessage> jsonData =
        //     response.map((item) => DataMessage.fromJson(item)).toList();
        // return jsonData;
      } else if (response is Map) {
        if (response['res'] == 'done') {
          var data = response['msg'];
          return data;
        } else {
          throw BadRequestException('${response['msg']}');
        }
      } else {
        throw const FormatException('Lỗi không đúng định dạng.');
      }
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  @override
  postData(Map<String, dynamic> data) async {
    try {
      dynamic response = await apiService.postResponse(
        url: ApiEndPoints.endPoint(data['query']),
        jsonBody: json.decode(data['data']),
      );
      if (response is List) {
        // List<DataMessage> jsonData =
        //     response.map((item) => DataMessage.fromJson(item)).toList();
        // return jsonData;
      } else if (response is Map) {
        if (response['res'] == 'done') {
          var data = response['data'];
          return data;
        } else {
          throw BadRequestException('${response['msg']}');
        }
      } else {
        throw const FormatException('Lỗi không đúng định dạng.');
      }
    } catch (e) {
      debugPrint('Lỗi: $e');
      rethrow;
    }
  }
}
