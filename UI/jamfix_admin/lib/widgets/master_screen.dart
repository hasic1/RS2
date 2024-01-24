// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:jamfix_admin/main.dart';
import 'package:jamfix_admin/models/zahtjev.dart';
import 'package:jamfix_admin/screens/izvjestaji_screen.dart';
import 'package:jamfix_admin/screens/korisnici_list_screen.dart';
import 'package:jamfix_admin/screens/novosti_list_screen.dart';
import 'package:jamfix_admin/screens/oNama_screen.dart';
import 'package:jamfix_admin/screens/pocetna_screen.dart';
import 'package:jamfix_admin/screens/postavke_screen.dart';
import 'package:jamfix_admin/screens/radni_nalog_list_screen.dart';
import 'package:jamfix_admin/screens/radni_nalog_screen.dart';
import 'package:jamfix_admin/screens/usluge_screen.dart';
import 'package:jamfix_admin/screens/zahtijev_list.screen.dart';
import 'package:jamfix_admin/screens/zahtjevi_screen.dart';
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
        title: widget.title_widget ?? Text(widget.title ?? ""),
        toolbarHeight: 30,
        leadingWidth: 40,
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            Visibility(
              visible: Authorization.isKorisnik,
              child: ListTile(
                title: Text('Dodaj zahtjev'),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => ZahtjevListScreen(),
                    ),
                  );
                },
              ),
            ),
            // Visibility(visible: Authorization.isKorisnik,
            //   child: ListTile(
            //     title: Text('Plati usluge'),
            //     onTap: () {
            //       Navigator.of(context).push(
            //         MaterialPageRoute(
            //           builder: (context) => KorisniciListScreen(),
            //         ),
            //       );
            //     },
            //   ),
            // ),
            ListTile(
              title: Text('Pocetna'),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => PocetnaScreen(),
                  ),
                );
              },
            ),
            ListTile(
              title: Text('Novosti'),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => NovostiListScreen(),
                  ),
                );
              },
            ),
            ListTile(
              title: Text('O nama'),
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
                title: Text('Placene usluge'),
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
              visible: Authorization.isZaposlenik,
              child: ListTile(
                title: Text('Radni nalog'),
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
              visible: Authorization.isAdmin || Authorization.isKorisnik,
              child: ListTile(
                title: Text('Proizvodi'),
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
              visible: Authorization.isAdmin,
              child: ListTile(
                title: Text('Korisnici'),
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
              visible: Authorization.isAdmin || Authorization.isZaposlenik,
              child: ListTile(
                title: Text('Zahtjevi'),
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
              visible: Authorization.isAdmin || Authorization.isZaposlenik,
              child: ListTile(
                title: Text('Izvjestaj'),
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
              title: Text('Postavke'),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => PostavkeScreen(),
                  ),
                );
              },
            ),
            ListTile(
              title: Text('Odjava'),
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
      body: widget.child!,
    );
  }
}
