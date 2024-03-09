import 'package:jamfix_mobilna/models/radni_nalog.dart';
import 'package:jamfix_mobilna/providers/base_provider.dart';

class RadniNalogProvider extends BaseProvider<RadniNalog> {
  RadniNalogProvider() : super("RadniNalog");

  @override
  RadniNalog fromJson(data) {
    return RadniNalog.fromJson(data);
  }
}