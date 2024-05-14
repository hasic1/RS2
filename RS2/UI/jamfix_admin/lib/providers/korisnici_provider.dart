import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:jamfix_admin/models/korisnici.dart';
import 'package:jamfix_admin/providers/base_provider.dart';
import 'package:jamfix_admin/utils/util.dart';

class KorisniciProvider extends BaseProvider<Korisnici> {
  KorisniciProvider() : super("Korisnici");

  @override
  Korisnici fromJson(data) {
    return Korisnici.fromJson(data);
  }
}

Future<String> fetchUlogeZaKorisnika(int? korisnikId) async {
  var url = "${Authorization.putanja}Korisnici/uloga/$korisnikId";
  var uri = Uri.parse(url);
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

  try {
    var headers = createHeadersLogIn();
    var response = await http.get(uri, headers: headers);
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception(
          'Failed to load uloge za korisnika $korisnikId. Status code: ${response.statusCode}');
    }
  } catch (e) {
    throw Exception('Failed to load uloge za korisnika $korisnikId');
  }
}
