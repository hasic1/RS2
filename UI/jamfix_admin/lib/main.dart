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
import 'package:jamfix_admin/screens/korisnici_list_screen.dart';
import 'package:jamfix_admin/utils/util.dart';
import 'package:jamfix_admin/widgets/master_screen.dart';
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
                      await loginUser(username, password);
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const ProductListScreen(),
                        ),
                      );
                    } on Exception catch (e) {
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
    const String apiUrl = 'https://localhost:7097/token';

    final Map<String, String> data = {
      'username': username,
      'password': password,
    };
    final http.Response response = await http.post(
      Uri.parse(apiUrl),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(data),
    );
    print(response.statusCode);
    if (isValidResponse(response)) {
      var token = response.body;
      Authorization.setJwtToken(token);
    }
  }
}
