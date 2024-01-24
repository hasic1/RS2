// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'radni_nalog.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RadniNalog _$RadniNalogFromJson(Map<String, dynamic> json) => RadniNalog(
      nalogId: json['nalogId'] as int?,
      nosilacPosla: json['nosilacPosla'] as String?,
      opisPrijavljenog: json['opisPrijavljenog'] as String?,
      opisUradjenog: json['opisUradjenog'] as String?,
      imePrezime: json['imePrezime'] as String?,
      telefon: json['telefon'] as String?,
      datum: json['datum'] == null
          ? null
          : DateTime.parse(json['datum'] as String),
      adresa: json['adresa'] as String?,
      mjesto: json['mjesto'] as String?,
      naziv: json['naziv'] as String?,
      kolicina: json['kolicina'] as int?,
    );

Map<String, dynamic> _$RadniNalogToJson(RadniNalog instance) =>
    <String, dynamic>{
      'nalogId': instance.nalogId,
      'nosilacPosla': instance.nosilacPosla,
      'opisPrijavljenog': instance.opisPrijavljenog,
      'opisUradjenog': instance.opisUradjenog,
      'imePrezime': instance.imePrezime,
      'telefon': instance.telefon,
      'datum': instance.datum?.toIso8601String(),
      'adresa': instance.adresa,
      'mjesto': instance.mjesto,
      'naziv': instance.naziv,
      'kolicina': instance.kolicina,
    };
