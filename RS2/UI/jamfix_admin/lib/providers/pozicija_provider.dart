import 'dart:convert';

import 'package:jamfix_admin/models/pozicija.dart';
import 'package:jamfix_admin/providers/base_provider.dart';
import 'package:http/http.dart' as http;
import 'package:jamfix_admin/utils/util.dart';

class PozicijaProvider extends BaseProvider<Pozicija> {
  PozicijaProvider() : super("Pozicija");

  @override
  Pozicija fromJson(data) {
    return Pozicija.fromJson(data);
  }
}

Map<String, String> createHeadersLogIn() {
  String username = Authorization.username ?? "";
  String password = Authorization.password ?? "";

  String basicAuth =
      "Basic ${base64Encode(utf8.encode('$username:$password'))}";

  var headers = {
    "Content-Type": "application/json",
    "Authorization": basicAuth
  };

  return headers;
}

Future<String> fetchPozicijaZaKorisnika(int? korisnikId) async {
  var url = "${Authorization.putanja}Pozicija/$korisnikId";
  var uri = Uri.parse(url);

  var headers = createHeadersLogIn();
  var response = await http.get(uri, headers: headers);
  try {
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      var nazivPozicije = data['naziv'];
      return nazivPozicije ?? '';
    } else {
      throw Exception(
          'Failed to load uloge za korisnika $korisnikId. Status code: ${response.statusCode}');
    }
  } catch (e) {
    throw Exception('Failed to load uloge za korisnika $korisnikId');
  }
}
