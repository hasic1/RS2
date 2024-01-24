import 'package:json_annotation/json_annotation.dart';

part 'product.g.dart';

@JsonSerializable()
class Product {
  int? proizvodId;
  String? nazivProizvoda;
  double? cijena;
  String? opis;
  String? slika;
  bool? snizen;
  int? vrstaId;
  String? brzinaInterneta;
  String? brojMinuta;
  String? brojKanala;
  double? prosjecnaOcjena;

  Product(
      this.proizvodId,
      this.nazivProizvoda,
      this.cijena,
      this.opis,
      this.slika,
      this.snizen,
      this.vrstaId,
      this.brojKanala,
      this.brojMinuta,
      this.brzinaInterneta,this.prosjecnaOcjena);

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);

  Map<String, dynamic> toJson() => _$ProductToJson(this);
}
