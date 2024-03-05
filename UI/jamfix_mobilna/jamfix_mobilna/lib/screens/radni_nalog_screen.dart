import 'package:flutter/material.dart';
import 'package:jamfix_mobilna/models/radni_nalog.dart';
import 'package:jamfix_mobilna/providers/radni_nalog_provider.dart';
import 'package:jamfix_mobilna/widgets/master_screen.dart';

class RadniNalogScreen extends StatefulWidget {
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
  final TextEditingController _kolicinaController = TextEditingController();
  final RadniNalogProvider _radniNalogProvider = RadniNalogProvider();
  final _formKey = GlobalKey<FormState>();
  DateTime? selectedDate;

  String? validatePhoneNumber(String? phoneNumber) {
    RegExp phoneRegex = RegExp(r'^\d{3}-\d{3}-\d{3}$');
    final isPhoneValid = phoneRegex.hasMatch(phoneNumber ?? '');
    if (!isPhoneValid) {
      return 'Molimo unesite validan broj telefona u formatu 06X-XXX-XXX';
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
                        controller: _nosilacPoslaController,
                        decoration: const InputDecoration(
                          labelText: 'Nosilac posla',
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
                        controller: _mjestoController,
                        decoration: const InputDecoration(
                          labelText: 'Mijesto',
                        ),
                        validator: (name) =>
                            name!.isEmpty ? 'Polje je obavezno' : null,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Text('Datum i Vrijeme:'),
                    const SizedBox(width: 8.0),
                    ElevatedButton(
                      onPressed: () => _selectDate(context),
                      child: const Text('Odaberi Datum i Vrijeme'),
                    ),
                    const SizedBox(width: 8.0),
                  ],
                ),
                Row(
                  children: [
                    selectedDate != null
                        ? Text(selectedDate!.toString())
                        : const Text('Nije odabrano'),
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
                  validator: (name) =>
                      name!.isEmpty ? 'Polje je obavezno' : null,
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
                      var request = RadniNalog(
                        nosilacPosla: _nosilacPoslaController.text,
                        opisPrijavljenog: _opisPrijavljenogController.text,
                        opisUradjenog: _opisUradjenogController.text,
                        imePrezime: _imePrezimeController.text,
                        telefon: _telefonController.text,
                        adresa: _adresaController.text,
                        mjesto: _mjestoController.text,
                        datum: selectedDate,
                        naziv: _nazivController.text,
                        kolicina: int.parse(_kolicinaController.text),
                      );
                      _radniNalogProvider.insert(request);
                      showDialog(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                          title: const Text("Success"),
                          content: const Text("Uspješno ste izvrsili promjene"),
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
