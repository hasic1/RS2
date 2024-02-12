import 'package:jamfix_mobilna/models/zahtjev.dart';
import 'package:jamfix_mobilna/providers/base_provider.dart';

class ZahtjevProvider extends BaseProvider<Zahtjev> {
  ZahtjevProvider() : super("Zahtjevi");

  @override
  Zahtjev fromJson(data) {
    return Zahtjev.fromJson(data);
  }
}