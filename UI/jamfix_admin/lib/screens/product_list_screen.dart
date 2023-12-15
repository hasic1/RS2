// ignore_for_file: unnecessary_const

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

  TextEditingController _ftsController = new TextEditingController();
  TextEditingController _cijenaController = new TextEditingController();

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    _productProvider = context.read<ProductProvider>();
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(
      child: Container(
          child: Column(children: [_buildSearch(), _buildDataListView()])),
    );
  }

  Widget _buildSearch() {
    return Padding(
        padding: EdgeInsets.all(8.0),
        child: Row(children: [
          Expanded(
            child: TextField(
              decoration: InputDecoration(labelText: "Naziv ili cijena"),
              controller: _ftsController,
            ),
          ),
          SizedBox(
            width: 8,
          ),
          Expanded(
            child: TextField(
              decoration: InputDecoration(labelText: "Cijena"),
              controller: _cijenaController,
            ),
          ),
          ElevatedButton(
              onPressed: () async {
                print("login proceed");

                //Navigator.of(context).pop();
                // Navigator.of(context).push(
                //   MaterialPageRoute(
                //     builder: (context) => const ProductDetailScreen(),
                //   ),
                // );
                var data = await _productProvider.get(filter: {
                  'fts': _ftsController.text,
                  'cijena': _cijenaController.text
                });

                setState(() {
                  result = data;
                });
              },
              child: Text("Pretraga")),
          SizedBox(
            height: 8,
          ),
          ElevatedButton(
              onPressed: () async {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ProductDetailScreen(product: null),
                  ),
                );
              },
              child: Text("Dodaj")),
        ]));
  }

  Expanded _buildDataListView() {
    return Expanded(
        child: SingleChildScrollView(
      child: DataTable(
          // ignore: prefer_const_literals_to_create_immutables
          columns: [
            const DataColumn(
                label: const Expanded(
              child: Text('ID',
                  style: const TextStyle(fontStyle: FontStyle.italic)),
            )),
            const DataColumn(
                label: const Expanded(
              child: Text('NazivProizvoda',
                  style: const TextStyle(fontStyle: FontStyle.italic)),
            )),
            const DataColumn(
                label: const Expanded(
              child: Text('cijena',
                  style: const TextStyle(fontStyle: FontStyle.italic)),
            )),
            const DataColumn(
              label: const Expanded(
                child: Text('opis',
                    style: const TextStyle(fontStyle: FontStyle.italic)),
              ),
            ),
            const DataColumn(
              label: const Expanded(
                child: Text('Snizen',
                    style: const TextStyle(fontStyle: FontStyle.italic)),
              ),
            ),
            const DataColumn(
              label: const Expanded(
                child: Text('Slika',
                    style: const TextStyle(fontStyle: FontStyle.italic)),
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
                            DataCell(Text(e.nazivProizvoda ?? "")),
                            DataCell(Text(formatNumber(e.cijena))),
                            DataCell(Text(e.opis ?? "")),
                            DataCell(Text(e.snizen.toString())),
                            DataCell(e.slika != ""
                                ? Container(
                                    width: 100,
                                    height: 100,
                                    child: imageFromBase64String(e.slika!),
                                  )
                                : Text("")),
                          ]))
                  .toList() ??
              []),
    ));
  }
}
