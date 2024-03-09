import 'package:http/http.dart' as http;
import 'package:jamfix_admin/models/korisnici.dart';
import 'package:jamfix_admin/providers/base_provider.dart';

class KorisniciProvider extends BaseProvider<Korisnici> {
  KorisniciProvider() : super("Korisnici");

  @override
  Korisnici fromJson(data) {
    return Korisnici.fromJson(data);
  }
}

Future<String> fetchUlogeZaKorisnika(int? korisnikId) async {
  var url = "https://localhost:7097/Korisnici/uloga/$korisnikId";
  var uri = Uri.parse(url);

  try {
    var response = await http.get(uri);

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
