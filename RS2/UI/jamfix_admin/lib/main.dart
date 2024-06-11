import 'package:jamfix_admin/providers/drzava_provider.dart';
import 'package:jamfix_admin/providers/izvjestaj_provider.dart';
import 'package:jamfix_admin/providers/konkurs_provider.dart';
import 'package:jamfix_admin/providers/korisniciUloge_provider.dart';
import 'package:jamfix_admin/providers/korisnici_provider.dart';
import 'package:jamfix_admin/providers/novosti_provider.dart';
import 'package:jamfix_admin/providers/ocjene_provider.dart';
import 'package:jamfix_admin/providers/pozicija_provider.dart';
import 'package:jamfix_admin/providers/prijava_provider.dart';
import 'package:jamfix_admin/providers/product_provider.dart';
import 'package:jamfix_admin/providers/radni_nalog_provider.dart';
import 'package:jamfix_admin/providers/statusZahtjevaProvider.dart';
import 'package:jamfix_admin/providers/uloge_provider.dart';
import 'package:jamfix_admin/providers/usluga_stavke_provider.dart';
import 'package:jamfix_admin/providers/usluge_provider.dart';
import 'package:jamfix_admin/providers/vrste_proizvoda_provider.dart';
import 'package:jamfix_admin/providers/zahtjev_provider.dart';
import 'package:jamfix_admin/screens/log_in_screen.dart';
import 'package:jamfix_admin/utils/util.dart';
import 'package:provider/provider.dart';
import './screens/product_list_screen.dart';
import 'package:flutter/material.dart';

void main() async {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => VrsteProizvodaProvider()),
      ChangeNotifierProvider(create: (_) => StatusZahtjevaProvider()),
      ChangeNotifierProvider(create: (_) => KorisniciUlogeProvider()),
      ChangeNotifierProvider(create: (_) => UslugaStavkeProvider()),
      ChangeNotifierProvider(create: (_) => RadniNalogProvider()),
      ChangeNotifierProvider(create: (_) => KorisniciProvider()),
      ChangeNotifierProvider(create: (_) => IzvjestajProvider()),
      ChangeNotifierProvider(create: (_) => PozicijaProvider()),
      ChangeNotifierProvider(create: (_) => ProductProvider()),
      ChangeNotifierProvider(create: (_) => ZahtjevProvider()),
      ChangeNotifierProvider(create: (_) => NovostiProvider()),
      ChangeNotifierProvider(create: (_) => KonkursProvider()),
      ChangeNotifierProvider(create: (_) => PrijavaProvider()),
      ChangeNotifierProvider(create: (_) => DrzavaProvider()),
      ChangeNotifierProvider(create: (_) => UslugeProvider()),
      ChangeNotifierProvider(create: (_) => OcjeneProvider()),
      ChangeNotifierProvider(create: (_) => UlogeProvider()),
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
