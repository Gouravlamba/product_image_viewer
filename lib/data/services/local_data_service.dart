import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;

class LocalDataService {
  Future<List<dynamic>> loadLocalProductsJson() async {
    const String path = 'assets/data/products.json';

    final String rawJson = await rootBundle.loadString(path);
    final List<dynamic> data = jsonDecode(rawJson);
    return data;
  }
}
