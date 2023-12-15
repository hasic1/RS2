// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:jamfix_admin/main.dart';
import 'package:jamfix_admin/screens/home_screen.dart';
import 'package:jamfix_admin/screens/korisnici_list_screen.dart';

import '../screens/product_list_screen.dart';

class MasterScreenWidget extends StatefulWidget {
  Widget? child;
  String? title;
  Widget? title_widget;

  MasterScreenWidget({this.child, this.title, this.title_widget, Key? key}) : super(key: key);

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
            ListTile(
              title: Text('Pocetna'),
              onTap: () {
               Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) =>  HomeScreen(),
                        ),
                      );
              },
            ),
            ListTile(
              title: Text('Korisnici'),
              onTap: () {
                Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const KorisniciListScreen(),
                        ),
                      );
              },
            ),
            ListTile(
              title: Text('Proizvodi'),
              onTap: () {
                Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => ProductListScreen(),
                        ),
                      );
              },
            ),ListTile(
              title: Text('Odjava'),
              onTap: () {
                Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => LoginPage(),
                        ),
                      );
              },
            )
          ],
        ),
      ),
      body: widget.child!,
    );
  }
}