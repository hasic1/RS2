import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:jamfix_admin/utils/util.dart';

class ProductProvider with ChangeNotifier {
  static String? _baseUrl;
  String _endpoint = "Proizvodi";

  ProductProvider() {
    _baseUrl = const String.fromEnvironment("baseUrl",
        defaultValue: "https://localhost:7097/");
  }
  Future<dynamic> get() async {
    var url = "$_baseUrl$_endpoint";

    var uri = Uri.parse(url);
    var headers = createHeaders();

    var response = await http.get(uri, headers: headers);
    //print("response:${response.request},${response.body}");
    print("Status code:${response.statusCode}");
    if (isValidResponse(response)) {
      var data = jsonDecode(response.body);
      return data;
    } else {
      throw new Exception("Unknown error");
    }
  }

  bool isValidResponse(Response response) {
    if (response.statusCode < 299) {
      return true;
    } 
    else if (response.statusCode == 401) {
      throw new Exception("Unauthorized");
    } 
    else {
      throw new Exception("Something bad happend");
    }
  }

  Map<String, String> createHeaders() {
    String username = Authorization.username ?? "";
    String password = Authorization.password ?? "";

    print("passed creds; $username,$password");

    String basicAuth =
        "Basic ${base64Encode(utf8.encode('$username:$password'))}";
    var headers = {
      "Content-Type": "application/json",
      "Authorization": basicAuth
    };
    return headers;
  }
}
