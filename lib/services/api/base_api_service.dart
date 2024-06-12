import 'dart:io';

import '../../configs/configs.dart';

abstract class BaseApiService {
  final String baseUrl = Configs.baseUrl;

  Future<dynamic> getResponse(String url);

  Future<dynamic> postResponse({
    required String url,
    required Object bodyData,
  });

  Future<dynamic> uploadFileResponse({
    required String url,
    required Map<String, String> bodyData,
    required File file,
  });
}
