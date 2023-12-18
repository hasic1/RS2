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
  var url = "https://localhost:7097/Korisnici/uloga/$korisnikId";
  var uri = Uri.parse(url);

  try {
    var response = await http.get(uri);

    if (response.statusCode == 200) {
      // Ako odgovor nije JSON, direktorijalno ga koristite kao string
      return response.body;
    } else {
      throw Exception(
          'Failed to load uloge za korisnika $korisnikId. Status code: ${response.statusCode}');
    }
  } catch (e) {
    print('Exception during uloge fetch: $e');
    throw Exception('Failed to load uloge za korisnika $korisnikId');
  }
}
