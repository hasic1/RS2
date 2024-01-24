// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'zahtjev.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Zahtjev _$ZahtjevFromJson(Map<String, dynamic> json) => Zahtjev(
      imePrezime: json['imePrezime'] as String?,
      zahtjevId: json['zahtjevId'] as int?,
      adresa: json['adresa'] as String?,
      brojTelefona: json['brojTelefona'] as String?,
      opis: json['opis'] as String?,
      datumVrijeme: json['datumVrijeme'] == null
          ? null
          : DateTime.parse(json['datumVrijeme'] as String),
      hitnaIntervencija: json['hitnaIntervencija'] as bool?,
      statusZahtjeva: json['statusZahtjeva'] == null
          ? null
          : StatusZahtjeva.fromJson(
              json['statusZahtjeva'] as Map<String, dynamic>),
      statusZahtjevaId: json['statusZahtjevaId'] as int?,
    );

Map<String, dynamic> _$ZahtjevToJson(Zahtjev instance) => <String, dynamic>{
      'zahtjevId': instance.zahtjevId,
      'imePrezime': instance.imePrezime,
      'opis': instance.opis,
      'adresa': instance.adresa,
      'datumVrijeme': instance.datumVrijeme?.toIso8601String(),
      'brojTelefona': instance.brojTelefona,
      'hitnaIntervencija': instance.hitnaIntervencija,
      'statusZahtjeva': instance.statusZahtjeva,
      'statusZahtjevaId': instance.statusZahtjevaId,
    };
