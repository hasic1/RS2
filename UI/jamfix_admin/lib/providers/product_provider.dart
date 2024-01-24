import 'dart:convert';

import 'package:jamfix_admin/models/product.dart';
import 'package:jamfix_admin/models/search_result.dart';
import 'package:jamfix_admin/providers/base_provider.dart';
import 'package:http/http.dart' as http;
import 'package:jamfix_admin/utils/util.dart';

class ProductProvider extends BaseProvider<Product> {
  ProductProvider() : super("Proizvodi");

  @override
  Product fromJson(data) {
    return Product.fromJson(data);
  }

  Future<SearchResult<Product>> fetchRecommendedProducts() async {
    var url = "https://localhost:7097/Proizvodi/topRatedProducts/3";
    var uri = Uri.parse(url);

    var response = await http.get(uri);

    print("Status code:${response.statusCode}");
    if (isValidResponse(response)) {
      var data = jsonDecode(response.body);

      var result = SearchResult<Product>();
      result.count = data['count'];

      for (var item in data['result']) {
        result.result.add(fromJson(item));
      }

      return result;
    } else {
      throw Exception("Unknown error");
    }
  }
}
