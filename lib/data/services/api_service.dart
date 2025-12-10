import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../utils/app_constants.dart';

class ApiService {
  Future<List<dynamic>> fetchProductList() async {
    final uri = Uri.parse(AppConstants.productsApiUrl);

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data;
    } else {
      throw Exception('Failed to fetch products: ${response.statusCode}');
    }
  }
}
