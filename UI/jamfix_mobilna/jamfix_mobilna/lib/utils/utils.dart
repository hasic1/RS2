import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:jwt_decode/jwt_decode.dart';

class Authorization {
  static String? username;
  static String? password;
  static String? jwtToken; // Dodajte polje za JWT token
  static bool isAdmin = false;
  static bool isZaposlenik = false;
  static bool isKorisnik = false;
  static bool isOperater = false;
  static String? ime;
  static String? prezime;
  static String? email;
  static String? telefon;
  static String? korisnickoIme;
  static String? rola;
  static int? id;

  static void setJwtToken(String token) {
    jwtToken = token;

    Map<String, dynamic>? decodedToken = Jwt.parseJwt(token);
    List<dynamic> roles = decodedToken['role'] ?? [];
    isAdmin = roles.contains('Administrator');
    isZaposlenik = roles.contains('Zaposlenik');
    isKorisnik = roles.contains('Korisnik');

    ime = decodedToken['unique_name'] as String?;
    prezime = decodedToken['family_name'] as String?;
    id = int.tryParse(decodedToken['nameid']?.toString() ?? "");
    email = decodedToken['email'] as String?;
    telefon = decodedToken['certpublickey'] as String?;
    korisnickoIme = decodedToken['actort'] as String?;

    // Ispisivanje uloge korisnika
    if (isAdmin) {
      rola = "Administrator";
    }
    if (isZaposlenik) {
      rola = "Zaposlenik";
    }
    if (isKorisnik) {
      rola = "Korisnik";
    }
    if (isOperater) {
      rola = "Operater";
    }
  }
}

bool isValidResponse(Response response) {
    if (response.statusCode == 200) {
      if (response.body != "") {
        return true;
      } else {
        return false;
      }
    } else if (response.statusCode == 204) {
      return true;
    } else if (response.statusCode == 400) {
      throw Exception("Bad request");
    } else if (response.statusCode == 401) {
      throw Exception("Unauthorized");
    } else if (response.statusCode == 403) {
      throw Exception("Forbidden");
    } else if (response.statusCode == 404) {
      throw Exception("Not found");
    } else if (response.statusCode == 500) {
      throw Exception("Internal server error");
    } else {
      throw Exception("Exception... handle this gracefully");
    }
  }

Image imageFromBase64String(String base64Image) {
  return Image.memory(base64Decode(base64Image));
}

// String formatNumber(dynamic) {
//   var f = NumberFormat('###,00');

//   if (dynamic == null) {
//     return "";
//   }
//   return f.format(dynamic);
// }
