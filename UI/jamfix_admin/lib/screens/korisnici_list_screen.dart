import 'package:flutter/material.dart';
import 'package:jamfix_admin/models/drzava.dart';
import 'package:jamfix_admin/models/korisnici.dart';
import 'package:jamfix_admin/models/pozicija.dart';
import 'package:jamfix_admin/models/search_result.dart';
import 'package:jamfix_admin/providers/drzava_provider.dart';
import 'package:jamfix_admin/providers/korisnici_provider.dart';
import 'package:jamfix_admin/providers/pozicija_provider.dart';
import 'package:jamfix_admin/screens/korisnici_detail_screen.dart';
import 'package:jamfix_admin/widgets/master_screen.dart';
import 'package:provider/provider.dart';

class KorisniciListScreen extends StatefulWidget {
  const KorisniciListScreen({Key? key}) : super(key: key);
  @override
  State<KorisniciListScreen> createState() => _KorisniciListScreen();
}

class _KorisniciListScreen extends State<KorisniciListScreen> {
  KorisniciProvider _korisniciProvider = KorisniciProvider();
  PozicijaProvider _pozicijaProvider = PozicijaProvider();
  DrzavaProvider _drzavaProvider = DrzavaProvider();

  SearchResult<Korisnici>? korisniciResult;
  SearchResult<Pozicija>? pozicijaResult;
  SearchResult<Drzava>? drzavaResult;

  bool aktivan = false;
  String? selectedPozicijaId;
  String? selectedDrzavaId;

  final TextEditingController _imePrezimeController = TextEditingController();
  @override
  void initState() {
    super.initState();
    _korisniciProvider = context.read<KorisniciProvider>();
    _pozicijaProvider = context.read<PozicijaProvider>();
    _drzavaProvider = context.read<DrzavaProvider>();

    _ucitajPodatke();
  }

  Future<void> _ucitajPodatke() async {
    var pozicije = await _pozicijaProvider.get();
    var podaci = await _korisniciProvider.get();
    var drzava = await _drzavaProvider.get();

    setState(() {
      pozicijaResult = pozicije;
      korisniciResult = podaci;
      drzavaResult = drzava;
    });

    for (var korisnik in podaci.result) {
      String uloga = await fetchUlogeZaKorisnika(korisnik.korisnikId);
    }
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
                  var data = await _korisniciProvider.get(filter: {
                    'fts': _imePrezimeController.text,
                  });
                  setState(() {
                    korisniciResult = data;
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
                style:
                    TextStyle(fontStyle: FontStyle.italic, color: Colors.blue),
              ),
            )),
            DataColumn(
              label: Expanded(
                  child: Text(
                'Korisnicko ime',
                style:
                    TextStyle(fontStyle: FontStyle.italic, color: Colors.blue),
              )),
            ),
            DataColumn(
              label: Expanded(
                child: Text(
                  'Email',
                  style: TextStyle(
                      fontStyle: FontStyle.italic, color: Colors.blue),
                ),
              ),
            ),
            DataColumn(
              label: Expanded(
                  child: Text(
                'Pozicija',
                style:
                    TextStyle(fontStyle: FontStyle.italic, color: Colors.blue),
              )),
            ),
            DataColumn(
              label: Expanded(
                child: Text(
                  'Uloga',
                  style: TextStyle(
                      fontStyle: FontStyle.italic, color: Colors.blue),
                ),
              ),
            ),
            DataColumn(
              label: Expanded(
                child: Text(
                  'Aktivan',
                  style: TextStyle(
                      fontStyle: FontStyle.italic, color: Colors.blue),
                ),
              ),
            ),
            DataColumn(
                label: Expanded(
              child: Text(
                'Akcija',
                style:
                    TextStyle(fontStyle: FontStyle.italic, color: Colors.blue),
              ),
            )),
          ],
          rows: korisniciResult?.result
                  .map(
                    (Korisnici e) => DataRow(
                      onSelectChanged: (selected) => {
                        if (selected == true)
                          {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) =>
                                    KorisnciDetailScreen(korisnici: e),
                              ),
                            )
                          }
                      },
                      cells: [
                        DataCell(Text(e.ime ?? "")),
                        DataCell(Text(e.prezime ?? "")),
                        DataCell(
                          Align(
                              alignment: Alignment.center,
                              child: Text(
                                e.korisnickoIme ?? "",
                              )),
                        ),
                        DataCell(Text(e.email ?? "")),
                        DataCell(
                          FutureBuilder<String>(
                            future: fetchPozicijaZaKorisnika(e.pozicijaId),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const CircularProgressIndicator();
                              } else if (snapshot.hasError) {
                                return Text('Error: ${snapshot.error}');
                              } else {
                                String uloga = snapshot.data ?? '';
                                return Text(uloga);
                              }
                            },
                          ),
                        ),
                        DataCell(
                          FutureBuilder<String>(
                            future: fetchUlogeZaKorisnika(e.korisnikId),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const CircularProgressIndicator();
                              } else if (snapshot.hasError) {
                                return Text('Error: ${snapshot.error}');
                              } else {
                                String uloga = snapshot.data ?? '';
                                return Text(uloga);
                              }
                            },
                          ),
                        ),
                        DataCell(
                          Align(
                              alignment: Alignment.center,
                              child: Text(e.aktivnost == true ? 'DA' : 'NE')),
                        ),
                        DataCell(
                          Row(
                            children: [
                              IconButton(
                                icon: const Icon(Icons.delete),
                                onPressed: () {
                                  _korisniciProvider.delete(e.korisnikId);
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const KorisniciListScreen(),
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
