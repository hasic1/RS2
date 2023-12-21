import 'package:json_annotation/json_annotation.dart';

part 'zahtjev.g.dart';

@JsonSerializable()
class Zahtjev{
int?  zahtjevId;
String? adresa;
String? brojTelefona; 
String? opis;
DateTime? datumVrijeme; 
bool? hitnaIntervencija; 

Zahtjev({this.zahtjevId,this.adresa,this.brojTelefona,this.opis,this.datumVrijeme,this.hitnaIntervencija});

factory Zahtjev.fromJson(Map<String,dynamic>json)=>_$ZahtjevFromJson(json);

Map<String,dynamic>toJson()=> _$ZahtjevToJson(this);
}