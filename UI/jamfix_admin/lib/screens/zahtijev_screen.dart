import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:jamfix_admin/models/search_result.dart';
import 'package:jamfix_admin/models/statusZahtjeva.dart';
import 'package:jamfix_admin/models/zahtjev.dart';
import 'package:jamfix_admin/providers/statusZahtjevaProvider.dart';
import 'package:jamfix_admin/providers/zahtjev_provider.dart';
import 'package:jamfix_admin/screens/zahtjevi_list_screen.dart';
import 'package:jamfix_admin/utils/util.dart';
import 'package:jamfix_admin/widgets/master_screen.dart';
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

  StatusZahtjevaProvider _statusZahtjevaProvider = StatusZahtjevaProvider();
  ZahtjevProvider _zahtjevProvider = ZahtjevProvider();

  SearchResult<StatusZahtjeva>? result;
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
    _statusZahtjevaProvider = context.read<StatusZahtjevaProvider>();
    initForm();
  }

  Future initForm() async {
    result = await _statusZahtjevaProvider.get();

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(
      child: Scaffold(
        appBar: AppBar(),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
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
                Visibility(
                  visible: Authorization.isAdmin,
                  child: Row(
                    children: [
                      Expanded(
                        child: FormBuilderDropdown<String>(
                          name: 'statusZahtjevaId',
                          decoration: InputDecoration(
                            labelText: 'Status zahtjeva',
                            suffix: IconButton(
                              icon: const Icon(Icons.close),
                              onPressed: () {
                                setState(() {
                                  selectedStatusZahtjevaId =
                                      _initialValue['statusZahtjevaId']
                                              ?.toString() ??
                                          null;
                                });
                              },
                            ),
                            hintText: 'Odaberi status zahtjeva',
                          ),
                          items: result?.result
                                  .map((item) => DropdownMenuItem(
                                        alignment: AlignmentDirectional.center,
                                        value: item.statusZahtjevaId.toString(),
                                        child: Text(item.opis ?? ""),
                                      ))
                                  .toList() ??
                              [],
                          onChanged: (value) {
                            setState(() {
                              selectedStatusZahtjevaId = value;
                            });
                          },
                          initialValue: _initialValue['statusZahtjevaId'] !=
                                      null &&
                                  result?.result != null &&
                                  result!.result
                                      .map((item) =>
                                          item.statusZahtjevaId.toString())
                                      .contains(
                                          _initialValue['statusZahtjevaId']
                                              .toString())
                              ? _initialValue['statusZahtjevaId'].toString()
                              : null,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 35.0),
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
                        statusZahtjevaId:
                            int.tryParse(selectedStatusZahtjevaId ?? "") ?? 0,
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
