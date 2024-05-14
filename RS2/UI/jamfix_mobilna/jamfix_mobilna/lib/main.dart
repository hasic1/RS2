import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:jamfix_mobilna/providers/base_provider.dart';
import 'package:jamfix_mobilna/providers/drzava_provider.dart';
import 'package:jamfix_mobilna/providers/korisnici_provider.dart';
import 'package:jamfix_mobilna/providers/novosti_provider.dart';
import 'package:jamfix_mobilna/providers/ocjene_provider.dart';
import 'package:jamfix_mobilna/providers/product_provider.dart';
import 'package:jamfix_mobilna/providers/radni_nalog_provider.dart';
import 'package:jamfix_mobilna/providers/usluge_provider.dart';
import 'package:jamfix_mobilna/providers/vrste_proizvoda_provider.dart';
import 'package:jamfix_mobilna/screens/pocetna_screen.dart';
import 'package:jamfix_mobilna/screens/registracija.dart';
import 'package:jamfix_mobilna/utils/utils.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey =
      'pk_test_51OYqyiFJavMmN9lElH6dxkRe7BKrKlwBzmhGEVkFCq3LS7x5MkgNxyNmLC48OjVArXLlGT8Ko6On76ysfWVTsUtT00bNVNGrpV';
  HttpOverrides.global = MyHttpOverrides();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => VrsteProizvodaProvider()),
        ChangeNotifierProvider(create: (_) => RadniNalogProvider()),
        ChangeNotifierProvider(create: (_) => KorisniciProvider()),
        ChangeNotifierProvider(create: (_) => ProductProvider()),
        ChangeNotifierProvider(create: (_) => NovostiProvider()),
        ChangeNotifierProvider(create: (_) => DrzavaProvider()),
        ChangeNotifierProvider(create: (_) => OcjeneProvider()),
        ChangeNotifierProvider(create: (_) => UslugeProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RS II Material app',
      theme: ThemeData(primarySwatch: Colors.blue),
      home:
          Authorization.jwtToken != null ? const PocetnaScreen() : LoginPage(),
    );
  }
}

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 400),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(children: [
                Image.asset(
                  "assets/images/Jamfix.jpg",
                  height: 100,
                  width: 100,
                ),
                const SizedBox(
                  height: 8,
                ),
                TextField(
                  decoration: const InputDecoration(
                      labelText: "Username", prefixIcon: Icon(Icons.email)),
                  controller: _usernameController,
                ),
                const SizedBox(
                  height: 8,
                ),
                TextField(
                  decoration: const InputDecoration(
                      labelText: "Password", prefixIcon: Icon(Icons.password)),
                  controller: _passwordController,
                  obscureText: true,
                ),
                const SizedBox(
                  height: 15,
                ),
                ElevatedButton(
                  onPressed: () async {
                    var username = _usernameController.text;
                    var password = _passwordController.text;
                    Authorization.password = _passwordController.text;
                    Authorization.username = _usernameController.text;

                    try {
                      await loginUser(username, password);
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const PocetnaScreen(),
                        ),
                      );
                    } on Exception catch (e) {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                          title: const Text("Error"),
                          content: Text(e.toString()),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text("OK"),
                            )
                          ],
                        ),
                      );
                    }
                  },
                  child: const Text("Login"),
                ),
                const SizedBox(
                  height: 25,
                ),
                ElevatedButton(
                    onPressed: () async {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const RegistracijaScreen()));
                    },
                    child: const Text("Registruj se"))
              ]),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> loginUser(String username, String password) async {
    const String apiUrl = '${Authorization.putanja}token';

    final Map<String, String> data = {
      'username': username,
      'password': password,
    };
    final http.Response response = await http.post(
      Uri.parse(apiUrl),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(data),
    );
    if (isValidResponse(response)) {
      var token = response.body;
      Authorization.setJwtToken(token);
    }
  }
}
