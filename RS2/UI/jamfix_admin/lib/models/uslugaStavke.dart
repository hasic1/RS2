import 'package:json_annotation/json_annotation.dart';

part 'uslugaStavke.g.dart';

@JsonSerializable()
class UslugaStavke {
  int? proizvodId;
  int? uslugeId;

  UslugaStavke({
    this.proizvodId,
    this.uslugeId,
  });

  factory UslugaStavke.fromJson(Map<String, dynamic> json) => _$UslugaStavkeFromJson(json);

  Map<String, dynamic> toJson() => _$UslugaStavkeToJson(this);
}
