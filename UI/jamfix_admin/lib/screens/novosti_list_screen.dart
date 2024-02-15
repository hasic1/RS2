import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:jamfix_admin/models/search_result.dart';
import 'package:jamfix_admin/providers/novosti_provider.dart';
import 'package:jamfix_admin/screens/novosti_detail_screen.dart';
import 'package:jamfix_admin/utils/util.dart';
import 'package:jamfix_admin/widgets/master_screen.dart';
import 'package:jamfix_admin/models/novosti.dart';
import 'package:provider/provider.dart';

class NovostiListScreen extends StatefulWidget {
  Novosti? novosti;
  NovostiListScreen({this.novosti, Key? key}) : super(key: key);
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
        floatingActionButton: Visibility(
          visible: Authorization.isAdmin || Authorization.isZaposlenik,
          child: FloatingActionButton(
            onPressed: () {
              _handleAddReport();
            },
            child: Icon(Icons.add),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
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
        leading:
            novost.slika != null && imageFromBase64String(novost.slika!) != ""
                ? SizedBox(
                    width: 100,
                    height: 100,
                    child: imageFromBase64String(novost.slika!),
                  )
                : const SizedBox.shrink(),
        title: Text(novost.naslov ?? ''),
        subtitle: Text(novost.sadrzaj ?? ''),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => NovostiDetailScreen(
                novosti: novost,
              ),
            ),
          );
        },
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Visibility(
              visible: Authorization.isAdmin || Authorization.isZaposlenik,
              child: IconButton(
                icon: Icon(Icons.edit),
                onPressed: () {
                  _editNovost(novost);
                },
              ),
            ),
            Visibility(
              visible: Authorization.isAdmin || Authorization.isZaposlenik,
              child: IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  _novostiProvider.delete(novost.novostId);
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => NovostiListScreen(),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _editNovost(Novosti novost) {
    naslovController.text = novost.naslov ?? '';
    sadrzajController.text = novost.sadrzaj ?? '';
    _base65Image = novost.slika ?? "";
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
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => NovostiListScreen(),
                  ),
                );
              },
              child: const Text('Odustani'),
            ),
          ],
        );
      },
    );
  }

  void _handleAddReport() {
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
                  slika: _base65Image,
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
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => NovostiListScreen(),
                  ),
                );
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
      _image = result?.files.single.path != null
          ? File(result!.files.single.path!)
          : null;
      _base65Image = base64Encode(_image!.readAsBytesSync());
    }
  }
}
