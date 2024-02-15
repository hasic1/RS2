import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'dart:convert';
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
  static int? pozicijaID;

  static void setJwtToken(String token) {
    jwtToken = token;

    Map<String, dynamic>? decodedToken = Jwt.parseJwt(token);
    // Postavljanje isAdmin na true ako korisnik ima ulogu administratora
    List<dynamic> roles = decodedToken?['role'] ?? [];
    isAdmin = roles.contains('Administrator');
    isZaposlenik = roles.contains('Zaposlenik');
    isKorisnik = roles.contains('Korisnik');

    ime = decodedToken?['unique_name'] as String?;
    prezime = decodedToken?['family_name'] as String?;
    id = int.tryParse(decodedToken?['nameid']?.toString() ?? "");
    email = decodedToken?['email'] as String?;
    telefon = decodedToken?['certpublickey'] as String?;
    korisnickoIme = decodedToken?['actort'] as String?;
    pozicijaID= int.tryParse(decodedToken?['upn']?.toString() ?? "");
    if (isAdmin) {
      print('Korisnik je administrator.');
      rola = "Administrator";
    }
    if (isZaposlenik) {
      print('Korisnik je zaposlenik.');
      rola = "Zaposlenik";
    }
    if (isKorisnik) {
      print(decodedToken);
      print('Nije ni admin ni zaposleni nego korisnik.');
      rola = "Korisnik";
    }
    if (isOperater) {
      print("Ovo je operater");
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
    throw Exception("Pogresna sifra ili korisnicko ime");
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

bool isValidInsertUpdate(Response response) {
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
    throw Exception("Niste unijeli pravilno podatke");
  } else {
    throw Exception("Exception... handle this gracefully");
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
