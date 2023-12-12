
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:jamfix_admin/models/korisnici.dart';
import 'package:jamfix_admin/models/search_result.dart';
import 'package:jamfix_admin/providers/base_provider.dart';
import 'package:jamfix_admin/providers/korisnici_provider.dart';
import 'package:jamfix_admin/widgets/master_screen.dart';
import 'package:provider/provider.dart';

class KorisniciListScreen extends StatefulWidget {
  const KorisniciListScreen({Key? key}) : super(key: key);
  @override
  State<KorisniciListScreen> createState() => _KorisniciListScreen();
}

class _KorisniciListScreen extends State<KorisniciListScreen> {
  late KorisniciProvider _korisniciProvider;
  final _formKey = GlobalKey<FormBuilderState>();
  SearchResult<Korisnici>? korisniciResult;

  bool isLoading = true;

  @override
  Widget build(BuildContext context) {
    _korisniciProvider = context.read<KorisniciProvider>();
    return MasterScreenWidget(
      title_widget: Text("Product list"),
      child: Container(
          child: Column(children: [_buildSearch(), _buildDataListView()])),
    );
  }

  Widget _buildSearch() {
    return ElevatedButton(
        onPressed: () async {
          print("login proceed");
          var data = await _korisniciProvider.get();
          setState(() {
            korisniciResult = data;
          });
        },
        child: Text("Pretraga"));
  }

  Expanded _buildDataListView() {
    return Expanded(
        child: SingleChildScrollView(
      child: DataTable(
          // ignore: prefer_const_literals_to_create_immutables
          columns: [
            const DataColumn(
                label: const Expanded(
              child: Text('korisnikId',
                  style: const TextStyle(fontStyle: FontStyle.italic)),
            )),
            const DataColumn(
                label: const Expanded(
              child: Text('ime',
                  style: const TextStyle(fontStyle: FontStyle.italic)),
            )),
            const DataColumn(
                label: const Expanded(
              child: Text('prezime',
                  style: const TextStyle(fontStyle: FontStyle.italic)),
            )),
            const DataColumn(
              label: const Expanded(
                child: Text('email',
                    style: const TextStyle(fontStyle: FontStyle.italic)),
              ),
            ),
            const DataColumn(
              label: const Expanded(
                child: Text('telefon',
                    style: const TextStyle(fontStyle: FontStyle.italic)),
              ),
            ),
          ],
          rows: korisniciResult?.result
                  .map((Korisnici e) => DataRow(
                          onSelectChanged: (selected) => {
                              //uloga = _ulogaProvider.getAdmina(e.korisnikId),
                              },
                          cells: [
                            DataCell(Text(e.korisnikId?.toString() ?? "")),
                            DataCell(Text(e.ime ?? "")),
                            DataCell(Text(e.prezime ?? "")),
                            DataCell(Text(e.email ?? "")),
                            DataCell(Text(e.telefon ?? "")),
                          ]))
                  .toList() ??
              []),
    ));
  }
}
