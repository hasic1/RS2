// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'korisnici.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Korisnici _$KorisniciFromJson(Map<String, dynamic> json) => Korisnici(
      korisnikId: json['korisnikId'] as int?,
      ime: json['ime'] as String?,
      prezime: json['prezime'] as String?,
      email: json['email'] as String?,
      telefon: json['telefon'] as String?,
      korisnickoIme: json['korisnickoIme'] as String?,
      password: json['password'] as String?,
      noviPassword: json['noviPassword'] as String?,
      passwordPotvrda: json['passwordPotvrda'] as String?,
      drzavaId: json['drzavaId'] as int?,
      drzava: json['drzava'] == null
          ? null
          : Drzava.fromJson(json['drzava'] as Map<String, dynamic>),
      aktivnost: json['aktivnost'] as bool?,
      pozicijaId: json['pozicijaId'] as int?,
      status: json['status'] as bool?,
      datumVrijeme: json['datumVrijeme'] == null
          ? null
          : DateTime.parse(json['datumVrijeme'] as String),
      transakcijskiRacun: json['transakcijskiRacun'] as String?,
    );

Map<String, dynamic> _$KorisniciToJson(Korisnici instance) => <String, dynamic>{
      'korisnikId': instance.korisnikId,
      'ime': instance.ime,
      'prezime': instance.prezime,
      'email': instance.email,
      'telefon': instance.telefon,
      'korisnickoIme': instance.korisnickoIme,
      'password': instance.password,
      'noviPassword': instance.noviPassword,
      'passwordPotvrda': instance.passwordPotvrda,
      'drzavaId': instance.drzavaId,
      'status': instance.status,
      'aktivnost': instance.aktivnost,
      'drzava': instance.drzava,
      'pozicijaId': instance.pozicijaId,
      'datumVrijeme': instance.datumVrijeme?.toIso8601String(),
      'transakcijskiRacun': instance.transakcijskiRacun,
    };
