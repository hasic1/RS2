import 'package:flutter/material.dart';
import 'package:jamfix_mobilna/models/konkurs.dart';
import 'package:jamfix_mobilna/models/prijava.dart';
import 'package:jamfix_mobilna/models/search_result.dart';
import 'package:jamfix_mobilna/providers/konkurs_provider.dart';
import 'package:jamfix_mobilna/providers/prijava_provider.dart';
import 'package:jamfix_mobilna/screens/prijave_detail_screen.dart';
import 'package:jamfix_mobilna/utils/utils.dart';
import 'package:jamfix_mobilna/widgets/master_screen.dart';
import 'package:provider/provider.dart';

class PrijavaScreen extends StatefulWidget {
  const PrijavaScreen({Key? key}) : super(key: key);

  @override
  State<PrijavaScreen> createState() => _PrijavaScreen();
}

class _PrijavaScreen extends State<PrijavaScreen> {
  PrijavaProvider _prijavaProvider = PrijavaProvider();
  KonkursProvider _konkursProvider = KonkursProvider();

  SearchResult<Prijava>? prijavaResult;
  SearchResult<Konkurs>? _konkursResult;

  @override
  void initState() {
    super.initState();
    _prijavaProvider = context.read<PrijavaProvider>();
    _konkursProvider = context.read<KonkursProvider>();
    _ucitajPodatke();
  }

  Future<void> _ucitajPodatke() async {
    var prijava = await _prijavaProvider.get();
    var konkurs = await _konkursProvider.get();

    setState(() {
      prijavaResult = prijava;
      _konkursResult = konkurs;
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
            columns: const [
              DataColumn(
                label: Expanded(
                  child: Text(
                    'Ime',
                    style: TextStyle(
                        fontStyle: FontStyle.italic, color: Colors.blue),
                  ),
                ),
              ),
              DataColumn(
                label: Expanded(
                  child: Text(
                    'Prezime',
                    style: TextStyle(
                        fontStyle: FontStyle.italic, color: Colors.blue),
                  ),
                ),
              ),
              DataColumn(
                label: Expanded(
                  child: Text(
                    'Akcija',
                    style: TextStyle(
                        fontStyle: FontStyle.italic, color: Colors.blue),
                  ),
                ),
              ),
            ],
            rows: prijavaResult?.result.map(
                  (Prijava e) {
                    var konkurs = _konkursResult?.result.firstWhere(
                      (k) => k.konkursId == e.konkursId,
                      orElse: () => Konkurs(),
                    );
                    return DataRow(
                      onSelectChanged: (selected) => {
                        if (selected == true)
                          {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) =>
                                    PrijavaDetailScreen(prijava: e),
                              ),
                            )
                          }
                      },
                      cells: [
                        DataCell(Text(e.ime ?? "")),
                        DataCell(Text(e.prezime ?? "")),
                        DataCell(
                          Row(
                            children: [
                              Visibility(
                                visible: Authorization.isAdmin,
                                child: IconButton(
                                  icon: const Icon(Icons.delete),
                                  onPressed: () {
                                    _prijavaProvider.delete(e.prijavaId);
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const PrijavaScreen(),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                ).toList() ??
                [],
          ),
        ),
      ),
    );
  }
}
