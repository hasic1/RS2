import 'package:json_annotation/json_annotation.dart';

part 'novosti.g.dart';

@JsonSerializable()
class Novosti {
  int? novostId;
  String? naslov;
  String? sadrzaj;
  String? slika;

  Novosti({this.novostId, this.naslov, this.sadrzaj, this.slika});
  factory Novosti.fromJson(Map<String, dynamic> json) =>
      _$NovostiFromJson(json);

  Map<String, dynamic> toJson() => _$NovostiToJson(this);
}
