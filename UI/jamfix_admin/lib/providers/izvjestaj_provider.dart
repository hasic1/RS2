import 'package:jamfix_admin/models/drzava.dart';
import 'package:jamfix_admin/models/izvjestaj.dart';
import 'package:jamfix_admin/providers/base_provider.dart';

class IzvjestajProvider extends BaseProvider<Izvjestaj> {
  IzvjestajProvider() : super("Izvjestaji");

  @override
  Izvjestaj fromJson(data) {
    return Izvjestaj.fromJson(data);
  }
}
