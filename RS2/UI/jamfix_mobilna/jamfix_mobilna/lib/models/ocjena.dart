import 'package:json_annotation/json_annotation.dart';

part 'ocjena.g.dart';

@JsonSerializable()
class Ocjene {
  int? ocjenaId;
  int? proizvodId;
  DateTime? datum;
  int? ocjena;

  Ocjene({this.ocjenaId, this.proizvodId, this.datum, this.ocjena});

  factory Ocjene.fromJson(Map<String, dynamic> json) => _$OcjeneFromJson(json);

  Map<String, dynamic> toJson() => _$OcjeneToJson(this);
}
