import 'package:json_annotation/json_annotation.dart';

part 'korisnici_uloge.g.dart';

@JsonSerializable()
class KorisniciUloge {
  int? korisnikUlogaId;
  int? korisnikId;
  int? ulogaId;
  DateTime? datumIzmjene;

  KorisniciUloge(
      {this.datumIzmjene, this.korisnikId, this.korisnikUlogaId, this.ulogaId});

  factory KorisniciUloge.fromJson(Map<String, dynamic> json) =>
      _$KorisniciUlogeFromJson(json);

  Map<String, dynamic> toJson() => _$KorisniciUlogeToJson(this);
}
