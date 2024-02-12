import 'package:flutter/material.dart';
import 'package:jamfix_mobilna/models/radni_nalog.dart';
import 'package:jamfix_mobilna/providers/radni_nalog_provider.dart';
import 'package:jamfix_mobilna/widgets/master_screen.dart';

class RadniNalogScreen extends StatefulWidget {
  @override
  _RadniNalogScreenState createState() => _RadniNalogScreenState();
}

class _RadniNalogScreenState extends State<RadniNalogScreen> {
  TextEditingController _nosilacPoslaController = TextEditingController();
  TextEditingController _opisPrijavljenogController = TextEditingController();
  TextEditingController _opisUradjenogController = TextEditingController();
  TextEditingController _imePrezimeController = TextEditingController();
  TextEditingController _telefonController = TextEditingController();
  TextEditingController _adresaController = TextEditingController();
  TextEditingController _mjestoController = TextEditingController();
  TextEditingController _nazivController = TextEditingController();
  TextEditingController _kolicinaController = TextEditingController();
  RadniNalogProvider _radniNalogProvider = RadniNalogProvider();

  DateTime? selectedDate;

  @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: _nosilacPoslaController,
                decoration: InputDecoration(labelText: 'Nosilac Posla'),
              ),
              TextField(
                controller: _opisPrijavljenogController,
                decoration: InputDecoration(labelText: 'Opis Prijavljenog'),
              ),
              TextField(
                controller: _opisUradjenogController,
                decoration: InputDecoration(labelText: 'Opis Uradjenog'),
              ),
              TextField(
                controller: _imePrezimeController,
                decoration: InputDecoration(labelText: 'Ime i Prezime'),
              ),
              TextField(
                controller: _telefonController,
                decoration: InputDecoration(labelText: 'Telefon'),
              ),
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
              TextField(
                controller: _adresaController,
                decoration: InputDecoration(labelText: 'Adresa'),
              ),
              TextField(
                controller: _mjestoController,
                decoration: InputDecoration(labelText: 'Mjesto'),
              ),
              TextField(
                controller: _nazivController,
                decoration: InputDecoration(labelText: 'Naziv'),
              ),
              TextField(
                controller: _kolicinaController,
                decoration: InputDecoration(labelText: 'Količina'),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () async {
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
                  try {
                    _radniNalogProvider.insert(request);
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
                child: Text('Spremi Radni Nalog'),
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
      initialDate:
          DateTime(2024, 1, 1), // Postavite initialDate na 1. januar 2024
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
