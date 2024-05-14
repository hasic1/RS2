import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:jamfix_mobilna/models/drzava.dart';
import 'package:jamfix_mobilna/models/search_result.dart';
import 'package:jamfix_mobilna/providers/base_provider.dart';
import 'package:jamfix_mobilna/utils/utils.dart';

class DrzavaProvider extends BaseProvider<Drzava> {
  DrzavaProvider() : super("Drzava");

  @override
  Drzava fromJson(dynamic data) {
    return Drzava.fromJson(data as Map<String, dynamic>);
  }
  
  Future<SearchResult<Drzava>> getDrzave() async {
    var url = "${Authorization.putanja}Drzava/GetDrzave";
    var uri = Uri.parse(url);

    var response = await http.get(uri);

    if (isValidResponse(response)) {
      var data = jsonDecode(response.body);
      var result = SearchResult<Drzava>();

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
