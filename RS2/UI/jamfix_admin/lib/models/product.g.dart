// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Product _$ProductFromJson(Map<String, dynamic> json) => Product(
      proizvodId: json['proizvodId'] as int?,
      nazivProizvoda: json['nazivProizvoda'] as String?,
      cijena: json['cijena'] as int?,
      opis: json['opis'] as String?,
      slika: json['slika'] as String?,
      snizen: json['snizen'] as bool?,
      vrstaId: json['vrstaId'] as int?,
      brojKanala: json['brojKanala'] as String?,
      brojMinuta: json['brojMinuta'] as String?,
      brzinaInterneta: json['brzinaInterneta'] as String?,
      prosjecnaOcjena: (json['prosjecnaOcjena'] as num?)?.toDouble(),
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
