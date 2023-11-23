import 'package:json_annotation/json_annotation.dart';

part 'product.g.dart';

@JsonSerializable()
class Product{
int?  proizvodId;
String? nazivProizvoda;
double? cijena;
String? opis;

Product(this.proizvodId,this.nazivProizvoda,this.cijena,this.opis);

factory Product.fromJson(Map<String,dynamic>json)=>_$ProductFromJson(json);

Map<String,dynamic>toJson()=> _$ProductToJson(this);
}

// "proizvodId": 1,
//     "nazivProizvoda": "Bakir",
//     "cijena": 0,
//     "opis": "dobar",
//     "lokacijaSlike": "string",
//     "snizen": true,
//     "stateMachine": null