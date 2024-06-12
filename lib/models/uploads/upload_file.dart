// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

class UploadFile {
  final String query;
  final Map<String, String> data;
  final File file;

  UploadFile({
    required this.query,
    required this.data,
    required this.file,
  });
}
