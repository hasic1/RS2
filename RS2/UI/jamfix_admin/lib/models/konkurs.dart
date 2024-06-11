import 'package:json_annotation/json_annotation.dart';

part 'konkurs.g.dart';

@JsonSerializable()
class Konkurs {
  int? konkursId;
  DateTime? datumZavrsetka;
  String? trazenaPozicija;
  int? brojIzvrsitelja;

  Konkurs({
    this.konkursId,
    this.datumZavrsetka,
    this.trazenaPozicija,
    this.brojIzvrsitelja,
  });

  factory Konkurs.fromJson(Map<String, dynamic> json) =>
      _$KonkursFromJson(json);

  Map<String, dynamic> toJson() => _$KonkursToJson(this);
}
