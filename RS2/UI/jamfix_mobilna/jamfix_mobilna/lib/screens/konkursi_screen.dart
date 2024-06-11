import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jamfix_mobilna/models/konkurs.dart';
import 'package:jamfix_mobilna/models/search_result.dart';
import 'package:jamfix_mobilna/providers/konkurs_provider.dart';
import 'package:jamfix_mobilna/screens/konkurs_detail_screen.dart';
import 'package:jamfix_mobilna/utils/utils.dart';
import 'package:jamfix_mobilna/widgets/master_screen.dart';
import 'package:provider/provider.dart';

class KonkursiScreen extends StatefulWidget {
  const KonkursiScreen({Key? key}) : super(key: key);
  @override
  State<KonkursiScreen> createState() => _KonkursiScreen();
}

class _KonkursiScreen extends State<KonkursiScreen> {
  KonkursProvider _konkursProvider = KonkursProvider();

  SearchResult<Konkurs>? konkursResult;

  @override
  void initState() {
    super.initState();
    _konkursProvider = context.read<KonkursProvider>();
    _ucitajPodatke();
  }

  Future<void> _ucitajPodatke() async {
    var konkurs = await _konkursProvider.get();

    setState(() {
      konkursResult = konkurs;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(
      child: Scaffold(
        appBar: AppBar(),
        body: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildSearch(),
                  const SizedBox(height: 16.0),
                  _buildDataListView(),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Visibility(
                  visible: Authorization.isAdmin,
                  child: FloatingActionButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => KonkursDetailScreen(),
                        ),
                      );
                    },
                    child: const Icon(Icons.add),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearch() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [],
      ),
    );
  }

  Expanded _buildDataListView() {
    return Expanded(
      child: SingleChildScrollView(
        child: Center(
          child: DataTable(
            columns: [
              DataColumn(
                label: Expanded(
                  child: Visibility(
                    visible: Authorization.isKorisnik,
                    child: const Text(
                      'Datum zavrsetka',
                      style: TextStyle(
                          fontStyle: FontStyle.italic, color: Colors.blue),
                    ),
                  ),
                ),
              ),
              const DataColumn(
                label: Expanded(
                  child: Text(
                    'Tražena pozicija',
                    style: TextStyle(
                        fontStyle: FontStyle.italic, color: Colors.blue),
                  ),
                ),
              ),
              DataColumn(
                label: Expanded(
                  child: Visibility(
                    visible: Authorization.isAdmin,
                    child: const Text(
                      'Akcija',
                      style: TextStyle(
                          fontStyle: FontStyle.italic, color: Colors.blue),
                    ),
                  ),
                ),
              ),
            ],
            rows: konkursResult?.result
                    .map(
                      (Konkurs e) => DataRow(
                        onSelectChanged: (selected) => {
                          if (selected == true)
                            {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) =>
                                      KonkursDetailScreen(konkurs: e),
                                ),
                              )
                            }
                        },
                        cells: [
                          DataCell(
                            Visibility(
                              visible: Authorization.isKorisnik,
                              child: Align(
                                alignment: Alignment.center,
                                child: Text(e.datumZavrsetka != null
                                    ? DateFormat('dd-MM-yyyy')
                                        .format(e.datumZavrsetka!)
                                    : ""),
                              ),
                            ),
                          ),
                          DataCell(
                            Align(
                              alignment: Alignment.center,
                              child: Text(e.trazenaPozicija ?? ""),
                            ),
                          ),
                          DataCell(
                            Row(
                              children: [
                                Visibility(
                                  visible: Authorization.isAdmin,
                                  child: IconButton(
                                    icon: const Icon(Icons.delete),
                                    onPressed: () {
                                      _konkursProvider.delete(e.konkursId);
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const KonkursiScreen(),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                    .toList() ??
                [],
          ),
        ),
      ),
    );
  }
}
