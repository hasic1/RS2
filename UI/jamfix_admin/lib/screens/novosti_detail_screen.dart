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
        appBar: AppBar(
          automaticallyImplyLeading: false,
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: naslovController,
                  decoration: const InputDecoration(labelText: 'Ime'),
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  controller: sadrzajController,
                  decoration: const InputDecoration(labelText: 'Prezime'),
                ),
                const SizedBox(height: 20.0),
                Row(
                  children: [
                    Expanded(
                        child: FormBuilderField(
                      name: 'imageId',
                      builder: ((field) {
                        return InputDecorator(
                          decoration: InputDecoration(
                              label: const Text('Odaberite sliku'),
                              errorText: field.errorText),
                          child: ListTile(
                            leading: const Icon(Icons.photo),
                            title: const Text("Select image"),
                            trailing: const Icon(Icons.file_upload),
                            onTap: getImage,
                          ),
                        );
                      }),
                    )),
                  ],
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: ElevatedButton(
                    onPressed: () async {
                      Novosti request = Novosti(
                          naslov: naslovController.text,
                          sadrzaj: sadrzajController.text);
                      Navigator.of(context).pop();
                      try {
                        if (widget.novosti == null) {
                          await _novostiProvider.insert(request);
                        } else {
                          await _novostiProvider.update(
                              widget.novosti!.novostId!, request);
                        }
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => NovostiListScreen(),
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
                    child: const Text('Potvrdi Unos'),
                  ),
                ),
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
