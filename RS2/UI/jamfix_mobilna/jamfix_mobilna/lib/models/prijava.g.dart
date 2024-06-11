// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'prijava.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Prijava _$PrijavaFromJson(Map<String, dynamic> json) => Prijava(
      prijavaId: json['prijavaId'] as int?,
      konkursId: json['konkursId'] as int?,
      ime: json['ime'] as String?,
      prezime: json['prezime'] as String?,
      email: json['email'] as String?,
      brojTelefona: json['brojTelefona'] as String?,
      datumPrijave: json['datumPrijave'] == null
          ? null
          : DateTime.parse(json['datumPrijave'] as String),
    );

Map<String, dynamic> _$PrijavaToJson(Prijava instance) => <String, dynamic>{
      'prijavaId': instance.prijavaId,
      'konkursId': instance.konkursId,
      'ime': instance.ime,
      'prezime': instance.prezime,
      'email': instance.email,
      'brojTelefona': instance.brojTelefona,
      'datumPrijave': instance.datumPrijave?.toIso8601String(),
    };
