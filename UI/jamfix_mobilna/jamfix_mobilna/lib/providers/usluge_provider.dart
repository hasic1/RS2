import 'package:jamfix_mobilna/models/usluge.dart';
import 'package:jamfix_mobilna/providers/base_provider.dart';

class UslugeProvider extends BaseProvider<Usluge> {
  UslugeProvider() : super("Usluge");

  @override
  Usluge fromJson(data) {
    return Usluge.fromJson(data);
  }
}
