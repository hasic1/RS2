import 'package:json_annotation/json_annotation.dart';

part 'drzava.g.dart';

@JsonSerializable()
class Drzava {
  int? drzavaId;
  String? naziv;
  
  Drzava(
      {this.drzavaId, this.naziv});

  factory Drzava.fromJson(Map<String, dynamic> json) =>
      _$DrzavaFromJson(json);

  Map<String, dynamic> toJson() => _$DrzavaToJson(this);
}
