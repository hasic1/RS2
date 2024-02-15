import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:jamfix_admin/models/product.dart';
import 'package:jamfix_admin/models/search_result.dart';
import 'package:jamfix_admin/providers/product_provider.dart';
import 'package:jamfix_admin/screens/product_detail_screen.dart';
import 'package:jamfix_admin/widgets/master_screen.dart';
import 'package:provider/provider.dart';

class KorisnikProductListScreen extends StatefulWidget {
  const KorisnikProductListScreen({Key? key}) : super(key: key);

  @override
  State<KorisnikProductListScreen> createState() =>
      _KorisnikProductListScreen();
}

class _KorisnikProductListScreen extends State<KorisnikProductListScreen> {
  late ProductProvider _productProvider;
  SearchResult<Product>? result;

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
  Widget build(BuildContext context) {
    return MasterScreenWidget(
      child: Scaffold(
        appBar: AppBar(
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Naši proizvodi',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 15.0),
                Wrap(
                  spacing: 15.0,
                  runSpacing: 15.0,
                  children: result?.result.map((recommendedProduct) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => ProductDetailScreen(
                              product: recommendedProduct,
                            ),
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(17.0), 
                        child: Container(
                          width: 250,
                          height: 250,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15.0),
                            child: Image.memory(
                              base64Decode(recommendedProduct.slika ?? ''),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    );
                  }).toList() ??
                      [],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
