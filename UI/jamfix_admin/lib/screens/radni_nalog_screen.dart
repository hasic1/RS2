import 'package:flutter/material.dart';
import 'package:jamfix_admin/models/radni_nalog.dart';
import 'package:jamfix_admin/providers/radni_nalog_provider.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: Text('Radni Nalog'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            ListTile(
              title: Text('Nosilac Posla'),
              subtitle: TextField(
                controller: _nosilacPoslaController,
              ),
            ),
            ListTile(
              title: Text('Opis Prijavljenog'),
              subtitle: TextField(
                controller: _opisPrijavljenogController,
              ),
            ),
            ListTile(
              title: Text('Opis Uradjenog'),
              subtitle: TextField(
                controller: _opisUradjenogController,
              ),
            ),
            ListTile(
              title: Text('Ime i Prezime'),
              subtitle: TextField(
                controller: _imePrezimeController,
              ),
            ),
            ListTile(
              title: Text('Telefon'),
              subtitle: TextField(
                controller: _telefonController,
              ),
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
                selectedDate != null
                    ? Text(selectedDate!.toString())
                    : const Text('Nije odabrano'),
              ],
            ),
            ListTile(
              title: Text('Adresa'),
              subtitle: TextField(
                controller: _adresaController,
              ),
            ),
            ListTile(
              title: Text('Mjesto'),
              subtitle: TextField(
                controller: _mjestoController,
              ),
            ),
            ListTile(
              title: Text('Naziv'),
              subtitle: TextField(
                controller: _nazivController,
              ),
            ),
            ListTile(
              title: Text('Količina'),
              subtitle: TextField(
                controller: _kolicinaController,
                keyboardType: TextInputType.number,
              ),
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
                    kolicina: int.parse(_kolicinaController.text));
                try {
                  _radniNalogProvider.insert(request);
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
}
