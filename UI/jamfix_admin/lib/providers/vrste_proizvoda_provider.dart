import 'package:jamfix_admin/models/vrste_proizvoda.dart';
import 'package:jamfix_admin/providers/base_provider.dart';

class VrsteProizvodaProvider extends BaseProvider<VrsteProizvoda> {
  VrsteProizvodaProvider() : super("VrsteProizvoda");

  @override
  VrsteProizvoda fromJson(data) {
    return VrsteProizvoda.fromJson(data);
  }
}
