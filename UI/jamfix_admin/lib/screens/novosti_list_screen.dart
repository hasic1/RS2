import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:jamfix_admin/models/search_result.dart';
import 'package:jamfix_admin/providers/novosti_provider.dart';
import 'package:jamfix_admin/utils/util.dart';
import 'package:jamfix_admin/widgets/master_screen.dart';
import 'package:jamfix_admin/models/novosti.dart';
import 'package:provider/provider.dart';

class NovostiListScreen extends StatefulWidget {
  const NovostiListScreen({Key? key}) : super(key: key);

  @override
  State<NovostiListScreen> createState() => _NovostiListScreenState();
}

class _NovostiListScreenState extends State<NovostiListScreen> {
  final TextEditingController naslovController = TextEditingController();
  final TextEditingController sadrzajController = TextEditingController();

  late NovostiProvider _novostiProvider;
  SearchResult<Novosti>? result;

  @override
  void initState() {
    super.initState();
    _novostiProvider = context.read<NovostiProvider>();
    _ucitajPodatke();
  }

  Future<void> _ucitajPodatke() async {
    var podaci = await _novostiProvider.get();

    setState(() {
      result = podaci;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Novosti iz svijeta tehnologija"),
          automaticallyImplyLeading: false,
        ),
        body: Stack(
          children: [
            _buildNovostiList(),
          ],
        ),
      ),
    );
  }

  Widget _buildNovostiList() {
    return result != null
        ? ListView.builder(
            itemCount: result!.result.length,
            itemBuilder: (context, index) {
              Novosti novost = result!.result[index];
              return _buildNovostItem(novost);
            },
          )
        : const Center(
            child: CircularProgressIndicator(),
          );
  }

  Widget _buildNovostItem(Novosti novost) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: ListTile(
        leading: novost.slika != ""
            ? SizedBox(
                width: 100,
                height: 100,
                child: imageFromBase64String(novost.slika!),
              )
            : const SizedBox.shrink(),
        title: Text(novost.naslov ?? ''),
        subtitle: Text(novost.sadrzaj ?? ''),
        onTap: () {
          _showNovostDetails(novost);
        },
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                _editNovost(novost);
              },
            ),
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                _novostiProvider.delete(novost.novostId);
              },
            ),
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                _handleAddReport();
              },
            ),
          ],
        ),
      ),
    );
  }

  void _editNovost(Novosti novost) {
    naslovController.text = novost.naslov ?? '';
    sadrzajController.text = novost.sadrzaj ?? '';
    _base65Image = novost.slika; // Koristi postojeću sliku za uređivanje
    int? id = novost.novostId;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  decoration: const InputDecoration(labelText: 'Naslov'),
                  controller: naslovController,
                ),
                TextField(
                  decoration: const InputDecoration(labelText: 'Sadržaj'),
                  controller: sadrzajController,
                ),
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
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () async {
                Novosti editedNovost = Novosti(
                  naslov: naslovController.text,
                  sadrzaj: sadrzajController.text,
                  slika: _base65Image,
                );

                try {
                  _novostiProvider.update(id, editedNovost);
                  Navigator.of(context).pop();
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
              child: const Text('Spremi'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Odustani'),
            ),
          ],
        );
      },
    );
  }

  void _showNovostDetails(Novosti novost) {
    // Dodaj logiku za prikaz pojedinačne novosti na zasebnoj stranici
    // Možeš koristiti Navigator za prijelaz na novu stranicu
  }
  void _handleAddReport() {
    TextEditingController slikaController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  decoration: const InputDecoration(labelText: 'Naslov'),
                  controller: naslovController,
                ),
                TextField(
                  decoration: const InputDecoration(labelText: 'Sadržaj'),
                  controller: sadrzajController,
                ),
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
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () async {
                Novosti request = Novosti(
                  naslov: naslovController.text,
                  sadrzaj: sadrzajController.text,
                  slika: _base65Image, // Postavljanje base64 slike u objekt
                );

                try {
                  _novostiProvider.insert(request);
                  Navigator.of(context).pop();
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
              child: const Text('Spremi'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Odustani'),
            ),
          ],
        );
      },
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
