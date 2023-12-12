// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'korisnici.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Korisnici _$KorisniciFromJson(Map<String, dynamic> json) => Korisnici(
      json['korisnikId'] as int?,
      json['ime'] as String?,
      json['prezime'] as String?,
      json['telefon'] as String?,
      json['email'] as String?,
    );

Map<String, dynamic> _$KorisniciToJson(Korisnici instance) => <String, dynamic>{
      'korisnikId': instance.korisnikId,
      'ime': instance.ime,
      'prezime': instance.prezime,
      'telefon': instance.telefon,
      'email': instance.email,
    };
