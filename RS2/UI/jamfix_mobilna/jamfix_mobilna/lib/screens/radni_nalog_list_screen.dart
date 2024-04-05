import 'package:flutter/material.dart';
import 'package:jamfix_mobilna/models/radni_nalog.dart';
import 'package:jamfix_mobilna/models/search_result.dart';
import 'package:jamfix_mobilna/providers/radni_nalog_provider.dart';
import 'package:jamfix_mobilna/screens/radni_nalog_screen.dart';
import 'package:jamfix_mobilna/widgets/master_screen.dart';
import 'package:provider/provider.dart';

class RadniNalogListScreen extends StatefulWidget {
  RadniNalogListScreen({Key? key}) : super(key: key);
  @override
  State<RadniNalogListScreen> createState() => _RadniNalogListScreen();
}

class _RadniNalogListScreen extends State<RadniNalogListScreen> {
  late RadniNalogProvider _radniNalogProvider;
  SearchResult<RadniNalog>? result;

  final TextEditingController _ftsController = TextEditingController();
  @override
  void initState() {
    super.initState();
    _radniNalogProvider = context.read<RadniNalogProvider>();
    _ucitajPodatke();
  }

  Future<void> _ucitajPodatke() async {
    var podaci = await _radniNalogProvider.get();

    setState(() {
      result = podaci;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(
      child: Scaffold(
        appBar: AppBar(),
        body: Container(
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
                  controller: _ftsController,
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  var data = await _radniNalogProvider
                      .get(search: {'fts': _ftsController.text});
                  setState(() {
                    result = data;
                  });
                },
                child: const Text("Pretraga"),
              ),
              const SizedBox(
                height: 8,
              ),
              ElevatedButton(
                onPressed: () async {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => RadniNalogScreen(radniNalog: null),
                    ),
                  );
                },
                child: const Text("Dodaj"),
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
              label: Expanded(
                child: Text('Nosilac posla',
                    style: TextStyle(fontStyle: FontStyle.italic)),
              ),
            ),
            DataColumn(
              label: Expanded(
                child: Text('Akcija',
                    textAlign: TextAlign.left,
                    style: TextStyle(fontStyle: FontStyle.italic)),
              ),
            ),
          ],
          rows: result?.result
                  .map(
                    (RadniNalog e) => DataRow(
                      onSelectChanged: (selected) => {
                        if (selected == true)
                          {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) =>
                                    RadniNalogScreen(radniNalog: e),
                              ),
                            )
                          }
                      },
                      cells: [
                        DataCell(Text(e.nosilacPosla ?? "")),
                        DataCell(
                          Row(
                            children: [
                              IconButton(
                                icon: const Icon(Icons.delete),
                                onPressed: () {
                                  _radniNalogProvider.delete(e.nalogId);
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          RadniNalogListScreen(),
                                    ),
                                  );
                                },
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
    );
  }
}
