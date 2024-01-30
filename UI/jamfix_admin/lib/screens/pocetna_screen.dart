import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:jamfix_admin/models/product.dart';
import 'package:jamfix_admin/models/search_result.dart';
import 'package:jamfix_admin/providers/product_provider.dart';
import 'package:jamfix_admin/screens/korisnici_detail_screen.dart';
import 'package:jamfix_admin/screens/korisnici_list_screen.dart';
import 'package:jamfix_admin/screens/product_detail_screen.dart';
import 'package:jamfix_admin/utils/util.dart';
import 'package:jamfix_admin/widgets/master_screen.dart';
import 'package:provider/provider.dart';

class PocetnaScreen extends StatefulWidget {
  const PocetnaScreen({Key? key}) : super(key: key);

  @override
  State<PocetnaScreen> createState() => _PocetnaScreen();
}

class _PocetnaScreen extends State<PocetnaScreen> {
  late ProductProvider _productProvider;
  SearchResult<Product>? result;
  SearchResult<Product>? recommendedProducts;

  @override
  void initState() {
    super.initState();
    _productProvider = context.read<ProductProvider>();
    _ucitajPodatke();
  }

  Future<void> _ucitajPodatke() async {
    var podaci = await _productProvider.get();
    var recommended = await _productProvider.fetchBestProducts();

    setState(() {
      result = podaci;
      recommendedProducts = recommended;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CarouselSlider(
                items: result?.result.map(
                      (product) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) =>
                                    ProductDetailScreen(product: product),
                              ),
                            );
                          },
                          child: Builder(
                            builder: (BuildContext context) {
                              return Container(
                                width: MediaQuery.of(context).size.width,
                                margin: EdgeInsets.symmetric(horizontal: 5.0),
                                child: Align(
                                  alignment: Alignment.topCenter,
                                  child: Image.memory(
                                    base64Decode(product.slika!),
                                    height: 300,
                                    width: 300,
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      },
                    ).toList() ??
                    [],
                options: CarouselOptions(
                  height: 200.0,
                  autoPlay: true,
                  autoPlayInterval: Duration(seconds: 3),
                  autoPlayAnimationDuration: Duration(milliseconds: 800),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enlargeCenterPage: true,
                  scrollDirection: Axis.horizontal,
                ),
              ),
              SizedBox(height: 20.0),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Najbolje ocjenjeni proizvodi',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10.0),
                    Container(
                      height: 150.0,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: recommendedProducts?.result.length ?? 0,
                        itemBuilder: (context, index) {
                          var recommendedProduct =
                              recommendedProducts?.result[index];

                          return Padding(
                            padding: EdgeInsets.all(16.0),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                    builder: (context) => ProductDetailScreen(
                                        product: recommendedProduct),
                                  ),
                                );
                              },
                              child: Align(
                                alignment: Alignment.topCenter,
                                child: Image.memory(
                                  base64Decode(recommendedProduct?.slika ?? ''),
                                  height: 150,
                                  width: 150,
                                ),
                              ),
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
        ),
      ),
    );
  }
}
