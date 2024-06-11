import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jamfix_mobilna/models/radni_nalog.dart';
import 'package:jamfix_mobilna/models/search_result.dart';
import 'package:jamfix_mobilna/providers/radni_nalog_provider.dart';
import 'package:jamfix_mobilna/screens/pocetna_screen.dart';
import 'package:jamfix_mobilna/screens/radni_nalog_list_screen.dart';
import 'package:jamfix_mobilna/utils/utils.dart';
import 'package:jamfix_mobilna/widgets/master_screen.dart';
import 'package:provider/provider.dart';

class RadniNalogScreen extends StatefulWidget {
  RadniNalog? radniNalog;
  RadniNalogScreen({this.radniNalog, Key? key}) : super(key: key);

  @override
  _RadniNalogScreenState createState() => _RadniNalogScreenState();
}

class _RadniNalogScreenState extends State<RadniNalogScreen> {
  final TextEditingController _nosilacPoslaController = TextEditingController();
  final TextEditingController _opisPrijavljenogController =
      TextEditingController();
  final TextEditingController _opisUradjenogController =
      TextEditingController();
  final TextEditingController _imePrezimeController = TextEditingController();
  final TextEditingController _telefonController = TextEditingController();
  final TextEditingController _adresaController = TextEditingController();
  final TextEditingController _mjestoController = TextEditingController();
  final TextEditingController _nazivController = TextEditingController();
  TextEditingController _startDateController = TextEditingController();
  final TextEditingController _kolicinaController = TextEditingController();
  RadniNalogProvider _radniNalogProvider = RadniNalogProvider();
  SearchResult<RadniNalog>? korisniciResult;
  final _formKey = GlobalKey<FormState>();
  Map<String, dynamic> _initialValue = {};
  DateTime? selectedDate;
  @override
  void initState() {
    super.initState();
    if (widget.radniNalog != null) {
      setState(() {
        _initialValue = {
          'nosilacPosla': widget.radniNalog?.nosilacPosla,
          'opisPrijavljenog': widget.radniNalog?.opisPrijavljenog,
          'opisUradjenog': widget.radniNalog?.opisUradjenog,
          'imePrezime': widget.radniNalog?.imePrezime,
          'telefon': widget.radniNalog?.telefon,
          'adresa': widget.radniNalog?.adresa,
          'mjesto': widget.radniNalog?.mjesto,
          'naziv': widget.radniNalog?.naziv,
          'kolicina': widget.radniNalog?.kolicina,
          'datum': widget.radniNalog?.datum,
        };
        _nosilacPoslaController.text = _initialValue['nosilacPosla'] ?? '';
        _opisPrijavljenogController.text =
            _initialValue['opisPrijavljenog'] ?? '';
        _opisUradjenogController.text = _initialValue['opisUradjenog'] ?? '';
        _imePrezimeController.text = _initialValue['imePrezime'] ?? '';
        _telefonController.text = _initialValue['telefon'] ?? '';
        _adresaController.text = _initialValue['adresa'] ?? '';
        _mjestoController.text = _initialValue['mjesto'] ?? '';
        _nazivController.text = _initialValue['naziv'] ?? '';
        _kolicinaController.text = _initialValue['kolicina'].toString() ?? '';
        selectedDate = _initialValue['datum'] ?? '';
      });
    }
    _radniNalogProvider = context.read<RadniNalogProvider>();
    _ucitajPodatke();
  }

  Future<void> _ucitajPodatke() async {
    var podaci = await _radniNalogProvider.get();
    setState(() {
      korisniciResult = podaci;
    });
  }

  String? validatePhoneNumber(String? phoneNumber) {
    RegExp phoneRegex = RegExp(r'^\d{3}-\d{3}-\d{3}$');
    final isPhoneValid = phoneRegex.hasMatch(phoneNumber ?? '');
    if (!isPhoneValid) {
      return 'Molimo unesite validan broj telefona\nu formatu 06X-XXX-XXX';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(
      child: Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _mjestoController,
                        decoration: const InputDecoration(
                          labelText: 'Mjesto',
                        ),
                        validator: (name) =>
                            name!.isEmpty ? 'Polje je obavezno' : null,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _startDateController,
                        decoration: const InputDecoration(
                          labelText: 'Datum',
                          hintText: 'Odaberite datum',
                          labelStyle: TextStyle(color: Colors.black),
                          hintStyle: TextStyle(color: Colors.black),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                        ),
                        onTap: () async {
                          DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: selectedDate,
                            firstDate: DateTime.now(),
                            lastDate: DateTime(2101),
                          );

                          if (pickedDate != null &&
                              pickedDate != selectedDate) {
                            setState(() {
                              selectedDate = pickedDate;
                              _startDateController.text =
                                  "${pickedDate.day}.${pickedDate.month}.${pickedDate.year}.";
                            });
                          }
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Obavezan unos datuma!';
                          }
                          return null;
                        },
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ],
                ),
                const Center(
                  child: Text(
                    'Korisnik usluga',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
                const Divider(
                  thickness: 2,
                  color: Colors.grey,
                ),
                TextFormField(
                  controller: _imePrezimeController,
                  decoration: const InputDecoration(
                    labelText: 'Ime i prezime',
                  ),
                  validator: (name) =>
                      name!.isEmpty ? 'Polje je obavezno' : null,
                ),
                TextFormField(
                  controller: _adresaController,
                  decoration: const InputDecoration(
                    labelText: 'Adresa',
                  ),
                  validator: (name) =>
                      name!.isEmpty ? 'Polje je obavezno' : null,
                ),
                TextFormField(
                  controller: _telefonController,
                  decoration: const InputDecoration(
                    labelText: 'Telefon',
                  ),
                  keyboardType: TextInputType.number,
                  validator: validatePhoneNumber,
                  inputFormatters: <TextInputFormatter>[
                    LengthLimitingTextInputFormatter(11),
                    FilteringTextInputFormatter.allow(RegExp(r'^[0-9-]*$')),
                  ],
                ),
                TextFormField(
                  controller: _opisPrijavljenogController,
                  decoration: const InputDecoration(
                    labelText: 'Opis prijavljenog',
                  ),
                  validator: (name) =>
                      name!.isEmpty ? 'Polje je obavezno' : null,
                ),
                TextFormField(
                  controller: _opisUradjenogController,
                  decoration: const InputDecoration(
                    labelText: 'Opis uradjenog',
                  ),
                  validator: (name) =>
                      name!.isEmpty ? 'Polje je obavezno' : null,
                ),
                const SizedBox(
                  height: 10,
                ),
                const Center(
                  child: Text(
                    'Utrošeni materijal',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
                const Divider(
                  thickness: 2,
                  color: Colors.grey,
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _nazivController,
                        decoration: const InputDecoration(
                          labelText: 'Naziv',
                        ),
                        validator: (name) =>
                            name!.isEmpty ? 'Polje je obavezno' : null,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: TextFormField(
                        controller: _kolicinaController,
                        decoration: const InputDecoration(
                          labelText: 'Kolicina',
                        ),
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        validator: (name) =>
                            name!.isEmpty ? 'Polje je obavezno' : null,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      var kolicinaInt = int.tryParse(_kolicinaController.text);
                      var request = RadniNalog(
                        nosilacPosla:
                            '${Authorization.ime} ${Authorization.prezime}',
                        opisPrijavljenog: _opisPrijavljenogController.text,
                        opisUradjenog: _opisUradjenogController.text,
                        imePrezime: _imePrezimeController.text,
                        telefon: _telefonController.text,
                        adresa: _adresaController.text,
                        mjesto: _mjestoController.text,
                        datum: selectedDate ?? DateTime.now(),
                        naziv: _nazivController.text,
                        kolicina: kolicinaInt,
                      );
                      if (widget.radniNalog == null) {
                        _radniNalogProvider.insert(request);
                        showDialog(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            title: const Text("Success"),
                            content: const Text(
                                "Uspješno ste napraviili radni nalog"),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          RadniNalogListScreen(),
                                    ),
                                  );
                                },
                                child: const Text("OK"),
                              )
                            ],
                          ),
                        );
                      } else {
                        _radniNalogProvider.update(
                            widget.radniNalog?.nalogId, request);
                        showDialog(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            title: const Text("Success"),
                            content:
                                const Text("Uspješno ste izvršili promjene"),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          RadniNalogListScreen(),
                                    ),
                                  );
                                },
                                child: const Text("OK"),
                              )
                            ],
                          ),
                        );
                      }
                    }
                  },
                  child: Text('Spremi Radni Nalog'),
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
      initialDate: DateTime(2024, 1, 1),
      firstDate: DateTime.now(),
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
