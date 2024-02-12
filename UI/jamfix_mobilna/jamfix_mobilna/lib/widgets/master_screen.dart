// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:jamfix_mobilna/main.dart';
import 'package:jamfix_mobilna/screens/novosti_list_screen.dart';
import 'package:jamfix_mobilna/screens/oNama_screen.dart';
import 'package:jamfix_mobilna/screens/pocetna_screen.dart';
import 'package:jamfix_mobilna/screens/postavke_screen.dart';
import 'package:jamfix_mobilna/screens/radni_nalog_screen.dart';
import 'package:jamfix_mobilna/screens/zahtijev_screen.dart';
import 'package:jamfix_mobilna/utils/utils.dart';

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
              visible: Authorization.isKorisnik,
              child: ListTile(
                title: Text('Radni nalog'),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => RadniNalogScreen(),
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
