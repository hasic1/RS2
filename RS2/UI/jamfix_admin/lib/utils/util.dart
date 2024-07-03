import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:jwt_decode/jwt_decode.dart';

class Authorization {
  static String? username;
  static String? password;
  static String? jwtToken;
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
  static int? drzavaID;
  static String? brojRacuna;
  static String? psw;
  static DateTime? datumRodjenja;
  static const String putanja = "http://localhost:7097/";
  static const String putanjaTestni = "http://localhost:7108/";

  static void setJwtToken(String token) {
    jwtToken = token;

    Map<String, dynamic>? decodedToken = Jwt.parseJwt(token);
    List<dynamic> roles = decodedToken['role'] ?? [];
    isAdmin = roles.contains('Administrator');
    isZaposlenik = roles.contains('Zaposlenik');
    isKorisnik = roles.contains('Korisnik');
    isOperater = roles.contains('Operater');

    ime = decodedToken['unique_name'] as String?;
    prezime = decodedToken['family_name'] as String?;
    id = int.tryParse(decodedToken['nameid']?.toString() ?? "");
    email = decodedToken['email'] as String?;
    telefon = decodedToken['certpublickey'] as String?;
    korisnickoIme = decodedToken['actort'] as String?;
    pozicijaID = int.tryParse(decodedToken['upn']?.toString() ?? "");
    drzavaID = int.tryParse(decodedToken['certserialnumber']?.toString() ?? "");
    brojRacuna = decodedToken['gender'] as String?;
    String? birthdateString = decodedToken['birthdate'] as String?;
    if (birthdateString != null) {
      try {
        final dateFormat = DateFormat('dd. MM. yyyy. HH:mm:ss');
        datumRodjenja = dateFormat.parse(birthdateString);
      } catch (e) {
        datumRodjenja = null;
        print('Greška prilikom parsiranja datuma: $e');
      }
    } else {
      datumRodjenja = null;
    }

    if (isAdmin) {
      rola = "Administrator";
      print(datumRodjenja);
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
