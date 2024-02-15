import 'package:flutter/material.dart';
import 'package:jamfix_admin/models/izvjestaj.dart';
import 'package:jamfix_admin/models/search_result.dart';
import 'package:jamfix_admin/providers/izvjestaj_provider.dart';
import 'package:jamfix_admin/widgets/master_screen.dart';
import 'package:provider/provider.dart';

class IzvjestajiScreen extends StatefulWidget {
  const IzvjestajiScreen({Key? key}) : super(key: key);

  @override
  State<IzvjestajiScreen> createState() => _IzvjestajiScreen();
}

class _IzvjestajiScreen extends State<IzvjestajiScreen> {
  final TextEditingController brojIntervencijaController =
      TextEditingController();
  final TextEditingController najPosMjestoController = TextEditingController();
  final TextEditingController cijenaUtrosAlataController =
      TextEditingController();
  final TextEditingController najOpremaController = TextEditingController();
  late IzvjestajProvider _izvjestajProvider;
  SearchResult<Izvjestaj>? result;
  String selectedMonth = "Januar";
  DateTime? selectedDate;
  DateTime? _selectedDate;
  bool hitnaIntervencija = false;

  @override
  void initState() {
    super.initState();
    _izvjestajProvider = context.read<IzvjestajProvider>();
    _ucitajPodatke();
  }

  Future<void> _ucitajPodatke() async {
    var podaci = await _izvjestajProvider.get(filter: {"month": selectedMonth});

    setState(() {
      result = podaci;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(
      child: Scaffold(
        appBar: AppBar(),
        body: Stack(
          children: [
            Container(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 16.0),
                  _buildDataListView(),
                ],
              ),
            ),
            Positioned(
              bottom: 16.0,
              right: 16.0,
              child: ElevatedButton(
                onPressed: () async {
                  _handleAddReport();
                },
                child: Text("Dodaj novi izvjestaj"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _handleAddReport() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: SingleChildScrollView(
            child: Column(children: [
              TextField(
                decoration:
                    const InputDecoration(labelText: 'Cijena utrosenog alata'),
                controller: cijenaUtrosAlataController,
              ),
              TextField(
                decoration:
                    const InputDecoration(labelText: 'Najposjecenije mjesto'),
                controller: najPosMjestoController,
              ),
              TextField(
                decoration:
                    const InputDecoration(labelText: 'Broj intervnecija'),
                controller: brojIntervencijaController,
              ),
              TextField(
                decoration:
                    const InputDecoration(labelText: 'Najkoristenija oprema'),
                controller: najOpremaController,
              ),
              SizedBox(height: 10,),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => _selectDate(context),
                      child: const Text('Odaberi Datum i Vrijeme'),
                    ),
                  ),
                  const SizedBox(width: 8.0),
                ],
              ),
              Row(children: [
                selectedDate != null
                    ? Text(selectedDate!.toString())
                    : const Text('Nije odabrano'),
              ]),
            ]),
          ),
          actions: [
            ElevatedButton(
              onPressed: () async {
                Izvjestaj request = Izvjestaj(
                  najPosMjesto: najPosMjestoController.text,
                  najOprema: najOpremaController.text,
                  brojIntervencija: int.parse(brojIntervencijaController.text),
                  cijenaUtrosAlata: int.parse(cijenaUtrosAlataController.text),
                  datum: _selectedDate,
                );
                try {
                  _izvjestajProvider.insert(request);
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
              child: const Text('Spremi'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Odustani'),
            ),
          ],
        );
      },
    );
  }

  Expanded _buildDataListView() {
    return Expanded(
      child: SingleChildScrollView(
        child: Row(
          children: [
            Column(
              children: [
                _buildMonthButton(1),
                _buildMonthButton(2),
                _buildMonthButton(3),
                _buildMonthButton(4),
                _buildMonthButton(5),
                _buildMonthButton(6),
                _buildMonthButton(7),
                _buildMonthButton(8),
                _buildMonthButton(9),
                _buildMonthButton(10),
                _buildMonthButton(11),
                _buildMonthButton(12),
              ],
            ),
            const SizedBox(width: 16.0),
            Expanded(
              child: result != null && result!.result.isNotEmpty
                  ? DataTable(
                      columns: const [
                        DataColumn(label: Expanded(child: Text(""))),
                        DataColumn(label: Expanded(child: Text(""))),
                      ],
                      rows: [
                        DataRow(cells: [
                          DataCell(
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text("ID"),
                            ),
                          ),
                          DataCell(
                            Align(
                              alignment: Alignment.centerRight,
                              child: Text(result?.result.first.izvjestajId
                                      ?.toString() ??
                                  ""),
                            ),
                          ),
                        ]),
                        DataRow(cells: [
                          DataCell(
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text("Broj intervencija"),
                            ),
                          ),
                          DataCell(
                            Align(
                              alignment: Alignment.centerRight,
                              child: Text(result?.result.first.brojIntervencija
                                      .toString() ??
                                  ""),
                            ),
                          ),
                        ]),
                        DataRow(cells: [
                          DataCell(
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text("Najposjećenije mjesto"),
                            ),
                          ),
                          DataCell(
                            Align(
                              alignment: Alignment.centerRight,
                              child:
                                  Text(result?.result.first.najPosMjesto ?? ""),
                            ),
                          ),
                        ]),
                        DataRow(cells: [
                          DataCell(
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text("Cijena utrošenog alata"),
                            ),
                          ),
                          DataCell(
                            Align(
                              alignment: Alignment.centerRight,
                              child: Text(result?.result.first.cijenaUtrosAlata
                                      .toString() ??
                                  ""),
                            ),
                          ),
                        ]),
                        DataRow(cells: [
                          DataCell(
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text("Najkorištenija oprema"),
                            ),
                          ),
                          DataCell(
                            Align(
                              alignment: Alignment.centerRight,
                              child: Text(result?.result.first.najOprema ?? ""),
                            ),
                          ),
                        ]),
                        DataRow(cells: [
                          DataCell(
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text("Datum"),
                            ),
                          ),
                          DataCell(
                            Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                  result?.result.first.datum.toString() ?? ""),
                            ),
                          ),
                        ]),
                        DataRow(cells: [
                          DataCell(
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text("Obrisi izvjestaj"),
                            ),
                          ),
                          DataCell(
                            Align(
                              alignment: Alignment.centerRight,
                              child: ElevatedButton(
                                onPressed: () async {
                                  _izvjestajProvider
                                      .delete(result?.result.first.izvjestajId);
                                },
                                child: const Text('Obrisi'),
                              ),
                            ),
                          ),
                        ]),
                      ],
                    )
                  : Center(
                      child: Text(
                        "Nema izvještaja za odabrani mjesec.",
                        style: TextStyle(fontSize: 16.0),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMonthButton(int monthNumber) {
    String monthName = _getMonthName(monthNumber);

    return MenuItemButton(
      onPressed: () {
        setState(() {
          selectedMonth = monthNumber.toString();
        });

        _ucitajPodatkeZaMjesec();
      },
      child: Text(monthName),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
      ),
    );
  }

  Future<void> _ucitajPodatkeZaMjesec() async {
    try {
      var podaci =
          await _izvjestajProvider.get(filter: {"datum": selectedMonth});

      setState(() {
        result = podaci;
      });

      if (result?.result.isEmpty ?? true) {
        setState(() {
          result = null;
        });

        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("Nema izvještaja"),
              content: const Text("Nema izvještaja za odabrani mjesec."),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text("OK"),
                ),
              ],
            );
          },
        );
      }
    } on Exception catch (e) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Greška"),
            content:
                Text("Došlo je do greške prilikom dohvaćanja izvještaja: $e"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text("OK"),
              ),
            ],
          );
        },
      );
    }
  }

  String _getMonthName(int monthNumber) {
    switch (monthNumber) {
      case 1:
        return "Januar";
      case 2:
        return "Februar";
      case 3:
        return "Mart";
      case 4:
        return "April";
      case 5:
        return "Maj";
      case 6:
        return "Jun";
      case 7:
        return "Jul";
      case 8:
        return "August";
      case 9:
        return "Septembar";
      case 10:
        return "Oktobar";
      case 11:
        return "Novembar";
      case 12:
        return "Decembar";
      default:
        return "Nepoznat";
    }
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
          _selectedDate = DateTime(
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
