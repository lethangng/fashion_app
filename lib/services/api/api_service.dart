import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../exceptions/app_exceptions.dart';
import 'base_api_service.dart';

final Map<String, String> baseHeader = {
  HttpHeaders.authorizationHeader: '',
  HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8'
};

class ApiService extends BaseApiService {
  @override
  Future getResponse(String url) async {
    dynamic responseJson;
    try {
      debugPrint(baseUrl + url);
      final response = await http
          .get(
            Uri.parse(baseUrl + url),
            // headers: baseHeader,
          )
          .timeout(
            const Duration(seconds: 10),
          );
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    } on RequestTimeOut {
      throw RequestTimeOut('Request Timeout');
    }
    return responseJson;
  }

  @override
  Future postResponse({
    required String url,
    required Object jsonBody,
  }) async {
    dynamic responseJson;
    try {
      final response = await http.post(
        Uri.parse(url),
        // Uri.parse(baseUrl + url),
        // headers: baseHeader,
        // body: json.encode(jsonBody),
        body: jsonBody,
      );
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    } on RequestTimeOut {
      throw RequestTimeOut('Request Timeout');
    }
    return responseJson;
  }

  dynamic returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      default:
        // Loi 404:
        debugPrint('Lỗi có status code : ${response.statusCode}');
        throw FetchDataException('Lỗi khi liên lạc với máy chủ.');
    }
  }
}
