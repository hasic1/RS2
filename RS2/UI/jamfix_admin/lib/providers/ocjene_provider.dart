import 'package:jamfix_admin/models/ocjena.dart';
import 'package:jamfix_admin/providers/base_provider.dart';

class OcjeneProvider extends BaseProvider<Ocjene> {
  OcjeneProvider() : super("Ocjene");

  @override
  Ocjene fromJson(data) {
    return Ocjene.fromJson(data);
  }
}
