import 'package:jamfix_admin/models/uslugaStavke.dart';
import 'package:jamfix_admin/providers/base_provider.dart';

class UslugaStavkeProvider extends BaseProvider<UslugaStavke> {
  UslugaStavkeProvider() : super("UslugaStavke");

  @override
  UslugaStavke fromJson(data) {
    return UslugaStavke.fromJson(data);
  }
}
