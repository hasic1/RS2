// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'korisnici_uloge.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

KorisniciUloge _$KorisniciUlogeFromJson(Map<String, dynamic> json) =>
    KorisniciUloge(
      datumIzmjene: json['datumIzmjene'] == null
          ? null
          : DateTime.parse(json['datumIzmjene'] as String),
      korisnikId: json['korisnikId'] as int?,
      korisnikUlogaId: json['korisnikUlogaId'] as int?,
      ulogaId: json['ulogaId'] as int?,
    );

Map<String, dynamic> _$KorisniciUlogeToJson(KorisniciUloge instance) =>
    <String, dynamic>{
      'korisnikUlogaId': instance.korisnikUlogaId,
      'korisnikId': instance.korisnikId,
      'ulogaId': instance.ulogaId,
      'datumIzmjene': instance.datumIzmjene?.toIso8601String(),
    };
