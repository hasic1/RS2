import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:jamfix_admin/models/drzava.dart';
import 'package:jamfix_admin/models/korisnici.dart';
import 'package:jamfix_admin/models/korisnici_uloge.dart';
import 'package:jamfix_admin/models/novosti.dart';
import 'package:jamfix_admin/models/pozicija.dart';
import 'package:jamfix_admin/models/search_result.dart';
import 'package:jamfix_admin/providers/drzava_provider.dart';
import 'package:jamfix_admin/providers/korisniciUloge_provider.dart';
import 'package:jamfix_admin/providers/korisnici_provider.dart';
import 'package:jamfix_admin/providers/novosti_provider.dart';
import 'package:jamfix_admin/providers/pozicija_provider.dart';
import 'package:jamfix_admin/screens/korisnici_list_screen.dart';
import 'package:jamfix_admin/screens/novosti_list_screen.dart';
import 'package:jamfix_admin/utils/util.dart';
import 'package:jamfix_admin/widgets/master_screen.dart';
import 'package:provider/provider.dart';

class NovostiDetailScreen extends StatefulWidget {
  Novosti? novosti;
  NovostiDetailScreen({this.novosti, Key? key}) : super(key: key);
  @override
  State<NovostiDetailScreen> createState() => _NovostiDetailScreen();
}

class _NovostiDetailScreen extends State<NovostiDetailScreen> {
  final TextEditingController naslovController = TextEditingController();
  final TextEditingController sadrzajController = TextEditingController();
  SearchResult<Novosti>? novostiResult;
  NovostiProvider _novostiProvider = NovostiProvider();

  Map<String, dynamic> _initialValue = {};
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    if (widget.novosti != null) {
      setState(() {
        _initialValue = {
          'naslov': widget.novosti?.naslov,
          'sadrzaj': widget.novosti?.sadrzaj,
        };
        naslovController.text = _initialValue['ime'] ?? '';
        sadrzajController.text = _initialValue['prezime'] ?? '';
      });
    }
    _novostiProvider = context.read<NovostiProvider>();
    _ucitajPodatke();
  }

  Future<void> _ucitajPodatke() async {
    var novosti = await _novostiProvider.get();

    setState(() {
      novostiResult = novosti;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(
      child: Scaffold(
        appBar: AppBar(),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Naslov novosti:\n ' +
                      (widget.novosti != null
                          ? widget.novosti!.naslov.toString()
                          : ''),
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16.0),
                Text(
                  'Sadržaj novosti:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  widget.novosti != null
                      ? widget.novosti!.sadrzaj.toString()
                      : '',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 20),
                
              ],
            ),
          ),
        ),
      ),
    );
  }

  File? _image;
  String? _base65Image;

  Future getImage() async {
    var result = await FilePicker.platform.pickFiles(type: FileType.image);

    if (result != null && result.files.single.path != null) {
      _image = File(result.files.single.path!);
      _base65Image = base64Encode(_image!.readAsBytesSync());
    }
  }
}
