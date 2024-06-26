import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:jamfix_mobilna/models/search_result.dart';
import 'package:jamfix_mobilna/models/usluge.dart';
import 'package:jamfix_mobilna/providers/usluge_provider.dart';
import 'package:jamfix_mobilna/utils/utils.dart';
import 'package:jamfix_mobilna/widgets/master_screen.dart';
import 'package:provider/provider.dart';

class UslugeScreen extends StatefulWidget {
  const UslugeScreen({Key? key}) : super(key: key);
  @override
  State<UslugeScreen> createState() => _UslugeScreen();
}

class _UslugeScreen extends State<UslugeScreen> {
  late UslugeProvider _uslugeProvider;
  final _formKey = GlobalKey<FormBuilderState>();
  SearchResult<Usluge>? uslugeResult;

  final TextEditingController _imePrezimeController = TextEditingController();
  @override
  void initState() {
    super.initState();
    _uslugeProvider = context.read<UslugeProvider>();
    _ucitajPodatke();
  }

  Future<void> _ucitajPodatke() async {
    var podaci = await _uslugeProvider.get();

    setState(() {
      uslugeResult = podaci;
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
                  controller: _imePrezimeController,
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  var data = await _uslugeProvider.get(search: {
                    'fts': _imePrezimeController.text,
                  });
                  setState(() {
                    uslugeResult = data;
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
          columns: [
            const DataColumn(
              label: Expanded(
                child: Text(
                  'Ime i prezime',
                  style: TextStyle(
                      fontStyle: FontStyle.italic, color: Colors.blue),
                ),
              ),
            ),
            const DataColumn(
              label: Expanded(
                child: Text(
                  'Uplaceno',
                  style: TextStyle(
                    fontStyle: FontStyle.italic,
                    color: Colors.blue,
                  ),
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
                      fontStyle: FontStyle.italic,
                      color: Colors.blue,
                    ),
                  ),
                ),
              ),
            ),
          ],
          rows: uslugeResult?.result
                  .map(
                    (Usluge e) => DataRow(
                      cells: [
                        DataCell(
                          Text(e.imePrezime.toString()),
                        ),
                        DataCell(
                          Align(
                            alignment: Alignment.center,
                            child: Text(e.cijena.toString()),
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
                                    _uslugeProvider.delete(e.uslugaId);
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const UslugeScreen(),
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
    );
  }
}
