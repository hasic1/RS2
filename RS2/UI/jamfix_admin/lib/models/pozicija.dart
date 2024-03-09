import 'package:json_annotation/json_annotation.dart';

part 'pozicija.g.dart';

@JsonSerializable()
class Pozicija {
  int? pozicijaId;
  String? naziv;

  Pozicija({this.pozicijaId, this.naziv});

  factory Pozicija.fromJson(Map<String, dynamic> json) =>
      _$PozicijaFromJson(json);

  Map<String, dynamic> toJson() => _$PozicijaToJson(this);
}
