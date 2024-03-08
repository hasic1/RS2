
import 'package:json_annotation/json_annotation.dart';

part 'usluge.g.dart';

@JsonSerializable()
class Usluge {
  int? uslugaId;
  String? imePrezime;
  DateTime? datum;
  String? brojRacuna;
  String? nazivPaketa;
  String? cijena;
  int? proizvodId;


  Usluge(
      {this.uslugaId,
      this.imePrezime,
      this.datum,
      this.brojRacuna,
      this.cijena,
      this.nazivPaketa,this.proizvodId});

  factory Usluge.fromJson(Map<String, dynamic> json) => _$UslugeFromJson(json);

  Map<String, dynamic> toJson() => _$UslugeToJson(this);
}
