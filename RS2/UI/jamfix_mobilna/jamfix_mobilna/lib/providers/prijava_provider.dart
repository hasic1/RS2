import 'package:jamfix_mobilna/models/prijava.dart';
import 'package:jamfix_mobilna/providers/base_provider.dart';

class PrijavaProvider extends BaseProvider<Prijava> {
  PrijavaProvider() : super("Prijava");

  @override
  Prijava fromJson(data) {
    return Prijava.fromJson(data);
  }
}
