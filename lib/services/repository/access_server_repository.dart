import 'package:flutter/material.dart';

import '../../models/request/request_data.dart';
import '../../models/uploads/upload_file.dart';
import '../api/api_endpoints.dart';
import '../api/api_service.dart';
import '../exceptions/app_exceptions.dart';
import 'base_respository.dart';

class AccessServerRepository implements BaseRepository<RequestData> {
  final ApiService apiService = ApiService();

  @override
  getData(RequestData data) async {
    try {
      dynamic response = await apiService.getResponse(
        ApiEndPoints.endPoint(data.query),
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
      debugPrint(e.toString());
      rethrow;
    }
  }

  @override
  postData(RequestData data) async {
    try {
      dynamic response = await apiService.postResponse(
        url: ApiEndPoints.endPoint(data.query),
        bodyData: data.data,
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

  uploadFile(UploadFile data) async {
    dynamic responseValue;
    try {
      dynamic response = await apiService.uploadFileResponse(
        url: data.query,
        bodyData: data.data,
        file: data.file,
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
      throw Exception('$e');
    }
    return responseValue;
  }
}
