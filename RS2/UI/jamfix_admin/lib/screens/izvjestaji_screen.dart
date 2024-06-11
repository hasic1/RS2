import 'package:flutter/material.dart';
import 'package:jamfix_admin/models/izvjestaj.dart';
import 'package:jamfix_admin/models/radni_nalog.dart';
import 'package:jamfix_admin/models/search_result.dart';
import 'package:jamfix_admin/providers/izvjestaj_provider.dart';
import 'package:jamfix_admin/providers/radni_nalog_provider.dart';
import 'package:jamfix_admin/widgets/master_screen.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:provider/provider.dart';
import 'package:pdf/widgets.dart' as pw;

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
  late RadniNalogProvider _radniNalogProvider;
  SearchResult<RadniNalog>? radniNalogresult;
  String selectedMonth = "1";
  DateTime? selectedDate;
  bool hitnaIntervencija = false;

  @override
  void initState() {
    super.initState();
    _radniNalogProvider = context.read<RadniNalogProvider>();
    _ucitajPodatke();
  }

  Future<void> _ucitajPodatke() async {
    var podaciRadniNalog =
        await _radniNalogProvider.get(filter: {"fts": selectedMonth});
    setState(() {
      radniNalogresult = podaciRadniNalog;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Izvještaji"),
          actions: [
            IconButton(
              icon: const Icon(Icons.download),
              onPressed: _generatePdfAndDownload,
            ),
            const Text("Download PDF"),
          ],
        ),
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
          ],
        ),
      ),
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
              child: radniNalogresult != null &&
                      radniNalogresult!.result.isNotEmpty
                  ? DataTable(
                      columns: const [
                        DataColumn(label: Expanded(child: Text(""))),
                        DataColumn(label: Expanded(child: Text(""))),
                      ],
                      rows: [
                        DataRow(
                          cells: [
                            const DataCell(
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text("Najkorištenija oprema"),
                              ),
                            ),
                            DataCell(
                              Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                    getNajkoristenijaOprema(radniNalogresult)),
                              ),
                            ),
                          ],
                        ),
                        DataRow(
                          cells: [
                            const DataCell(
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text("Najposjećenije mjesto"),
                              ),
                            ),
                            DataCell(
                              Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                    getNajposjecenijeMjesto(radniNalogresult)),
                              ),
                            ),
                          ],
                        ),
                        DataRow(
                          cells: [
                            const DataCell(
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text("Kolicina utrošenog alata"),
                              ),
                            ),
                            DataCell(
                              Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                    getKolicinaUtrosenogAlata(radniNalogresult)
                                        .toString()),
                              ),
                            ),
                          ],
                        ),
                        DataRow(
                          cells: [
                            const DataCell(
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text("Broj intervencija"),
                              ),
                            ),
                            DataCell(
                              Align(
                                alignment: Alignment.centerRight,
                                child: Text(radniNalogresult?.result.length
                                        .toString() ??
                                    '0'),
                              ),
                            ),
                          ],
                        ),
                      ],
                    )
                  : const Center(
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
          await _radniNalogProvider.get(filter: {"FTS": selectedMonth});

      setState(() {
        radniNalogresult = podaci;
      });

      if (radniNalogresult?.result.isEmpty ?? true) {
        setState(() {
          radniNalogresult = null;
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

  String getNajkoristenijaOprema(SearchResult<RadniNalog>? radniNalozi) {
    if (radniNalozi == null || radniNalozi.result.isEmpty) return 'N/A';

    Map<String, int> opremaCount = {};

    radniNalozi?.result?.forEach((nalog) {
      final naziv = nalog?.naziv;
      if (naziv != null) {
        opremaCount[naziv] = (opremaCount[naziv] ?? 0) + 1;
      }
    });

    var najkoristenijaOprema =
        opremaCount.entries.reduce((a, b) => a.value > b.value ? a : b).key;
    return najkoristenijaOprema;
  }

  String getNajposjecenijeMjesto(SearchResult<RadniNalog>? radniNalozi) {
    if (radniNalozi == null || radniNalozi.result.isEmpty) return 'N/A';

    Map<String, int> mjestoCount = {};

    radniNalozi?.result?.forEach((nalog) {
      final mjesto = nalog?.mjesto;
      if (mjesto != null) {
        mjestoCount[mjesto] = (mjestoCount[mjesto] ?? 0) + 1;
      }
    });

    var najposjecenijeMjesto =
        mjestoCount.entries.reduce((a, b) => a.value > b.value ? a : b).key;
    return najposjecenijeMjesto;
  }

  int getKolicinaUtrosenogAlata(SearchResult<RadniNalog>? radniNalozi) {
    if (radniNalozi == null || radniNalozi.result.isEmpty) return 0;

    int ukupnaCijena = 0;

    radniNalozi.result.forEach((nalog) {
      if (nalog.kolicina != null) {
        ukupnaCijena += nalog.kolicina!;
      }
    });

    return ukupnaCijena;
  }

  Future<void> _generatePdfAndDownload() async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(
                  "Izvještaj za mjesec: ${_getMonthName(int.parse(selectedMonth))}",
                  style: pw.TextStyle(fontSize: 24)),
              pw.SizedBox(height: 16),
              pw.Text(
                  "Najkorištenija oprema: ${getNajkoristenijaOprema(radniNalogresult)}"),
              pw.Text(
                  "Najposjećenije mjesto: ${getNajposjecenijeMjesto(radniNalogresult)}"),
              pw.Text(
                  "Količina utrošenog alata: ${getKolicinaUtrosenogAlata(radniNalogresult)}"),
              pw.Text(
                  "Broj intervencija: ${radniNalogresult?.result.length ?? 0}"),
            ],
          );
        },
      ),
    );

    await Printing.layoutPdf(
        onLayout: (PdfPageFormat format) async => pdf.save());
  }
}
