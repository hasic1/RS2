import 'package:jamfix_admin/models/drzava.dart';
import 'package:json_annotation/json_annotation.dart';

part 'korisnici.g.dart';

@JsonSerializable()
class Korisnici {
  int? korisnikId;
  String? ime;
  String? prezime;
  String? email;
  String? telefon;
  String? korisnickoIme;
  String? password;
  String? noviPassword;
  String? passwordPotvrda;
  int? drzavaId;
  Drzava? drzava;
  bool? aktivnost;
  int? pozicijaId;
  DateTime? datumRodjenja;
  String? transakcijskiRacun;
  Korisnici(
      {this.korisnikId,
      this.ime,
      this.prezime,
      this.telefon,
      this.email,
      this.korisnickoIme,
      this.password,
      this.noviPassword,
      this.passwordPotvrda,
      this.drzavaId,
      this.drzava,
      this.aktivnost,
      this.pozicijaId,
      this.datumRodjenja,
      this.transakcijskiRacun});

  factory Korisnici.fromJson(Map<String, dynamic> json) =>
      _$KorisniciFromJson(json);

  Map<String, dynamic> toJson() => _$KorisniciToJson(this);
}
