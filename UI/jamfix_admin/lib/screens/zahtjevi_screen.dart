import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:jamfix_admin/models/search_result.dart';
import 'package:jamfix_admin/models/statusZahtjeva.dart';
import 'package:jamfix_admin/models/zahtjev.dart';
import 'package:jamfix_admin/providers/statusZahtjevaProvider.dart';
import 'package:jamfix_admin/providers/zahtjev_provider.dart';
import 'package:jamfix_admin/screens/zahtijev_list.screen.dart';
import 'package:jamfix_admin/widgets/master_screen.dart';
import 'package:provider/provider.dart';

class ZahtjevScreen extends StatefulWidget {
  const ZahtjevScreen({Key? key}) : super(key: key);
  @override
  State<ZahtjevScreen> createState() => _ZahtjevScreen();
}

class _ZahtjevScreen extends State<ZahtjevScreen> {
  late ZahtjevProvider _zahtjevProvider;
  late StatusZahtjevaProvider _statusZahtjevaProvider;
  late List<StatusZahtjeva> _statusiZahtjeva;

  final _formKey = GlobalKey<FormBuilderState>();
  SearchResult<Zahtjev>? zahtjevResult;

  TextEditingController _imePrezimeController = new TextEditingController();
  @override
  void initState() {
    super.initState();
    _zahtjevProvider = context.read<ZahtjevProvider>();
    _statusZahtjevaProvider = context.read<StatusZahtjevaProvider>();
    _ucitajPodatke();
    _ucitajStatuseZahtjeva();
  }

  Future<void> _ucitajStatuseZahtjeva() async {
    _statusiZahtjeva = await _statusZahtjevaProvider.getSviStatusiZahtjeva();
  }

  Future<void> _ucitajPodatke() async {
    var podaci = await _zahtjevProvider.get();

    setState(() {
      zahtjevResult = podaci;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(
      child: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildSearch(),
            const SizedBox(height: 16.0),
            _buildDataListView(),
          ],
        ),
      ),
    );
  }

  Widget _buildSearch() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TextField(
                  decoration:
                      const InputDecoration(labelText: "Ime ili prezime"),
                  controller: _imePrezimeController,
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  print("login proceed");

                  var data = await _zahtjevProvider.get(filter: {
                    'fts': _imePrezimeController.text,
                  });
                  setState(() {
                    zahtjevResult = data;
                  });
                },
                child: const Text("Pretraga"),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Expanded _buildDataListView() {
    return Expanded(
      child: SingleChildScrollView(
        child: DataTable(
          columns: const [
            DataColumn(
              label: Text(
                'Ime i prezime',
                style:
                    TextStyle(fontStyle: FontStyle.italic, color: Colors.blue),
              ),
            ),
            DataColumn(
              label: Text(
                'Opis',
                style:
                    TextStyle(fontStyle: FontStyle.italic, color: Colors.blue),
              ),
            ),
            DataColumn(
              label: Text(
                'Datum i vrijeme',
                style:
                    TextStyle(fontStyle: FontStyle.italic, color: Colors.blue),
              ),
            ),
            DataColumn(
              label: Text(
                'Status zahtjeva',
                style:
                    TextStyle(fontStyle: FontStyle.italic, color: Colors.blue),
              ),
            ),
            DataColumn(
              label: Text(
                'Akcija',
                style:
                    TextStyle(fontStyle: FontStyle.italic, color: Colors.blue),
              ),
            ),
            DataColumn(
              label: Text(
                'Hitna intervencija',
                style:
                    TextStyle(fontStyle: FontStyle.italic, color: Colors.blue),
              ),
            ),
          ],
          rows: zahtjevResult?.result
                  .map(
                    (Zahtjev e) => DataRow(
                      onSelectChanged: (selected) => {
                        if (selected == true)
                          {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) =>
                                    ZahtjevListScreen(zahtjev: e),
                              ),
                            )
                          }
                      },
                      cells: [
                        DataCell(Text(e.imePrezime ?? "")),
                        DataCell(Text(e.opis ?? "")),
                        DataCell(Text(e.datumVrijeme.toString() ?? "")),
                        DataCell(Align(
                          alignment: Alignment.center,
                          child: Text(
                            _statusiZahtjeva
                                .firstWhere(
                                  (status) =>
                                      status.statusZahtjevaId ==
                                      e.statusZahtjevaId,
                                  orElse: () => StatusZahtjeva(),
                                )
                                .opis!,
                          ),
                        )),
                        DataCell(
                          Row(
                            children: [
                              IconButton(
                                icon: Icon(Icons.check_sharp),
                                onPressed: () async {
                                  await _zahtjevProvider.delete(e.zahtjevId);
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ZahtjevScreen(),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                        DataCell(
                          Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                if (e.hitnaIntervencija == true)
                                  Icon(
                                    Icons.warning,
                                    color: Colors.red,
                                  ),
                                Text(
                                  e.hitnaIntervencija == true ? "" : 'Normalno',
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                  .toList() ??
              [],
        ),
      ),
    );
  }
}
