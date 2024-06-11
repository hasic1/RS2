import 'package:json_annotation/json_annotation.dart';

part 'prijava.g.dart';

@JsonSerializable()
class Prijava {
  int? prijavaId;
  int? konkursId;
  String? ime;
  String? prezime;
  String? email;
  String? brojTelefona;
  DateTime? datumPrijave;

  Prijava(
      {this.prijavaId,
      this.konkursId,
      this.ime,
      this.prezime,
      this.email,
      this.brojTelefona,
      this.datumPrijave});

  factory Prijava.fromJson(Map<String, dynamic> json) =>
      _$PrijavaFromJson(json);

  Map<String, dynamic> toJson() => _$PrijavaToJson(this);
}
