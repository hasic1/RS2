import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:jamfix_admin/models/search_result.dart';
import 'package:jamfix_admin/utils/util.dart';
import 'package:jamfix_admin/models/drzava.dart';
import 'package:jamfix_admin/providers/base_provider.dart';

class DrzavaProvider extends BaseProvider<Drzava> {
  DrzavaProvider() : super("Drzava");

  @override
  Drzava fromJson(data) {
    return Drzava.fromJson(data);
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

  Future<Drzava> dodajDrzavu(dynamic request) async {
    var url = "${Authorization.putanjaTestni}api/Drzava/SendDrzava";
    var uri = Uri.parse(url);

    var headers = createHeadersLogIn();
    var jsonRequest = jsonEncode(request);
    var response = await http.post(uri, headers: headers, body: jsonRequest);

    if (isValidInsertUpdate(response)) {
      var data = jsonDecode(response.body);
      return fromJson(data);
    } else {
      throw Exception("Unknown error");
    }
  }
}
