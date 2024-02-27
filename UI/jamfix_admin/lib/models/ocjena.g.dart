// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ocjena.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Ocjene _$OcjeneFromJson(Map<String, dynamic> json) => Ocjene(
      ocjenaId: json['ocjenaId'] as int?,
      proizvodId: json['proizvodId'] as int?,
      datum: json['datum'] == null
          ? null
          : DateTime.parse(json['datum'] as String),
      ocjena: json['ocjena'] as int?,
    );

Map<String, dynamic> _$OcjeneToJson(Ocjene instance) => <String, dynamic>{
      'ocjenaId': instance.ocjenaId,
      'proizvodId': instance.proizvodId,
      'datum': instance.datum?.toIso8601String(),
      'ocjena': instance.ocjena,
    };
