import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:jamfix_mobilna/models/product.dart';
import 'package:jamfix_mobilna/models/search_result.dart';
import 'package:jamfix_mobilna/providers/base_provider.dart';
import 'package:jamfix_mobilna/utils/utils.dart';

class ProductProvider extends BaseProvider<Product> {
  ProductProvider() : super("Proizvodi");

  @override
  Product fromJson(data) {
    return Product.fromJson(data);
  }

  Future<SearchResult<Product>> fetchBestProducts() async {
    var i = 3;
    var url = "https://10.0.2.2:7097/Proizvodi/topRatedProducts/$i";
    var uri = Uri.parse(url);

    var response = await http.get(uri);

    if (isValidResponse(response)) {
      var data = jsonDecode(response.body);

      var result = SearchResult<Product>();

      if (data.containsKey('count') && data['count'] is int) {
        result.count = data['count'];
      } else {
        result.count = 0;
      }

      for (var item in data['result']) {
        result.result.add(fromJson(item));
      }

      return result;
    } else {
      throw Exception("Unknown error");
    }
  }

  Future<SearchResult<Product>> fetchRecommendedProducts(int? id) async {
    var url = "https://10.0.2.2:7097/Proizvodi/recommend/$id";

    var uri = Uri.parse(url);

    var headers = createHeaders();
    var response = await http.get(uri, headers: headers);

    print("Status code:${response.statusCode}");
    if (isValidResponse(response)) {
      var data = jsonDecode(response.body);

      var result = SearchResult<Product>();

      if (data.containsKey('count') && data['count'] is int) {
        result.count = data['count'];
      } else {
        result.count = 0;
      }

      for (var item in data['result']) {
        result.result.add(fromJson(item));
      }

      return result;
    } else {
      throw Exception("Unknown error");
    }
  }
}
