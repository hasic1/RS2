import 'package:jamfix_admin/models/radni_nalog.dart';
import 'package:jamfix_admin/providers/base_provider.dart';

class RadniNalogProvider extends BaseProvider<RadniNalog> {
  RadniNalogProvider() : super("RadniNalog");

  @override
  RadniNalog fromJson(data) {
    return RadniNalog.fromJson(data);
  }
}