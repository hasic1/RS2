import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:jamfix_mobilna/models/drzava.dart';
import 'package:jamfix_mobilna/models/korisnici.dart';
import 'package:jamfix_mobilna/models/search_result.dart';
import 'package:jamfix_mobilna/providers/drzava_provider.dart';
import 'package:jamfix_mobilna/providers/korisnici_provider.dart';
import 'package:jamfix_mobilna/utils/utils.dart';
import 'package:jamfix_mobilna/widgets/master_screen.dart';
import 'package:provider/provider.dart';

class PostavkeScreen extends StatefulWidget {
  @override
  _PostavkeScreen createState() => _PostavkeScreen();
}

class _PostavkeScreen extends State<PostavkeScreen> {
  TextEditingController _imeController = TextEditingController();
  TextEditingController _prezimeController = TextEditingController();
  TextEditingController _noviPasswordController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _telefonController = TextEditingController();
  TextEditingController _passwordPotvrdaController = TextEditingController();
  KorisniciProvider _korisniciProvider = KorisniciProvider();
  DrzavaProvider _drzavaProvider = DrzavaProvider();
  SearchResult<Drzava>? drzavaResult;
  final _formKey = GlobalKey<FormState>();
  Map<String, dynamic> _initialValue = {};

  String? selectedDrzavaId;

  @override
  void initState() {
    super.initState();
    setState(() {
      _initialValue = {
        'ime': Authorization.ime,
        'prezime': Authorization.prezime,
        'telefon': Authorization.telefon,
        'email': Authorization.email,
      };
      _imeController.text = _initialValue['ime'] ?? '';
      _prezimeController.text = _initialValue['prezime'] ?? '';
      _telefonController.text = _initialValue['telefon'] ?? '';
      _emailController.text = _initialValue['email'] ?? '';
    });
    _drzavaProvider = context.read<DrzavaProvider>();
    _ucitajPodatke();
  }

  Future<void> _ucitajPodatke() async {
    var drzava = await _drzavaProvider.get();
    setState(() {
      drzavaResult = drzava;
    });
  }

  String? validateEmail(String? email) {
    RegExp emailRegex = RegExp(r'^[\w\.-]+@[\w-]+\.\w{2,3}(\.\w{2,3})?$');
    final isEmailValid = emailRegex.hasMatch(email ?? '');
    if (!isEmailValid) {
      return 'Molimo unesite validan email';
    }
    return null;
  }

  String? validatePhoneNumber(String? phoneNumber) {
    RegExp phoneRegex = RegExp(r'^\d{3}-\d{3}-\d{3}$');
    final isPhoneValid = phoneRegex.hasMatch(phoneNumber ?? '');
    if (!isPhoneValid) {
      return 'Molimo unesite validan broj telefona u formatu XXX-XXX-XXX';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(
      child: Scaffold(
        appBar: AppBar(
          title: Text(Authorization.rola!),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Flexible(
                  flex: 1,
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextFormField(
                            controller: _imeController,
                            decoration: const InputDecoration(labelText: 'Ime'),
                            validator: (name) => name!.length < 3
                                ? 'Ime mora imati bar 3 slova'
                                : null,
                          ),
                          const SizedBox(height: 8.0),
                          TextFormField(
                            controller: _prezimeController,
                            decoration:
                                const InputDecoration(labelText: 'Prezime'),
                            validator: (name) => name!.length < 3
                                ? 'Prezime mora imati bar 3 slova'
                                : null,
                          ),
                          const SizedBox(height: 8.0),
                          TextFormField(
                            controller: _emailController,
                            decoration:
                                const InputDecoration(labelText: 'Email'),
                            validator: validateEmail,
                          ),
                          const SizedBox(height: 8.0),
                          TextFormField(
                            controller: _telefonController,
                            decoration:
                                const InputDecoration(labelText: 'Telefon'),
                            validator: validatePhoneNumber,
                          ),
                          const SizedBox(height: 8.0),
                          TextFormField(
                            controller: _noviPasswordController,
                            decoration:
                                const InputDecoration(labelText: 'Lozinka'),
                            obscureText: true,
                            validator: (name) => name!.length < 5
                                ? 'Lozinka mora imati bar 5 znakova'
                                : null,
                          ),
                          const SizedBox(height: 8.0),
                          TextFormField(
                            controller: _passwordPotvrdaController,
                            decoration: const InputDecoration(
                                labelText: 'Potvrdi lozinku'),
                            obscureText: true,
                            validator: (name) =>
                                name!.length < 5 ? 'Unesite lozinku' : null,
                          ),
                          SizedBox(height: 8.0),
                          Row(
                            children: [
                              Expanded(
                                child: FormBuilderDropdown<String>(
                                  name: 'drzavaId',
                                  decoration: InputDecoration(
                                    labelText: 'Drzava',
                                    hintText: 'Odaberi drzavu',
                                  ),
                                  items: drzavaResult?.result
                                          .map((item) => DropdownMenuItem(
                                                alignment:
                                                    AlignmentDirectional.center,
                                                value: item.drzavaId.toString(),
                                                child: Text(item.naziv ?? ""),
                                              ))
                                          .toList() ??
                                      [],
                                  onChanged: (value) {
                                    setState(() {
                                      selectedDrzavaId = value;
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 16),
                          Align(
                            alignment: Alignment.centerRight,
                            child: ElevatedButton(
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  String drzavaId = selectedDrzavaId ??
                                      Authorization.drzavaID.toString();
                                  var request = Korisnici(
                                    ime: _imeController.text,
                                    prezime: _prezimeController.text,
                                    telefon: _telefonController.text,
                                    email: _emailController.text,
                                    drzavaId: int.parse(drzavaId),
                                    noviPassword: _noviPasswordController.text,
                                    passwordPotvrda:
                                        _passwordPotvrdaController.text,
                                    pozicijaId: Authorization.pozicijaID ?? 1,
                                  );
                                  _korisniciProvider.update(
                                      Authorization.id, request);
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        AlertDialog(
                                      title: const Text("Success"),
                                      content: const Text(
                                          "Uspješno ste izvrsili promjene"),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    PostavkeScreen(),
                                              ),
                                            );
                                          },
                                          child: const Text("OK"),
                                        )
                                      ],
                                    ),
                                  );
                                }
                              },
                              child: Text('Ažuriraj podatke'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
