import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jamfix_admin/models/drzava.dart';
import 'package:jamfix_admin/models/korisnici.dart';
import 'package:jamfix_admin/models/search_result.dart';
import 'package:jamfix_admin/providers/drzava_provider.dart';
import 'package:jamfix_admin/providers/korisnici_provider.dart';
import 'package:jamfix_admin/screens/log_in_screen.dart';
import 'package:jamfix_admin/screens/pocetna_screen.dart';
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
  final TextEditingController _transakcijskiRacunController =
      TextEditingController();
  KorisniciProvider _korisniciProvider = KorisniciProvider();
  DrzavaProvider _drzavaProvider = DrzavaProvider();
  SearchResult<Drzava>? drzavaResult;
  Map<String, dynamic> _initialValue = {};
  String? selectedDrzavaId = '1';
  DateTime? selectedDate;

  final _formKey = GlobalKey<FormState>();
  String? validateEmail(String? email) {
    RegExp emailRegex = RegExp(r'^[\w\.-]+@[\w-]+\.\w{2,3}(\.\w{2,3})?$');
    final isEmailValid = emailRegex.hasMatch(email ?? '');
    if (!isEmailValid) {
      return 'Molimo unesite validan email\nu formatu example@example.com';
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

  String? validateCreditCardNumber(String? creditCardNumber) {
    RegExp cardRegex = RegExp(r'^\d{4} \d{4} \d{4} \d{4}$');
    final isCardValid = cardRegex.hasMatch(creditCardNumber ?? '');
    if (!isCardValid) {
      return 'Molimo unesite validan broj transakcijskog racuna u formatu XXXX XXXX XXXX XXXX';
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
        'transakcijskiRacun': Authorization.brojRacuna
      };
      _imeController.text = _initialValue['ime'] ?? '';
      _prezimeController.text = _initialValue['prezime'] ?? '';
      _telefonController.text = _initialValue['telefon'] ?? '';
      _emailController.text = _initialValue['email'] ?? '';
      _transakcijskiRacunController.text =
          _initialValue['transakcijskiRacun'] ?? '';
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
                                keyboardType: TextInputType.phone,
                                inputFormatters: <TextInputFormatter>[
                                  LengthLimitingTextInputFormatter(11),
                                  FilteringTextInputFormatter.allow(
                                      RegExp(r'^[0-9-]*$')),
                                ],
                              ),
                              const SizedBox(height: 8.0),
                              TextFormField(
                                controller: _transakcijskiRacunController,
                                decoration: const InputDecoration(
                                    labelText: 'Transakcijski racun'),
                                validator: validateCreditCardNumber,
                                inputFormatters: <TextInputFormatter>[
                                  LengthLimitingTextInputFormatter(19),
                                  FilteringTextInputFormatter.allow(
                                      RegExp(r'^[0-9 ]*$')),
                                ],
                              ),
                              const SizedBox(height: 8.0),
                              Row(
                                children: [
                                  const Text('Datum i Vrijeme:'),
                                  const SizedBox(width: 4.0),
                                  ElevatedButton(
                                    onPressed: () => _selectDate(context),
                                    child:
                                        const Text('Odaberi Datum i Vrijeme'),
                                  ),
                                  const SizedBox(width: 4.0),
                                ],
                              ),
                              Row(children: [
                                selectedDate != null
                                    ? Text(selectedDate!.toString())
                                    : const Text('Nije odabrano'),
                              ]),
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
                                      future: _drzavaProvider.getDrzave(),
                                      builder: (context, snapshot) {
                                        if (snapshot.connectionState ==
                                            ConnectionState.waiting) {
                                          return const CircularProgressIndicator();
                                        } else if (snapshot.hasError) {
                                          return Text(
                                              'Greška: ${snapshot.error}');
                                        } else {
                                          drzavaResult = snapshot.data
                                              as SearchResult<Drzava>?;
                                          return DropdownButton<String>(
                                            value: selectedDrzavaId,
                                            onChanged: (String? newValue) {
                                              setState(() {
                                                selectedDrzavaId = newValue;
                                              });
                                            },
                                            items: (drzavaResult?.result
                                                    .map(
                                                      (item) =>
                                                          DropdownMenuItem<
                                                              String>(
                                                        value: item.drzavaId
                                                            .toString(),
                                                        child: Text(
                                                            item.naziv ?? ""),
                                                      ),
                                                    )
                                                    .toList()) ??
                                                [],
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
                                          datumVrijeme:
                                              selectedDate ?? DateTime.now(),
                                          transakcijskiRacun:
                                              _transakcijskiRacunController
                                                      .text ??
                                                  Authorization.brojRacuna);
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
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        LoginPage(),
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

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2024),
      lastDate: DateTime(2025),
    );

    if (pickedDate != null) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );

      if (pickedTime != null) {
        setState(() {
          selectedDate = DateTime(
            pickedDate.year,
            pickedDate.month,
            pickedDate.day,
            pickedTime.hour,
            pickedTime.minute,
          );
        });
      }
    }
  }
}
