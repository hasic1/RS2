// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'izvjestaj.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Izvjestaj _$IzvjestajFromJson(Map<String, dynamic> json) => Izvjestaj(
      izvjestajId: json['izvjestajId'] as int?,
      brojIntervencija: json['brojIntervencija'] as int?,
      cijenaUtrosAlata: json['cijenaUtrosAlata'] as int?,
      najOprema: json['najOprema'] as String?,
      najPosMjesto: json['najPosMjesto'] as String?,
      datum: json['datum'] == null
          ? null
          : DateTime.parse(json['datum'] as String),
    );

Map<String, dynamic> _$IzvjestajToJson(Izvjestaj instance) => <String, dynamic>{
      'izvjestajId': instance.izvjestajId,
      'brojIntervencija': instance.brojIntervencija,
      'najPosMjesto': instance.najPosMjesto,
      'cijenaUtrosAlata': instance.cijenaUtrosAlata,
      'najOprema': instance.najOprema,
      'datum': instance.datum?.toIso8601String(),
    };
