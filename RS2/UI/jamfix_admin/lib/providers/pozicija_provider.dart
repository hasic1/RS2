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

Future<String> fetchPozicijaZaKorisnika(int? korisnikId) async {
  var url = "${Authorization.putanja}Pozicija/$korisnikId";
  var uri = Uri.parse(url);

  try {
    var response = await http.get(uri);

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
