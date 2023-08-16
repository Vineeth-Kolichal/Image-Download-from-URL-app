import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:download_image/data/get_permission.dart';

class DownloadImage {
  Dio dio = Dio();
  Future<String?> downloadImage({required String url}) async {
    String path = await getExternalDocumentPath();
    log(path);
    try {
      String imageName = DateTime.now().millisecondsSinceEpoch.toString();
      final response = await dio.download(url, '$path/$imageName.jpg');
      if (response.statusCode == 200) {
        return '$path/$imageName.jpg';
      } else {
        return null;
      }
    } catch (e) {
      log(e.toString());
      return null;
    }
  }
}
