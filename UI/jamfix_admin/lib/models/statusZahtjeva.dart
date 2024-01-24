import 'package:json_annotation/json_annotation.dart';

part 'statusZahtjeva.g.dart';

@JsonSerializable()
class StatusZahtjeva{
int?  statusZahtjevaId;
String? opis;

StatusZahtjeva({this.statusZahtjevaId,this.opis});

factory StatusZahtjeva.fromJson(Map<String,dynamic>json)=>_$StatusZahtjevaFromJson(json);

Map<String,dynamic>toJson()=> _$StatusZahtjevaToJson(this);
}