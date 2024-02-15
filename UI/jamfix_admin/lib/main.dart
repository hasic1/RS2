// import 'package:eprodaja_admin/models/jedinice_mjere.dart';
//import 'package:eprodaja_admin/providers/jedinice_mjere.dart';
//import 'package:eprodaja_admin/providers/product_provider.dart';
//import 'package:eprodaja_admin/providers/vrste_proizvoda.dart';
//import 'package:eprodaja_admin/utils/util.dart';
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:jamfix_admin/models/pozicija.dart';
import 'package:jamfix_admin/providers/drzava_provider.dart';
import 'package:jamfix_admin/providers/izvjestaj_provider.dart';
import 'package:jamfix_admin/providers/korisniciUloge_provider.dart';
import 'package:jamfix_admin/providers/korisnici_provider.dart';
import 'package:jamfix_admin/providers/novosti_provider.dart';
import 'package:jamfix_admin/providers/pozicija_provider.dart';
import 'package:jamfix_admin/providers/product_provider.dart';
import 'package:jamfix_admin/providers/radni_nalog_provider.dart';
import 'package:jamfix_admin/providers/statusZahtjevaProvider.dart';
import 'package:jamfix_admin/providers/usluge_provider.dart';
import 'package:jamfix_admin/providers/vrste_proizvoda_provider.dart';
import 'package:jamfix_admin/providers/zahtjev_provider.dart';
import 'package:jamfix_admin/screens/pocetna_screen.dart';
import 'package:jamfix_admin/screens/registracija.dart';
import 'package:jamfix_admin/utils/util.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import './screens/product_list_screen.dart';
import 'package:flutter/material.dart';

void main() async {
  Stripe.publishableKey =
      "pk_test_51OYqyiFJavMmN9lElH6dxkRe7BKrKlwBzmhGEVkFCq3LS7x5MkgNxyNmLC48OjVArXLlGT8Ko6On76ysfWVTsUtT00bNVNGrpV";
  await dotenv.load(fileName: "assets/.env");
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => VrsteProizvodaProvider()),
      ChangeNotifierProvider(create: (_) => StatusZahtjevaProvider()),
      ChangeNotifierProvider(create: (_) => KorisniciUlogeProvider()),
      ChangeNotifierProvider(create: (_) => RadniNalogProvider()),
      ChangeNotifierProvider(create: (_) => KorisniciProvider()),
      ChangeNotifierProvider(create: (_) => IzvjestajProvider()),
      ChangeNotifierProvider(create: (_) => PozicijaProvider()),
      ChangeNotifierProvider(create: (_) => ProductProvider()),
      ChangeNotifierProvider(create: (_) => ZahtjevProvider()),
      ChangeNotifierProvider(create: (_) => NovostiProvider()),
      ChangeNotifierProvider(create: (_) => DrzavaProvider()),
      ChangeNotifierProvider(create: (_) => UslugeProvider()),
    ],
    child: const MyMaterialApp(),
  ));
}

class MyMaterialApp extends StatelessWidget {
  const MyMaterialApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RS II Material app',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: Authorization.jwtToken != null
          ? const ProductListScreen()
          : LoginPage(),
    );
  }
}

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
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
          constraints: const BoxConstraints(maxWidth: 400, maxHeight: 400),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Image.asset(
                  "assets/images/Jamfix.jpg",
                  height: 100,
                  width: 100,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                      labelText: "Username", prefixIcon: Icon(Icons.email)),
                  controller: _usernameController,
                ),
                const SizedBox(
                  height: 8,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                      labelText: "Password", prefixIcon: Icon(Icons.password)),
                  controller: _passwordController,
                ),
                const SizedBox(
                  height: 15,
                ),
                ElevatedButton(
                  onPressed: () async {
                    var username = _usernameController.text;
                    var password = _passwordController.text;

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
              ],
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
