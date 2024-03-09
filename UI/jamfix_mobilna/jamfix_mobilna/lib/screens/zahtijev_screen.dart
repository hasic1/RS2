import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:jamfix_mobilna/models/zahtjev.dart';
import 'package:jamfix_mobilna/providers/zahtjev_provider.dart';
import 'package:jamfix_mobilna/screens/pocetna_screen.dart';
import 'package:jamfix_mobilna/widgets/master_screen.dart';
import 'package:provider/provider.dart';

class ZahtjevListScreen extends StatefulWidget {
  Zahtjev? zahtjev;
  ZahtjevListScreen({this.zahtjev, Key? key}) : super(key: key);
  @override
  State<ZahtjevListScreen> createState() => _ZahtjevListScreen();
}

class _ZahtjevListScreen extends State<ZahtjevListScreen> {
  final TextEditingController imePrezimeController = TextEditingController();
  final TextEditingController adresaController = TextEditingController();
  final TextEditingController brojTelefonaController = TextEditingController();
  final TextEditingController opisController = TextEditingController();

  ZahtjevProvider _zahtjevProvider = ZahtjevProvider();
  final _formKey = GlobalKey<FormState>();

  String? selectedStatusZahtjevaId;
  Map<String, dynamic> _initialValue = {};
  DateTime? selectedDate;
  bool isLoading = true;
  bool hitnaIntervencija = false;

  @override
  void initState() {
    super.initState();
    if (widget.zahtjev != null) {
      _initialValue = {
        'imePrezime': widget.zahtjev?.imePrezime,
        'opis': widget.zahtjev?.opis,
        'adresa': widget.zahtjev?.adresa,
        'datumVrijeme': widget.zahtjev?.datumVrijeme,
        'brojTelefona': widget.zahtjev?.brojTelefona,
        'statusZahtjevaId': widget.zahtjev?.statusZahtjevaId,
        'hitnaIntervencija': widget.zahtjev?.hitnaIntervencija,
      };
      if (widget.zahtjev != null) {
        brojTelefonaController.text = _initialValue['brojTelefona'] ?? '';
        imePrezimeController.text = _initialValue['imePrezime'] ?? '';
        adresaController.text = _initialValue['adresa'] ?? '';
        brojTelefonaController.text = _initialValue['brojTelefona'] ?? '';
        opisController.text = _initialValue['opis'] ?? '';
        hitnaIntervencija = _initialValue['hitnaIntervencija'] ?? '';
      }
    }
    initForm();
  }

  String? validatePhoneNumber(String? phoneNumber) {
    RegExp phoneRegex = RegExp(r'^\d{3}-\d{3}-\d{3}$');
    final isPhoneValid = phoneRegex.hasMatch(phoneNumber ?? '');
    if (!isPhoneValid) {
      return 'Molimo unesite validan broj telefona u formatu 06X-XXX-XXX';
    }
    return null;
  }

  Future initForm() async {
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(
      child: Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    controller: imePrezimeController,
                    decoration:
                        const InputDecoration(labelText: 'Ime i Prezime'),
                    validator: (name) =>
                        name!.isEmpty ? 'Polje je obavezno' : null,
                  ),
                  const SizedBox(height: 16.0),
                  TextFormField(
                    controller: adresaController,
                    decoration: const InputDecoration(labelText: 'Adresa'),
                    validator: (name) =>
                        name!.isEmpty ? 'Polje je obavezno' : null,
                  ),
                  const SizedBox(height: 16.0),
                  TextFormField(
                    controller: brojTelefonaController,
                    decoration:
                        const InputDecoration(labelText: 'Broj Telefona'),
                    validator: validatePhoneNumber,
                  ),
                  const SizedBox(height: 16.0),
                  TextFormField(
                    controller: opisController,
                    decoration:
                        const InputDecoration(labelText: 'Opis problema'),
                    validator: (name) =>
                        name!.isEmpty ? 'Polje je obavezno' : null,
                  ),
                  const SizedBox(height: 35.0),
                  Row(
                    children: [
                      const Text('Datum i Vrijeme:'),
                      const SizedBox(width: 4.0),
                      ElevatedButton(
                        onPressed: () => _selectDate(context),
                        child: const Text('Odaberi Datum i Vrijeme'),
                      ),
                      const SizedBox(width: 4.0),
                    ],
                  ),
                  Row(children: [
                    selectedDate != null
                        ? Text(selectedDate!.toString())
                        : const Text('Nije odabrano'),
                  ]),
                  const SizedBox(height: 25.0),
                  Row(
                    children: [
                      Checkbox(
                        value: hitnaIntervencija,
                        onChanged: (value) {
                          setState(() {
                            hitnaIntervencija = value!;
                          });
                        },
                      ),
                      const Text('Hitna Intervencija'),
                    ],
                  ),
                  const SizedBox(height: 20.0),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          var request = Zahtjev(
                            imePrezime: imePrezimeController.text,
                            adresa: adresaController.text,
                            brojTelefona: brojTelefonaController.text,
                            opis: opisController.text,
                            datumVrijeme: selectedDate ?? DateTime.now(),
                            hitnaIntervencija: hitnaIntervencija,
                            statusZahtjevaId: 1,
                          );
                          showDialog(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                              title: const Text("Success"),
                              content:
                                  const Text("Uspješno ste izvrsili promjene"),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const PocetnaScreen(),
                                      ),
                                    );
                                  },
                                  child: const Text("OK"),
                                )
                              ],
                            ),
                          );
                          if (widget.zahtjev == null) {
                            await _zahtjevProvider.insert(request);
                          } else {
                            await _zahtjevProvider.update(
                                widget.zahtjev!.zahtjevId, request);
                          }
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
