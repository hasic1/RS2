import 'package:json_annotation/json_annotation.dart';

part 'uloge.g.dart';

@JsonSerializable()
class Uloge {
  int? ulogaId;
  String? naziv;
  String? opis;

  Uloge({
    this.ulogaId,
    this.naziv,
    this.opis,
  });

  factory Uloge.fromJson(Map<String, dynamic> json) => _$UlogeFromJson(json);

  Map<String, dynamic> toJson() => _$UlogeToJson(this);
}
