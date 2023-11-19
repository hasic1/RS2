import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ProductProvider with ChangeNotifier{
  static String? _baseURL;
String _endpoint = "Proizvodi";

  ProductProvider()
  {
    _baseURL=const String.fromEnvironment("baseURL",defaultValue: "https://localhost:7097/");
  }
  Future<dynamic> get() async{
    var url="$_baseURL$_endpoint";
    
    var uri =Uri.parse(url);
    var headers= createHeaders();    

    var response=http.get(uri,headers: headers);
    var data=jsonDecode(response.body);

    return data;
  }

  

  Map<String,String> createHeaders(){
    String username="admin";
    String password="dest";

    String basicAuth="Basic ${base64Encode(utf8.encode('$username:$password'))}";
    var headers={
      "Content-Type":"application/json",
      "Authorization":basicAuth
    };
    return headers;
  }
}