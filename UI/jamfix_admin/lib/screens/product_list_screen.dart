import 'package:flutter/material.dart';
import 'package:jamfix_admin/models/product.dart';
import 'package:jamfix_admin/models/search_result.dart';
import 'package:jamfix_admin/providers/product_provider.dart';
import 'package:jamfix_admin/widgets/master_screen.dart';
import 'package:provider/provider.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({Key? key}) : super(key: key);
  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  late ProductProvider _productProvider;
  SearchResult<Product>? result;
  TextEditingController _ftsController = TextEditingController();
  TextEditingController _cijenaController = TextEditingController();
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
      child:Row(
      children: [
        Expanded
        (
          child:TextField(
            decoration:InputDecoration
            (labelText: "Naziv ili cijena"),
            controller: _ftsController,
            ),
            ),
    
      SizedBox(
        width: 8,
      ),
      Expanded
        (
          child:TextField(
            decoration:InputDecoration
            (labelText: "Cijena"),
            controller: _cijenaController,
            ),
            ),
    
      ElevatedButton(
          onPressed: () async {
            //Navigator.of(context).pop();
            // Navigator.of(context).push(
            //   MaterialPageRoute(
            //     builder: (context) => const ProductDetailScreen(),
            //   ),
            // );
            var data = await _productProvider.get(filter:{
              'fts':_ftsController.text,
              'cijena':_cijenaController.text
            });
            print(Text("asd${data}"));

            setState(() {
              result = data;
            });
          },
          child: Text("Pretraga")),
    ])
    );
  }

  Expanded _buildDataListView() {
    return Expanded(
        child: SingleChildScrollView(
      child: DataTable(
          columns: [
            const DataColumn(
                label: const Expanded(
              child: Text('proizvodId',
                  style: const TextStyle(fontStyle: FontStyle.italic)),
            )),
            const DataColumn(
                label: const Expanded(
              child: Text('nazivProizvoda',
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
            )
          ],
          rows: result?.result
                  .map((Product e) => DataRow(cells: [
                        DataCell(Text(e.proizvodId?.toString() ?? "")),
                        DataCell(Text(e.nazivProizvoda ?? "")),
                        DataCell(Text(e.cijena?.toString() ?? "")),
                        DataCell(Text(e.opis ?? "")),
                      ]))
                  .toList() ??
              []),
    ));
  }
}
