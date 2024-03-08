import 'package:flutter/material.dart';
import 'package:jamfix_admin/models/drzava.dart';
import 'package:jamfix_admin/models/korisnici.dart';
import 'package:jamfix_admin/models/search_result.dart';
import 'package:jamfix_admin/providers/drzava_provider.dart';
import 'package:jamfix_admin/providers/korisnici_provider.dart';
import 'package:jamfix_admin/utils/util.dart';
import 'package:jamfix_admin/widgets/master_screen.dart';
import 'package:provider/provider.dart';

class PostavkeScreen extends StatefulWidget {
  @override
  _PostavkeScreen createState() => _PostavkeScreen();
}

class _PostavkeScreen extends State<PostavkeScreen> {
  final TextEditingController _imeController = TextEditingController();
  final TextEditingController _prezimeController = TextEditingController();
  final TextEditingController _noviPasswordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _telefonController = TextEditingController();
  final TextEditingController _passwordPotvrdaController =
      TextEditingController();
  KorisniciProvider _korisniciProvider = KorisniciProvider();
  DrzavaProvider _drzavaProvider = DrzavaProvider();
  SearchResult<Drzava>? drzavaResult;
  Map<String, dynamic> _initialValue = {};
  String? selectedDrzavaId;
  final _formKey = GlobalKey<FormState>();
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
      return 'Molimo unesite validan broj telefona u formatu 06X-XXX-XXX';
    }
    return null;
  }

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
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextFormField(
                                controller: _imeController,
                                decoration:
                                    const InputDecoration(labelText: 'Ime'),
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
                                decoration: const InputDecoration(
                                    labelText: 'Novi password'),
                                validator: (name) => name!.length < 5
                                    ? 'Lozinka mora imati bar 5 slova'
                                    : null,
                                obscureText: true,
                              ),
                              const SizedBox(height: 8.0),
                              TextFormField(
                                controller: _passwordPotvrdaController,
                                decoration: const InputDecoration(
                                    labelText: 'Password potvrda'),
                                validator: (name) => name!.length < 5
                                    ? 'Lozinka mora imati bar 5 slova'
                                    : null,
                                obscureText: true,
                              ),
                              const SizedBox(height: 8.0),
                              Row(
                                children: [
                                  Expanded(
                                    child: FutureBuilder(
                                      future: _drzavaProvider.get(),
                                      builder: (context, snapshot) {
                                        if (snapshot.connectionState ==
                                            ConnectionState.waiting) {
                                          return const CircularProgressIndicator();
                                        } else if (snapshot.hasError) {
                                          return Text(
                                              'Error: ${snapshot.error}');
                                        } else {
                                          drzavaResult = snapshot.data
                                              as SearchResult<Drzava>?;
                                          selectedDrzavaId = (drzavaResult
                                              ?.result.first.drzavaId
                                              .toString());
                                          return Row(
                                            children: [
                                              Expanded(
                                                child: DropdownButton<String>(
                                                  value: selectedDrzavaId,
                                                  onChanged:
                                                      (String? newValue) {
                                                    setState(() {
                                                      selectedDrzavaId =
                                                          newValue;
                                                    });
                                                  },
                                                  items: (drzavaResult?.result
                                                          .map<
                                                              DropdownMenuItem<
                                                                  String>>(
                                                            (item) =>
                                                                DropdownMenuItem<
                                                                    String>(
                                                              value: item
                                                                  .drzavaId
                                                                  .toString(),
                                                              child: Text(
                                                                  item.naziv ??
                                                                      ""),
                                                            ),
                                                          )
                                                          .toList()) ??
                                                      [],
                                                ),
                                              ),
                                            ],
                                          );
                                        }
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16),
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
                                        noviPassword:
                                            _noviPasswordController.text,
                                        passwordPotvrda:
                                            _passwordPotvrdaController.text,
                                        pozicijaId: Authorization.pozicijaID,
                                      );
                                      _korisniciProvider.update(
                                          Authorization.id, request);
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) =>
                                            AlertDialog(
                                          title: const Text("Success"),
                                          content: const Text(
                                              "Uspješno ste izvršili promjene"),
                                          actions: [
                                            TextButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: const Text("OK"),
                                            )
                                          ],
                                        ),
                                      );
                                    }
                                  },
                                  child: const Text('Ažuriraj podatke'),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
