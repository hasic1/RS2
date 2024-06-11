import 'package:json_annotation/json_annotation.dart';

part 'prijavljivanje.g.dart';

@JsonSerializable()
class Prijavljivanje {
  int? prijavaId;
  int? konkursId;
  String? ime;
  String? prezime;
  String? email;
  String? brojTelefona;
  DateTime? datumPrijave;

  Prijavljivanje(
      {this.prijavaId,
      this.konkursId,
      this.ime,
      this.prezime,
      this.email,
      this.brojTelefona,
      this.datumPrijave});

  factory Prijavljivanje.fromJson(Map<String, dynamic> json) =>
      _$PrijavljivanjeFromJson(json);

  Map<String, dynamic> toJson() => _$PrijavljivanjeToJson(this);
}
