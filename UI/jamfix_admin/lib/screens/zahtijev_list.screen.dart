import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:jamfix_admin/models/zahtjev.dart';
import 'package:jamfix_admin/providers/zahtjev_provider.dart';
import 'package:jamfix_admin/widgets/master_screen.dart';

class ZahtjevListScreen extends StatefulWidget {
  const ZahtjevListScreen({Key? key}) : super(key: key);
  @override
  State<ZahtjevListScreen> createState() => _ZahtjevListScreen();
}

class _ZahtjevListScreen extends State<ZahtjevListScreen> {
  final TextEditingController adresaController = TextEditingController();
  final TextEditingController brojTelefonaController = TextEditingController();
  final TextEditingController opisController = TextEditingController();
  ZahtjevProvider _zahtjevProvider = ZahtjevProvider();

  DateTime? selectedDate;
  bool hitnaIntervencija = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Unos Zahtjeva'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: adresaController,
                decoration: InputDecoration(labelText: 'Adresa'),
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: brojTelefonaController,
                decoration: InputDecoration(labelText: 'Broj Telefona'),
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: opisController,
                decoration: InputDecoration(labelText: 'Opis problema'),
              ),
              SizedBox(height: 35.0),
              Row(
                children: [
                  Text('Datum i Vrijeme:'),
                  SizedBox(width: 8.0),
                  ElevatedButton(
                    onPressed: () => _selectDate(context),
                    child: Text('Odaberi Datum i Vrijeme'),
                  ),
                  SizedBox(width: 8.0),
                  selectedDate != null
                      ? Text(selectedDate!.toString())
                      : Text('Nije odabrano'),
                ],
              ),
              SizedBox(height: 25.0),
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
                  Text('Hitna Intervencija'),
                ],
              ),
              SizedBox(height: 200.0),
              Align(
                alignment: Alignment.bottomRight,
                child: ElevatedButton(
                  onPressed: () async {
                    var request = Zahtjev(
                      adresa: adresaController.text,
                      brojTelefona: brojTelefonaController.text,
                      opis: opisController.text,
                      datumVrijeme: selectedDate,
                      hitnaIntervencija: hitnaIntervencija,
                    );
                    try {
                      _zahtjevProvider.insert(request);
                    } on Exception catch (e) {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                          title: Text("Error"),
                          content: Text(e.toString()),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: Text("OK"),
                            )
                          ],
                        ),
                      );
                    }
                  },
                  child: Text('Potvrdi Unos'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2023),
      lastDate: DateTime(2024),
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

  void _submitForm() {
    print('Adresa: ${adresaController.text}');
    print('Broj Telefona: ${brojTelefonaController.text}');
    print('Opis: ${opisController.text}');
    print('Datum i Vrijeme: $selectedDate');
    print('Hitna Intervencija: $hitnaIntervencija');
    // Dodajte logiku za slanje podataka na server ili rad s njima
  }
}
