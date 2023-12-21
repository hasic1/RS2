// ignore_for_file: sort_child_properties_last

import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:jamfix_admin/models/product.dart';
import 'package:jamfix_admin/models/search_result.dart';
import 'package:jamfix_admin/models/vrste_proizvoda.dart';
import 'package:jamfix_admin/providers/product_provider.dart';
import 'package:jamfix_admin/providers/vrste_proizvoda_provider.dart';
import 'package:jamfix_admin/widgets/master_screen.dart';
import 'package:provider/provider.dart';

class ProductDetailScreen extends StatefulWidget {
  Product? product;
  VrsteProizvoda? vrsteProizvoda;
  ProductDetailScreen({this.product, this.vrsteProizvoda, Key? key})
      : super(key: key);

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  Map<String, dynamic> _initialValue = {};

  VrsteProizvodaProvider _vrsteProizvodaProvider = VrsteProizvodaProvider();
  ProductProvider _productProvider = ProductProvider();

  SearchResult<VrsteProizvoda>? vrsteProizvodaResult;
  bool isLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initialValue = {
      'cijena': widget.product?.cijena.toString(),
      'nazivProizvoda': widget.product?.nazivProizvoda,
      'opis': widget.product?.opis,
      //'snizen': widget.product?.snizen.toString(),
      'vrstaId': widget.product?.vrstaId?.toString(),
    };
    // _korisniciProvider = context.read<KorisniciProvider>();
    // _vrsteProizvodaProvider = context.read<VrsteProizvodaProvider>();
    _vrsteProizvodaProvider = context.read<VrsteProizvodaProvider>();
    _productProvider = context.read<ProductProvider>();

    initForm();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();

    // if (widget.product != null) {
    //   setState(() {
    //     _formKey.currentState.patchValue({
    //       'cijena':widget.product?.cijena
    //     });
    //   });
  }

  Future initForm() async {
    vrsteProizvodaResult = await _vrsteProizvodaProvider.get();
    print(vrsteProizvodaResult);

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(
      child: Column(children: [
        isLoading ? Container() : _buildForm(),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: EdgeInsets.all(10),
              child: ElevatedButton(
                  onPressed: () async {
                    _formKey.currentState?.saveAndValidate();
                    print(_formKey.currentState?.value);

                    var request = new Map.from(_formKey.currentState!.value);
                    request['slika'] = _base65Image;
                    try {
                      if (widget.product == null) {
                        await _productProvider.insert(request);
                      } else {
                        await _productProvider.update(
                            widget.product!.proizvodId!, request);
                      }
                    } on Exception catch (e) {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                                title: Text("Error"),
                                content: Text(e.toString()),
                                actions: [
                                  TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: Text("OK"))
                                ],
                              ));
                    }
                  },
                  child: Text("Sacuvaj")),
            )
          ],
        )
      ]),
      title: this.widget.product?.nazivProizvoda ?? 'Product details',
    );
  }

  FormBuilder _buildForm() {
    return FormBuilder(
      key: _formKey,
      initialValue: _initialValue,
      child: Column(children: [
        Row(
          children: [
            Expanded(
              child: FormBuilderTextField(
                decoration: InputDecoration(labelText: "Cijena"),
                name: "cijena",
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: FormBuilderTextField(
                decoration: InputDecoration(labelText: "Naziv"),
                name: "nazivProizvoda",
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: FormBuilderTextField(
                decoration: InputDecoration(labelText: "opis"),
                name: "opis",
              ),
            ),
            SizedBox(
              width: 10,
            ),
            // Expanded(
            //   child: FormBuilderTextField(
            //     decoration: InputDecoration(labelText: "snizen"),
            //     name: "snizen",
            //   ),
            // ),
          ],
        ),
        Row(
          children: [
            Expanded(
                child: FormBuilderDropdown<String>(
              name: 'vrstaId',
              decoration: InputDecoration(
                labelText: 'Vrsta proizvoda',
                suffix: IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () {
                    _formKey.currentState!.fields['vrstaId']?.reset();
                  },
                ),
                hintText: 'Odaberi vrstu',
              ),
              items: vrsteProizvodaResult?.result
                      .map((item) => DropdownMenuItem(
                            alignment: AlignmentDirectional.center,
                            value: item.vrstaId.toString(),
                            child: Text(item.naziv ?? ""),
                          ))
                      .toList() ??
                  [],
            ))
          ],
        ),
        Row(
          children: [
            Expanded(
                child: FormBuilderField(
              name: 'imageId',
              builder: ((field) {
                return InputDecorator(
                  decoration: InputDecoration(
                      label: Text('Odaberite sliku'),
                      errorText: field.errorText),
                  child: ListTile(
                    leading: Icon(Icons.photo),
                    title: Text("Select image"),
                    trailing: Icon(Icons.file_upload),
                    onTap: getImage,
                  ),
                );
              }),
            )),
          ],
        )
      ]),
    );
  }

  File? _image;
  String? _base65Image;

  Future getImage() async {
    var result = await FilePicker.platform.pickFiles(type: FileType.image);

    if (result != null && result.files.single.path != null) {
      _image = File(result.files.single.path!);
      _base65Image = base64Encode(_image!.readAsBytesSync());
    }
  }
}
