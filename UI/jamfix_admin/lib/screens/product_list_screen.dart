import 'package:flutter/material.dart';
import 'package:jamfix_admin/models/product.dart';
import 'package:jamfix_admin/models/search_result.dart';
import 'package:jamfix_admin/providers/product_provider.dart';
import 'package:jamfix_admin/screens/product_detail_screen.dart';
import 'package:jamfix_admin/widgets/master_screen.dart';
import 'package:provider/provider.dart';

import '../utils/util.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({Key? key}) : super(key: key);
  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  late ProductProvider _productProvider;
  SearchResult<Product>? result;

  final TextEditingController _ftsController = TextEditingController();
  final TextEditingController _cijenaController = TextEditingController();
  @override
  void initState() {
    super.initState();
    _productProvider = context.read<ProductProvider>();
    _ucitajPodatke();
  }

  Future<void> _ucitajPodatke() async {
    var podaci = await _productProvider.get();

    setState(() {
      result = podaci;
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(
      child: Scaffold(
        appBar: AppBar(),
        body: Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(children: [_buildSearch(), _buildDataListView()])),
      ),
    );
  }

  Widget _buildSearch() {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(children: [
          Expanded(
            child: TextField(
              decoration: const InputDecoration(labelText: "Naziv ili cijena"),
              controller: _ftsController,
            ),
          ),
          const SizedBox(
            width: 8,
          ),
          Expanded(
            child: TextField(
              decoration: const InputDecoration(labelText: "Cijena"),
              controller: _cijenaController,
            ),
          ),
          ElevatedButton(
              onPressed: () async {
                var data = await _productProvider.get(filter: {
                  'fts': _ftsController.text,
                  'cijena': _cijenaController.text
                });

                setState(() {
                  result = data;
                });
              },
              child: const Text("Pretraga")),
          const SizedBox(
            height: 8,
          ),
          Visibility(
            visible: Authorization.isAdmin,
            child: ElevatedButton(
                onPressed: () async {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => ProductDetailScreen(product: null),
                    ),
                  );
                },
                child: const Text("Dodaj")),
          ),
        ]));
  }

  Expanded _buildDataListView() {
    return Expanded(
        child: SingleChildScrollView(
      child: DataTable(
          columns: const [
            DataColumn(
                label: Expanded(
              child: Text('ID', style: TextStyle(fontStyle: FontStyle.italic)),
            )),
            DataColumn(
                label: Expanded(
              child: Text('Naziv proizvoda',
                  style: TextStyle(fontStyle: FontStyle.italic)),
            )),
            DataColumn(
              label: Expanded(
                child: Text('Opis',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontStyle: FontStyle.italic)),
              ),
            ),
            DataColumn(
                label: Expanded(
              child:
                  Text('Cijena', style: TextStyle(fontStyle: FontStyle.italic)),
            )),
            DataColumn(
              label: Expanded(
                child: Text('Snizen',
                    style: TextStyle(fontStyle: FontStyle.italic)),
              ),
            ),
            DataColumn(
              label: Expanded(
                child: Text('Slika',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontStyle: FontStyle.italic)),
              ),
            ),
          ],
          rows: result?.result
                  .map((Product e) => DataRow(
                          onSelectChanged: (selected) => {
                                if (selected == true)
                                  {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            ProductDetailScreen(product: e),
                                      ),
                                    )
                                  }
                              },
                          cells: [
                            DataCell(Text(e.proizvodId?.toString() ?? "")),
                            DataCell(
                              Align(
                                  alignment: Alignment.center,
                                  child: Text(e.nazivProizvoda ?? "")),
                            ),
                            DataCell(Text(e.opis ?? "")),
                            DataCell(
                              Align(
                                  alignment: Alignment.center,
                                  child: Text(formatNumber(e.cijena))),
                            ),
                            DataCell(Align(
                                alignment: Alignment.center,
                                child: Text(
                                  e.snizen == true ? "DA" : "NE",
                                ))),
                            DataCell(e.slika != ""
                                ? SizedBox(
                                    width: 100,
                                    height: 100,
                                    child: imageFromBase64String(e.slika!),
                                  )
                                : const Text("")),
                          ]))
                  .toList() ??
              []),
    ));
  }
}
