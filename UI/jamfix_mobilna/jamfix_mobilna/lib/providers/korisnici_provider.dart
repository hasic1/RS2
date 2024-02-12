import 'package:jamfix_mobilna/models/korisnici.dart';
import 'package:jamfix_mobilna/providers/base_provider.dart';

class KorisniciProvider extends BaseProvider<Korisnici> {
  KorisniciProvider() : super("Korisnici");

  @override
  Korisnici fromJson(data) {
    // TODO: implement fromJson
    return Korisnici.fromJson(data);
  }
}