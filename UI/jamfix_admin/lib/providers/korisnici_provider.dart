import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:jamfix_admin/models/korisnici.dart';
import 'package:jamfix_admin/models/product.dart';
import 'package:jamfix_admin/models/search_result.dart';
import 'package:jamfix_admin/providers/base_provider.dart';
import 'package:jamfix_admin/utils/util.dart';

class KorisniciProvider extends BaseProvider<Korisnici> {
  KorisniciProvider() : super("Korisnici");

  @override
  Korisnici fromJson(data) {
    // TODO: implement fromJson
    return Korisnici.fromJson(data);
  }
}
Future<String> fetchUlogeZaKorisnika(int? korisnikId) async {
  var url = "https://localhost:7097/api/Uloge/uloge/$korisnikId";
  var uri = Uri.parse(url);

  var response = await http.get(uri);
  if (response.statusCode == 200) {
    final List<dynamic> data = json.decode(response.body);
    if (data.isNotEmpty) {
      return data.first.toString(); // Vrati prvu ulogu iz liste
    }
  }
  throw Exception('Failed to load uloge za korisnika');
}
