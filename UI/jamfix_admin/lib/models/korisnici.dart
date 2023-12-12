import 'package:json_annotation/json_annotation.dart';

part 'korisnici.g.dart';

@JsonSerializable()
class Korisnici {
  int? korisnikId;
  String? ime;
  String? prezime;
  String? telefon;
  String? email;
  Korisnici(this.korisnikId, this.ime, this.prezime,this.telefon,this.email);

  factory Korisnici.fromJson(Map<String, dynamic> json) =>
      _$KorisniciFromJson(json);

  Map<String, dynamic> toJson() => _$KorisniciToJson(this);
}
