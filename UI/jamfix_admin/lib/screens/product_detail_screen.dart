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
import 'package:jamfix_admin/screens/plati_uslugu_screen.dart';
import 'package:jamfix_admin/screens/product_list_screen.dart';
import 'package:jamfix_admin/screens/usluge_screen.dart';
import 'package:jamfix_admin/utils/util.dart';
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
  bool userRole = true;
  SearchResult<VrsteProizvoda>? vrsteProizvodaResult;
  SearchResult<Product>? preporuceniProizvodi;

  bool isLoading = true;
  bool snizen = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initialValue = {
      'cijena': widget.product?.cijena.toString(),
      'nazivProizvoda': widget.product?.nazivProizvoda,
      'opis': widget.product?.opis,
      'snizen': widget.product?.snizen.toString(),
      'vrstaId': widget.product?.vrstaId?.toString(),
      'brzinaInterneta': widget.product?.brzinaInterneta,
      'brojMinuta': widget.product?.brojMinuta,
      'brojKanala': widget.product?.brojKanala,
    };
    _vrsteProizvodaProvider = context.read<VrsteProizvodaProvider>();
    _productProvider = context.read<ProductProvider>();

    initForm();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  Future initForm() async {
    var vrste = await _vrsteProizvodaProvider.get();
    var recommend = await _productProvider
        .fetchRecommendedProducts(widget.product!.proizvodId!);

    print("Recommendation result: $recommend"); // Dodajte ovu liniju

    if (recommend != null) {
      setState(() {
        vrsteProizvodaResult = vrste;
        preporuceniProizvodi = recommend;
        isLoading = false;
      });
    } else {
      print("Error fetching recommended products."); // Dodajte ovu liniju
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MasterScreenWidget(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: newMethod(context),
        ),
        title: "Prosjecna ocjena:  ${this.widget.product?.prosjecnaOcjena}",
      ),
    );
  }

  Column newMethod(BuildContext context) {
    return Column(
      children: [
        isLoading ? Container() : _buildForm(),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Visibility(
              visible: Authorization.isAdmin,
              child: Padding(
                padding: EdgeInsets.all(10),
                child: ElevatedButton(
                  onPressed: () async {
                    _formKey.currentState?.saveAndValidate();
                    var request = Map.from(_formKey.currentState!.value);
                    request['slika'] = _base65Image;
                    Navigator.of(context).pop();
                    try {
                      if (widget.product == null) {
                        await _productProvider.insert(request);
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => ProductListScreen(),
                          ),
                        );
                      } else {
                        await _productProvider.update(
                            widget.product!.proizvodId!, request);
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => ProductListScreen(),
                          ),
                        );
                      }
                    } on Exception catch (e) {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                                title: const Text("Error"),
                                content: Text(e.toString()),
                                actions: [
                                  TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: const Text("OK"))
                                ],
                              ));
                    }
                  },
                  child: const Text("Sacuvaj"),
                ),
              ),
            ),
            Visibility(
              visible: Authorization.isKorisnik,
              child: Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) =>
                              PlatiUsluguScreen(product: widget.product),
                        ),
                      );
                    },
                    child: const Text("Dodaj narudzbu"),
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 20),
        Text(
          'Preporučeni proizvodi',
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        Wrap(
          spacing: 15.0,
          runSpacing: 15.0,
          children: preporuceniProizvodi?.result.map((recommendedProduct) {
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
                decoration: const InputDecoration(labelText: "Cijena"),
                enabled: userRole == Authorization.isAdmin,
                name: "cijena",
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: FormBuilderTextField(
                decoration: const InputDecoration(labelText: "Naziv"),
                enabled: userRole == Authorization.isAdmin,
                name: "nazivProizvoda",
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: FormBuilderTextField(
                decoration: const InputDecoration(labelText: "opis"),
                enabled: userRole == Authorization.isAdmin,
                name: "opis",
              ),
            ),
            const SizedBox(
              width: 10,
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: FormBuilderTextField(
                decoration:
                    const InputDecoration(labelText: "Brzina interneta"),
                enabled: userRole == Authorization.isAdmin,
                name: "brzinaInterneta",
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: FormBuilderTextField(
                decoration: const InputDecoration(labelText: "Broj minuta"),
                enabled: userRole == Authorization.isAdmin,
                name: "brojMinuta",
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: FormBuilderTextField(
                decoration: const InputDecoration(labelText: "Broj kanala"),
                enabled: userRole == Authorization.isAdmin,
                name: "brojKanala",
              ),
            ),
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
                enabled: userRole == Authorization.isAdmin,
                items: vrsteProizvodaResult?.result
                        .map((item) => DropdownMenuItem(
                              alignment: AlignmentDirectional.center,
                              value: item.vrstaId.toString(),
                              child: Text(item.naziv ?? ""),
                            ))
                        .toList() ??
                    [],
                initialValue: _initialValue['vrstaId'],
              ),
            ),
          ],
        ),
        Visibility(
          visible: Authorization.isAdmin,
          child: Row(
            children: [
              Expanded(
                  child: FormBuilderField(
                name: 'imageId',
                builder: ((field) {
                  return InputDecorator(
                    decoration: InputDecoration(
                        label: const Text('Odaberite sliku'),
                        errorText: field.errorText),
                    child: ListTile(
                      enabled: userRole == Authorization.isAdmin,
                      leading: const Icon(Icons.photo),
                      title: const Text("Select image"),
                      trailing: const Icon(Icons.file_upload),
                      onTap: getImage,
                    ),
                  );
                }),
              )),
            ],
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Visibility(
          visible: Authorization.isAdmin,
          child: Row(
            children: [
              Checkbox(
                value: snizen,
                onChanged: (value) {
                  setState(() {
                    snizen = value!;
                  });
                },
              ),
              const Text('Snizen'),
            ],
          ),
        ),
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
