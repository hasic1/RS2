// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:jamfix_admin/main.dart';
import 'package:jamfix_admin/screens/korisnici_list_screen.dart';
import 'package:jamfix_admin/screens/zahtijev_list.screen.dart';
import 'package:jamfix_admin/utils/util.dart';
import 'package:http/http.dart' as http;

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
            ListTile(
              title: Text('Plati usluge'),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ProductListScreen(),
                  ),
                );
              },
            ),
            ListTile(
              title: Text('Pocetna'),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => KorisniciListScreen(),
                  ),
                );
              },
            ),
            ListTile(
              title: Text('Novosti'),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const KorisniciListScreen(),
                  ),
                );
              },
            ),
            ListTile(
              title: Text('O nama'),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => LoginPage(),
                  ),
                );
              },
            ),
            ListTile(
              title: Text('Postavke'),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => LoginPage(),
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
                      builder: (context) => KorisniciListScreen(),
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
                      builder: (context) => KorisniciListScreen(),
                    ),
                  );
                },
              ),
            ),
            Visibility(
              visible: Authorization.isAdmin,
              child: ListTile(
                title: Text('Proizvodi'),
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
              visible: Authorization.isAdmin,
              child: ListTile(
                title: Text('Uposlenici'),
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
                      builder: (context) => KorisniciListScreen(),
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
                      builder: (context) => KorisniciListScreen(),
                    ),
                  );
                },
              ),
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
