// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'konkurs.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Konkurs _$KonkursFromJson(Map<String, dynamic> json) => Konkurs(
      konkursId: json['konkursId'] as int?,
      datumZavrsetka: json['datumZavrsetka'] == null
          ? null
          : DateTime.parse(json['datumZavrsetka'] as String),
      trazenaPozicija: json['trazenaPozicija'] as String?,
      brojIzvrsitelja: json['brojIzvrsitelja'] as int?,
    );

Map<String, dynamic> _$KonkursToJson(Konkurs instance) => <String, dynamic>{
      'konkursId': instance.konkursId,
      'datumZavrsetka': instance.datumZavrsetka?.toIso8601String(),
      'trazenaPozicija': instance.trazenaPozicija,
      'brojIzvrsitelja': instance.brojIzvrsitelja,
    };
