import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jamfix_mobilna/models/konkurs.dart';
import 'package:jamfix_mobilna/models/prijava.dart';
import 'package:jamfix_mobilna/models/search_result.dart';
import 'package:jamfix_mobilna/providers/konkurs_provider.dart';
import 'package:jamfix_mobilna/providers/prijava_provider.dart';
import 'package:jamfix_mobilna/screens/konkursi_screen.dart';
import 'package:jamfix_mobilna/utils/utils.dart';
import 'package:jamfix_mobilna/widgets/master_screen.dart';
import 'package:provider/provider.dart';

class KonkursDetailScreen extends StatefulWidget {
  Konkurs? konkurs;
  KonkursDetailScreen({this.konkurs, Key? key}) : super(key: key);
  @override
  State<KonkursDetailScreen> createState() => _KonkursDetailScreen();
}

class _KonkursDetailScreen extends State<KonkursDetailScreen> {
  final TextEditingController brojIzvrsitelja = TextEditingController();
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController trazenaPozicija = TextEditingController();
  bool userRole = true;

  SearchResult<Konkurs>? konkursResult;

  KonkursProvider konkursProvider = KonkursProvider();
  PrijavaProvider prijavaProvider = PrijavaProvider();

  final _formKey = GlobalKey<FormState>();
  Map<String, dynamic> _initialValue = {};
  DateTime? selectedDate;

  @override
  void initState() {
    super.initState();
    if (widget.konkurs != null) {
      setState(() {
        _initialValue = {
          'trazenaPozicija': widget.konkurs?.trazenaPozicija,
          'brojIzvrsitelja': widget.konkurs?.brojIzvrsitelja?.toString(),
          'datumZavrsetka': widget.konkurs?.datumZavrsetka,
        };
        brojIzvrsitelja.text = _initialValue['brojIzvrsitelja'] ?? '';
        trazenaPozicija.text = _initialValue['trazenaPozicija'] ?? '';
        selectedDate = _initialValue['datumZavrsetka'] ?? '';
        if (selectedDate != null) {
          _startDateController.text =
              DateFormat('dd.MM.yyyy.').format(selectedDate!);
        }
      });
    }
    konkursProvider = context.read<KonkursProvider>();
    _ucitajPodatke();
  }

  Future<void> _ucitajPodatke() async {
    var podaci = await konkursProvider.get();

    setState(() {
      konkursResult = podaci;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(
      child: Scaffold(
        appBar: AppBar(),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: _startDateController,
                          enabled: userRole == Authorization.isAdmin,
                          decoration: const InputDecoration(
                            labelText: 'Datum zavrsetka konkursa',
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
                              initialDate: selectedDate ?? DateTime.now(),
                              firstDate: DateTime.now(),
                              lastDate: DateTime(2101),
                            );
                            if (pickedDate != null &&
                                pickedDate != selectedDate) {
                              setState(() {
                                selectedDate = pickedDate;
                                _startDateController.text =
                                    DateFormat('dd.MM.yyyy.')
                                        .format(pickedDate);
                              });
                            }
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Obavezan unos datuma!';
                            }
                            return null;
                          },
                          style: const TextStyle(color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16.0),
                  TextFormField(
                    controller: trazenaPozicija,
                    enabled: userRole == Authorization.isAdmin,
                    decoration:
                        const InputDecoration(labelText: 'Tražena pozicija'),
                    validator: (name) => name!.length < 3
                        ? 'Tražena pozicija mora imati bar 3 slova'
                        : null,
                  ),
                  TextFormField(
                    controller: brojIzvrsitelja,
                    enabled: userRole == Authorization.isAdmin,
                    decoration:
                        const InputDecoration(labelText: 'Broj izvršilaca'),
                    validator: (value) =>
                        value!.isEmpty ? 'Polje ne može biti prazno' : null,
                  ),
                  const SizedBox(height: 16.0),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Visibility(
                      visible: Authorization.isAdmin,
                      child: ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            int? brojIzvrsiteljaValue;
                            try {
                              brojIzvrsiteljaValue =
                                  int.parse(brojIzvrsitelja.text);
                            } catch (e) {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) => AlertDialog(
                                  title: const Text("Greška"),
                                  content: const Text(
                                      "Broj izvršilaca mora biti validan broj"),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Text("OK"),
                                    ),
                                  ],
                                ),
                              );
                              return;
                            }
                            Konkurs request = Konkurs(
                              datumZavrsetka: selectedDate,
                              brojIzvrsitelja: brojIzvrsiteljaValue,
                              trazenaPozicija: trazenaPozicija.text,
                            );
                            if (widget.konkurs == null) {
                              await konkursProvider.insert(request);
                              showDialog(
                                context: context,
                                builder: (BuildContext context) => AlertDialog(
                                  title: const Text("Uspjeh"),
                                  content: const Text(
                                      "Uspješno ste napravili radni nalog"),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const KonkursiScreen(),
                                          ),
                                        );
                                      },
                                      child: const Text("OK"),
                                    ),
                                  ],
                                ),
                              );
                            } else {
                              await konkursProvider.update(
                                  widget.konkurs?.konkursId, request);
                              showDialog(
                                context: context,
                                builder: (BuildContext context) => AlertDialog(
                                  title: const Text("Uspjeh"),
                                  content: const Text(
                                      "Uspješno ste izvršili promjene"),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const KonkursiScreen(),
                                          ),
                                        );
                                      },
                                      child: const Text("OK"),
                                    ),
                                  ],
                                ),
                              );
                            }
                          }
                        },
                        child: const Text('Potvrdi Unos'),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Visibility(
                      visible: Authorization.isKorisnik,
                      child: ElevatedButton(
                        onPressed: () {
                          Prijava request = Prijava(
                              ime: Authorization.ime,
                              prezime: Authorization.prezime,
                              email: Authorization.email,
                              brojTelefona: Authorization.telefon,
                              konkursId: widget.konkurs?.konkursId,
                              datumPrijave: DateTime.now());
                          prijavaProvider.insert(request);
                          showDialog(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                              title: const Text("Uspjeh"),
                              content: const Text(
                                  "Uspješno ste se prijavili na konkurs"),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const KonkursiScreen(),
                                      ),
                                    );
                                  },
                                  child: const Text("OK"),
                                ),
                              ],
                            ),
                          );
                        },
                        child: const Text('Prijava na konkurs'),
                      ),
                    ),
                  )
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
