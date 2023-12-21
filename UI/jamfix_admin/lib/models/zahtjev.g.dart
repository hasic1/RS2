// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'zahtjev.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Zahtjev _$ZahtjevFromJson(Map<String, dynamic> json) => Zahtjev(
      zahtjevId: json['zahtjevId'] as int?,
      adresa: json['adresa'] as String?,
      brojTelefona: json['brojTelefona'] as String?,
      opis: json['opis'] as String?,
      datumVrijeme: json['datumVrijeme'] == null
          ? null
          : DateTime.parse(json['datumVrijeme'] as String),
      hitnaIntervencija: json['hitnaIntervencija'] as bool?,
    );

Map<String, dynamic> _$ZahtjevToJson(Zahtjev instance) => <String, dynamic>{
      'zahtjevId': instance.zahtjevId,
      'adresa': instance.adresa,
      'brojTelefona': instance.brojTelefona,
      'opis': instance.opis,
      'datumVrijeme': instance.datumVrijeme?.toIso8601String(),
      'hitnaIntervencija': instance.hitnaIntervencija,
    };
