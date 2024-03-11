import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:jamfix_admin/utils/util.dart';
import 'package:jamfix_admin/models/drzava.dart';
import 'package:jamfix_admin/providers/base_provider.dart';

class DrzavaProvider extends BaseProvider<Drzava> {
  DrzavaProvider() : super("Drzava");

  @override
  Drzava fromJson(data) {
    return Drzava.fromJson(data);
  }

  Future<Drzava> dodajDrzavu(dynamic request) async {
    var url = "${Authorization.putanjaTestni}api/Drzava/SendDrzava";
    var uri = Uri.parse(url);

    var headers = createHeaders();
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
