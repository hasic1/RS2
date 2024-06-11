import 'package:jamfix_admin/models/konkurs.dart';
import 'package:jamfix_admin/providers/base_provider.dart';

class KonkursProvider extends BaseProvider<Konkurs> {
  KonkursProvider() : super("Konkurs");

  @override
  Konkurs fromJson(data) {
    return Konkurs.fromJson(data);
  }
}
