import 'package:jamfix_admin/models/uloge.dart';
import 'package:jamfix_admin/providers/base_provider.dart';

class UlogeProvider extends BaseProvider<Uloge> {
  UlogeProvider() : super("Uloge");

  @override
  Uloge fromJson(data) {
    return Uloge.fromJson(data);
  }
}
