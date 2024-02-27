import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:jamfix_admin/models/radni_nalog.dart';
import 'package:jamfix_admin/models/search_result.dart';
import 'package:jamfix_admin/providers/radni_nalog_provider.dart';
import 'package:jamfix_admin/screens/radni_nalog_screen.dart';
import 'package:jamfix_admin/widgets/master_screen.dart';
import 'package:provider/provider.dart';

class RadniNalogListScreen extends StatefulWidget {
  const RadniNalogListScreen({Key? key}) : super(key: key);
  @override
  State<RadniNalogListScreen> createState() => _RadniNalogListScreen();
}

class _RadniNalogListScreen extends State<RadniNalogListScreen> {
  late RadniNalogProvider _radniNalogProvider;
  final _formKey = GlobalKey<FormBuilderState>();
  SearchResult<RadniNalog>? result;

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
              const Expanded(
                child: TextField(
                  decoration: InputDecoration(labelText: "Ime ili prezime"),
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  var data = await _radniNalogProvider.get(filter: {});
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
                      builder: (context) => RadniNalogScreen(),
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
                child: Text(
                  'ID',
                  style: TextStyle(
                      fontStyle: FontStyle.italic, color: Colors.blue),
                ),
              ),
            ),
            DataColumn(
              label: Text(
                'Nosilac posla',
                style:
                    TextStyle(fontStyle: FontStyle.italic, color: Colors.blue),
              ),
            ),
            DataColumn(
              label: Text(
                'Adresa',
                style:
                    TextStyle(fontStyle: FontStyle.italic, color: Colors.blue),
              ),
            ),
            DataColumn(
              label: Text(
                'Ime i prezime',
                style:
                    TextStyle(fontStyle: FontStyle.italic, color: Colors.blue),
              ),
            ),
            DataColumn(
              label: Text(
                'Telefon',
                style:
                    TextStyle(fontStyle: FontStyle.italic, color: Colors.blue),
              ),
            ),
            DataColumn(
              label: Text(
                'Datum',
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
          ],
          rows: result?.result
                  .map(
                    (RadniNalog e) => DataRow(
                      cells: [
                        DataCell(Text(e.nalogId?.toString() ?? "")),
                        DataCell(Text(e.nosilacPosla ?? "")),
                        DataCell(Text(e.adresa ?? "")),
                        DataCell(Text(e.imePrezime ?? "")),
                        DataCell(Text(e.telefon.toString() ?? "")),
                        DataCell(Text(e.datum.toString() ?? "")),
                        DataCell(
                          Row(
                            children: [
                              IconButton(
                                icon:const Icon(Icons.delete),
                                onPressed: () {
                                  _radniNalogProvider.delete(e.nalogId);
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
