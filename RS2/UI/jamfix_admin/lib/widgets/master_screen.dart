// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:jamfix_admin/main.dart';
import 'package:jamfix_admin/screens/izvjestaji_screen.dart';
import 'package:jamfix_admin/screens/konkursi_screen.dart';
import 'package:jamfix_admin/screens/korisnici_list_screen.dart';
import 'package:jamfix_admin/screens/korisnik_product_list_screen.dart';
import 'package:jamfix_admin/screens/log_in_screen.dart';
import 'package:jamfix_admin/screens/novosti_list_screen.dart';
import 'package:jamfix_admin/screens/oNama_screen.dart';
import 'package:jamfix_admin/screens/pocetna_screen.dart';
import 'package:jamfix_admin/screens/postavke_screen.dart';
import 'package:jamfix_admin/screens/prijave_screen.dart';
import 'package:jamfix_admin/screens/radni_nalog_list_screen.dart';
import 'package:jamfix_admin/screens/usluge_screen.dart';
import 'package:jamfix_admin/screens/zahtijev_screen.dart';
import 'package:jamfix_admin/screens/zahtjevi_list_screen.dart';
import 'package:jamfix_admin/utils/util.dart';

import '../screens/product_list_screen.dart';

class MasterScreenWidget extends StatefulWidget {
  Widget? child;
  String? title;
  Widget? title_widget;

  MasterScreenWidget({this.child, this.title, this.title_widget, Key? key})
      : super(key: key);

  @override
  State<MasterScreenWidget> createState() => _MasterScreenWidgetState();
}

class _MasterScreenWidgetState extends State<MasterScreenWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: widget.title_widget ?? Text(widget.title ?? ""),
        toolbarHeight: 40,
        leadingWidth: 40,
      ),
      drawer: Drawer(
        backgroundColor: Colors.blue,
        child: ListView(
          children: [
            Visibility(
              visible: Authorization.isKorisnik,
              child: ListTile(
                title: Text(
                  'Dodaj zahtjev',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => ZahtjevListScreen(),
                    ),
                  );
                },
              ),
            ),
            ListTile(
              title: Text(
                'Pocetna',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => PocetnaScreen(),
                  ),
                );
              },
            ),
            ListTile(
              title: Text(
                'Novosti',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => NovostiListScreen(),
                  ),
                );
              },
            ),
            ListTile(
              title: Text(
                'O nama',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ONamaScreen(),
                  ),
                );
              },
            ),
            Visibility(
              visible: Authorization.isAdmin || Authorization.isZaposlenik,
              child: ListTile(
                title: Text(
                  'Placene usluge',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => UslugeScreen(),
                    ),
                  );
                },
              ),
            ),
            Visibility(
              visible: Authorization.isOperater,
              child: ListTile(
                title: Text(
                  'Radni nalog',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => RadniNalogListScreen(),
                    ),
                  );
                },
              ),
            ),
            Visibility(
              visible: Authorization.isAdmin,
              child: ListTile(
                title: Text(
                  'Proizvodi',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => ProductListScreen(),
                    ),
                  );
                },
              ),
            ),
            Visibility(
              visible: Authorization.isKorisnik || Authorization.isZaposlenik,
              child: ListTile(
                title: Text(
                  'Proizvodi',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => KorisnikProductListScreen(),
                    ),
                  );
                },
              ),
            ),
            Visibility(
              visible: Authorization.isAdmin,
              child: ListTile(
                title: Text(
                  'Korisnici',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => KorisniciListScreen(),
                    ),
                  );
                },
              ),
            ),
            Visibility(
              visible: Authorization.isAdmin || Authorization.isKorisnik,
              child: ListTile(
                title: Text(
                  'Konkursi',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => KonkursiScreen(),
                    ),
                  );
                },
              ),
            ),
            Visibility(
              visible: Authorization.isAdmin,
              child: ListTile(
                title: Text(
                  'Prijave',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => PrijavaScreen(),
                    ),
                  );
                },
              ),
            ),
            Visibility(
              visible: Authorization.isZaposlenik,
              child: ListTile(
                title: Text(
                  'Zahtjevi',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => ZahtjevScreen(),
                    ),
                  );
                },
              ),
            ),
            Visibility(
              visible: Authorization.isZaposlenik,
              child: ListTile(
                title: Text(
                  'Izvjestaj',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => IzvjestajiScreen(),
                    ),
                  );
                },
              ),
            ),
            ListTile(
              title: Text(
                'Postavke',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => PostavkeScreen(),
                  ),
                );
              },
            ),
            ListTile(
              title: Text(
                'Odjava',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => LoginPage(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: widget.child!,
          ),
          Container(
            height: 60,
            color: Colors.blue,
            child: Center(
              child: Text(
                'jamfix1@gmail.com',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
