import 'package:jamfix_mobilna/models/statusZahtjeva.dart';
import 'package:jamfix_mobilna/providers/base_provider.dart';

class StatusZahtjevaProvider extends BaseProvider<StatusZahtjeva> {
  StatusZahtjevaProvider() : super("StatusZahtjeva");

  @override
  StatusZahtjeva fromJson(data) {
    return StatusZahtjeva.fromJson(data);
  }

  Future<List<StatusZahtjeva>> getSviStatusiZahtjeva() async {
    try {
      var result = await get();
      return result.result;
    } catch (error) {
      throw error;
    }
  }
}
