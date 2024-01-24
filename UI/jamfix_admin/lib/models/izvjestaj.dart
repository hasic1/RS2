import 'package:json_annotation/json_annotation.dart';

part 'izvjestaj.g.dart';

@JsonSerializable()
class Izvjestaj {
  int? izvjestajId;
  int? brojIntervencija;
  String? najPosMjesto;
  int? cijenaUtrosAlata;
  String? najOprema;
  DateTime? datum;

  Izvjestaj(
      {this.izvjestajId,
      this.brojIntervencija,
      this.cijenaUtrosAlata,
      this.najOprema,
      this.najPosMjesto,this.datum});

  factory Izvjestaj.fromJson(Map<String, dynamic> json) =>
      _$IzvjestajFromJson(json);

  Map<String, dynamic> toJson() => _$IzvjestajToJson(this);
}
