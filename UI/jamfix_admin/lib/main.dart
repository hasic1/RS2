// import 'package:eprodaja_admin/models/jedinice_mjere.dart';
//import 'package:eprodaja_admin/providers/jedinice_mjere.dart';
//import 'package:eprodaja_admin/providers/product_provider.dart';
//import 'package:eprodaja_admin/providers/vrste_proizvoda.dart';
//import 'package:eprodaja_admin/utils/util.dart';
import 'dart:convert';

import 'package:jamfix_admin/providers/base_provider.dart';
import 'package:jamfix_admin/providers/korisnici_provider.dart';
import 'package:jamfix_admin/providers/product_provider.dart';
import 'package:jamfix_admin/providers/vrste_proizvoda_provider.dart';
import 'package:jamfix_admin/screens/home_screen.dart';
import 'package:jamfix_admin/screens/korisnici_list_screen.dart';
import 'package:jamfix_admin/utils/util.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import './screens/product_list_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => ProductProvider()),
      ChangeNotifierProvider(create: (_) => KorisniciProvider()),
      ChangeNotifierProvider(create: (_) => VrsteProizvodaProvider()),
    ],
    child: const MyMaterialApp(),
  ));
}

// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: LayoutExamples(), //Counter(),
//     );
//   }
// }

class MyMaterialApp extends StatelessWidget {
  const MyMaterialApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RS II Material app',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);
  TextEditingController _usernameController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();
  late ProductProvider _productProvider;

  @override
  Widget build(BuildContext context) {
    _productProvider = context.read<ProductProvider>();

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Container(
          constraints: BoxConstraints(maxWidth: 400, maxHeight: 400),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(children: [
                // Image.network("https://www.fit.ba/content/public/images/og-image.jpg", height: 100, width: 100,),
                Image.asset(
                  "assets/images/logo.jpg",
                  height: 100,
                  width: 100,
                ),
                TextField(
                  decoration: InputDecoration(
                      labelText: "Username", prefixIcon: Icon(Icons.email)),
                  controller: _usernameController,
                ),
                SizedBox(
                  height: 8,
                ),
                TextField(
                  decoration: InputDecoration(
                      labelText: "Password", prefixIcon: Icon(Icons.password)),
                  controller: _passwordController,
                ),
                SizedBox(
                  height: 8,
                ),
                ElevatedButton(
                  onPressed: () async {
                    var username = _usernameController.text;
                    var password = _passwordController.text;

                    try {
                      loginUser(username, password);
                      // Ovde možete dodati dodatne provere ili akcije nakon uspešnog logina
                      // Na primer, navigacija na sledeći ekran
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const KorisniciListScreen(),
                        ),
                      );
                    } on Exception catch (e) {
                      // Prikazivanje poruke o grešci ako dođe do problema prilikom logina
                      showDialog(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                          title: Text("Error"),
                          content: Text(e.toString()),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: Text("OK"),
                            )
                          ],
                        ),
                      );
                    }
                  },
                  child: Text("Login"),
                ),
              ]),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> loginUser(String username, String password) async {
    final String apiUrl = 'https://localhost:7097/token';

    final Map<String, String> data = {
      'username': username,
      'password': password,
    };

    final http.Response response = await http.post(
      Uri.parse(apiUrl),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(data),
    );

    try {
      if (response.statusCode == 200) {
        var token = response.body;
        // Ovde možete postaviti token u svoj model korisnika ili ga koristiti na neki drugi način
        // Na primer, kreirati funkciju koja postavlja token u trenutnog korisnika u vašem providera
        Authorization.setJwtToken(token);
      } else {
        // Obrada greške ako je login neuspešan
        throw Exception('Failed to log in. Check your credentials.');
      }
    } catch (e) {
      print(e);
    }
  }
}
