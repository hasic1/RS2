import 'package:jamfix_admin/models/statusZahtjeva.dart';
import 'package:json_annotation/json_annotation.dart';

part 'zahtjev.g.dart';

@JsonSerializable()
class Zahtjev {
  int? zahtjevId;
  String? imePrezime;
  String? opis;
  String? adresa;
  DateTime? datumVrijeme;
  String? brojTelefona;
  bool? hitnaIntervencija;
  StatusZahtjeva? statusZahtjeva;
  int? statusZahtjevaId;

  Zahtjev(
      {this.imePrezime,
      this.zahtjevId,
      this.adresa,
      this.brojTelefona,
      this.opis,
      this.datumVrijeme,
      this.hitnaIntervencija,
      this.statusZahtjeva,
      this.statusZahtjevaId});

  factory Zahtjev.fromJson(Map<String, dynamic> json) =>
      _$ZahtjevFromJson(json);

  Map<String, dynamic> toJson() => _$ZahtjevToJson(this);
}
