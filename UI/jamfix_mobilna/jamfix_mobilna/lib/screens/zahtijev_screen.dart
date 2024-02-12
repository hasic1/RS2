import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:jamfix_mobilna/models/zahtjev.dart';
import 'package:jamfix_mobilna/providers/zahtjev_provider.dart';
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

  Future initForm() async {
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: imePrezimeController,
                  decoration: const InputDecoration(labelText: 'Ime i Prezime'),
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  controller: adresaController,
                  decoration: const InputDecoration(labelText: 'Adresa'),
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  controller: brojTelefonaController,
                  decoration: const InputDecoration(labelText: 'Broj Telefona'),
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  controller: opisController,
                  decoration: const InputDecoration(labelText: 'Opis problema'),
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
                      var request = Zahtjev(
                        imePrezime: imePrezimeController.text,
                        adresa: adresaController.text,
                        brojTelefona: brojTelefonaController.text,
                        opis: opisController.text,
                        datumVrijeme: selectedDate ?? DateTime.now(),
                        hitnaIntervencija: hitnaIntervencija,
                        statusZahtjevaId: 1,
                      );
                      Navigator.of(context).pop();
                      try {
                        if (widget.zahtjev == null) {
                          await _zahtjevProvider.insert(request);
                        } else {
                          await _zahtjevProvider.update(
                              widget.zahtjev!.zahtjevId, request);
                        }
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
