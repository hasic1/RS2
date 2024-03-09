import 'package:jamfix_admin/models/zahtjev.dart';
import 'package:jamfix_admin/providers/base_provider.dart';

class ZahtjevProvider extends BaseProvider<Zahtjev> {
  ZahtjevProvider() : super("Zahtjevi");

  @override
  Zahtjev fromJson(data) {
    return Zahtjev.fromJson(data);
  }
}