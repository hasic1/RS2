import 'package:flutter/material.dart';
import 'package:jamfix_admin/main.dart';
import 'package:jamfix_admin/screens/korisnici_list_screen.dart';
import 'package:jamfix_admin/screens/product_detail_screen.dart';
import 'package:jamfix_admin/screens/product_list_screen.dart';

class MasterScreenWidget extends StatefulWidget {
  Widget? child;
  String title;
  Widget? title_widget;

  MasterScreenWidget({Key? key, this.title = '', this.title_widget, required this.child}) : super(key: key);

  @override
  State<MasterScreenWidget> createState() => _MasterScreenWidgetState();
}

class _MasterScreenWidgetState extends State<MasterScreenWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: widget.title_widget ?? Text(widget.title!),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              title: Text('Proizvodi'),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ProductListScreen(),
                  ),
                );
              },
            ),
            ListTile(
              title: const Text('Korisnici'),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => KorisniciListScreen(),
                  ),
                );
              },
            ),
            ListTile(
              title: const Text('Detalji'),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ProductDetailScreen(),
                  ),
                );
              },
            ),
            ListTile(
              title: const Text('Odjava'),
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
      body: widget.child,
    );
  }
}

