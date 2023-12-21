import 'package:jamfix_admin/models/zahtjev.dart';
import 'package:jamfix_admin/providers/base_provider.dart';
import 'package:jamfix_admin/screens/zahtijev_list.screen.dart';

class ZahtjevProvider extends BaseProvider<Zahtjev> {
  ZahtjevProvider() : super("Zahtjevi");

  @override
  Zahtjev fromJson(data) {
    // TODO: implement fromJson
    return Zahtjev.fromJson(data);
  }
}