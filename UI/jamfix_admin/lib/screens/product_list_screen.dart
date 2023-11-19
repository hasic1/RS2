import 'package:flutter/material.dart';
import 'package:jamfix_admin/screens/product_detail_screen.dart';
import 'package:jamfix_admin/widgets/master_screen.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({Key?key}) :super(key: key);

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(
      child: Container(
        child: Column(children: [
          Text("TEST"),
          SizedBox(
            height: 8,
          ),
          ElevatedButton(
              onPressed: () {
                //Navigator.of(context).pop();
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const ProductDetailScreen(),
                  ),
                );
              },
              child: Text("Login"))
        ]),
      ),
    );
  }
}