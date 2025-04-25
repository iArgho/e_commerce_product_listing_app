import 'dart:convert';
import 'package:e_commerce_product_listing_app/utils/url.dart';
import 'package:http/http.dart' as http;
import '../model/product_model.dart';

class ApiService {
  static Future<List<Product>> fetchProducts() async {
    final response = await http.get(Uri.parse(Urls.products));

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body);
      return jsonList.map((json) => Product.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }
}
