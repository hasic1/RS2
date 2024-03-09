import 'package:jamfix_admin/models/novosti.dart';
import 'package:jamfix_admin/providers/base_provider.dart';

class NovostiProvider extends BaseProvider<Novosti> {
  NovostiProvider() : super("Novosti");

  @override
  Novosti fromJson(data) {
    return Novosti.fromJson(data);
  }
}
