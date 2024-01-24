// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Product _$ProductFromJson(Map<String, dynamic> json) => Product(
      json['proizvodId'] as int?,
      json['nazivProizvoda'] as String?,
      (json['cijena'] as num?)?.toDouble(),
      json['opis'] as String?,
      json['slika'] as String?,
      json['snizen'] as bool?,
      json['vrstaId'] as int?,
      json['brojKanala'] as String?,
      json['brojMinuta'] as String?,
      json['brzinaInterneta'] as String?,
      (json['prosjecnaOcjena'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
      'proizvodId': instance.proizvodId,
      'nazivProizvoda': instance.nazivProizvoda,
      'cijena': instance.cijena,
      'opis': instance.opis,
      'slika': instance.slika,
      'snizen': instance.snizen,
      'vrstaId': instance.vrstaId,
      'brzinaInterneta': instance.brzinaInterneta,
      'brojMinuta': instance.brojMinuta,
      'brojKanala': instance.brojKanala,
      'prosjecnaOcjena': instance.prosjecnaOcjena,
    };
