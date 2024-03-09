import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:jamfix_mobilna/models/drzava.dart';
import 'package:jamfix_mobilna/providers/base_provider.dart';

class DrzavaProvider extends BaseProvider<Drzava> {
  DrzavaProvider() : super("Drzava");

  @override
  Drzava fromJson(dynamic data) {
    return Drzava.fromJson(data as Map<String, dynamic>);
  }
}
