// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'usluge.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Usluge _$UslugeFromJson(Map<String, dynamic> json) => Usluge(
      uslugaId: json['uslugaId'] as int?,
      imePrezime: json['imePrezime'] as String?,
      datum: json['datum'] == null
          ? null
          : DateTime.parse(json['datum'] as String),
      brojRacuna: json['brojRacuna'] as String?,
      cijena: json['cijena'] as String?,
      nazivPaketa: json['nazivPaketa'] as String?,
    );

Map<String, dynamic> _$UslugeToJson(Usluge instance) => <String, dynamic>{
      'uslugaId': instance.uslugaId,
      'imePrezime': instance.imePrezime,
      'datum': instance.datum?.toIso8601String(),
      'brojRacuna': instance.brojRacuna,
      'nazivPaketa': instance.nazivPaketa,
      'cijena': instance.cijena,
    };
