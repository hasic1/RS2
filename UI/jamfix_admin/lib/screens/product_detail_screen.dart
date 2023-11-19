import 'package:flutter/material.dart';
import 'package:jamfix_admin/widgets/master_screen.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({Key?key}) :super(key: key);

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(
      child: Text("Details"),
      title: "Product details",
    );
  }
}