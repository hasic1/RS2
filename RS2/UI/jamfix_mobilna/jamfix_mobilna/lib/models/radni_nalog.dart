import 'package:json_annotation/json_annotation.dart';

part 'radni_nalog.g.dart';

@JsonSerializable()
class RadniNalog {
  int? nalogId;
  String? nosilacPosla;
  String? opisPrijavljenog;
  String? opisUradjenog;
  String? imePrezime;
  String? telefon;
  DateTime? datum;
  String? adresa;
  String? mjesto;
  String? naziv;
  int? kolicina;
  RadniNalog({this.nalogId,
      this.nosilacPosla,
      this.opisPrijavljenog,
      this.opisUradjenog,
      this.imePrezime,
      this.telefon,
      this.datum,
      this.adresa,
      this.mjesto,
      this.naziv,
      this.kolicina});

  factory RadniNalog.fromJson(Map<String, dynamic> json) =>
      _$RadniNalogFromJson(json);

  Map<String, dynamic> toJson() => _$RadniNalogToJson(this);
}
