import 'dart:convert';

import 'package:flutter/services.dart';

Future<List<String>> loadBankImages() async {
  try {
    final manifestJson = await rootBundle.loadString('AssetManifest.json');
    final Map<String, dynamic> manifestMap = json.decode(manifestJson);

    // Lọc các file bắt đầu bằng 'assets/images/png/banks/'
    final images = manifestMap.keys
        .where((path) => path.startsWith('assets/images/png/banks/'))
        .toList();

    return images;
  } catch (e) {
    // Xử lý lỗi nếu cần (ví dụ: manifest không tồn tại)
    return [];
  }
}
