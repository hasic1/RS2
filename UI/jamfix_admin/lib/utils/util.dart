import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:jwt_decode/jwt_decode.dart';

class Authorization {
  static String? username;
  static String? password;
  static String? jwtToken; // Dodajte polje za JWT token
  static bool isAdmin = false;
  static bool isZaposlenik = false;
  static bool isKorisnik = false;

  static void setJwtToken(String token) {
    jwtToken = token;

    Map<String, dynamic>? decodedToken = Jwt.parseJwt(token);

    // Ispisivanje svih podataka u tokenu
    print(decodedToken);

    // Postavljanje isAdmin na true ako korisnik ima ulogu administratora
    List<dynamic> roles = decodedToken?['role'] ?? [];
    isAdmin = roles.contains('Administrator');
    isZaposlenik = roles.contains('Zaposlenik');
    isKorisnik = roles.contains('Korisnik');

    // Ispisivanje uloge korisnika
    if (isAdmin) {
      print('Korisnik je administrator.');
      print(token);
    }
    if (isZaposlenik) {
      print('Korisnik je zaposlenik.');
      print(token);
    }
    if (isKorisnik) {
      print('Nije ni admin ni zaposleni nego korisnik.');
      print(token);
    }
  }
}
bool isValidResponse(Response response) {
  if (response.statusCode < 299) {
    return true;
  } else if (response.statusCode == 401) {
      throw new Exception("Unauthorized!");
  } else {
    print(response.statusCode);
      throw new Exception("Incorrect username or password!");
  }
}

Image imageFromBase64String(String base64Image) {
  return Image.memory(base64Decode(base64Image));
}

String formatNumber(dynamic) {
  var f = NumberFormat('###,00');

  if (dynamic == null) {
    return "";
  }
  return f.format(dynamic);
}
