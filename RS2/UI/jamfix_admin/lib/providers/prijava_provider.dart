import 'package:jamfix_admin/models/prijavljivanje.dart';
import 'package:jamfix_admin/providers/base_provider.dart';

class PrijavaProvider extends BaseProvider<Prijavljivanje> {
  PrijavaProvider() : super("Prijava");

  @override
  Prijavljivanje fromJson(data) {
    return Prijavljivanje.fromJson(data);
  }
}
