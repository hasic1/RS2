import 'package:jamfix_admin/models/usluge.dart';
import 'package:jamfix_admin/providers/base_provider.dart';

class UslugeProvider extends BaseProvider<Usluge> {
  UslugeProvider() : super("Usluge");

  @override
  Usluge fromJson(data) {
    return Usluge.fromJson(data);
  }
}
