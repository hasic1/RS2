import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jamfix_mobilna/models/konkurs.dart';
import 'package:jamfix_mobilna/models/prijava.dart';
import 'package:jamfix_mobilna/models/search_result.dart';
import 'package:jamfix_mobilna/providers/konkurs_provider.dart';
import 'package:jamfix_mobilna/providers/prijava_provider.dart';
import 'package:jamfix_mobilna/utils/utils.dart';
import 'package:jamfix_mobilna/widgets/master_screen.dart';
import 'package:provider/provider.dart';

class PrijavaDetailScreen extends StatefulWidget {
  Prijava? prijava;
  PrijavaDetailScreen({this.prijava, Key? key}) : super(key: key);
  @override
  State<PrijavaDetailScreen> createState() => _PrijavaDetailScreen();
}

class _PrijavaDetailScreen extends State<PrijavaDetailScreen> {
  final TextEditingController imeController = TextEditingController();
  final TextEditingController prezimeController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController brojTelefonaController = TextEditingController();
  TextEditingController startDateController = TextEditingController();

  bool userRole = true;

  SearchResult<Prijava>? prijavaResult;
  DateTime? selectedDate;

  KonkursProvider konkursProvider = KonkursProvider();
  PrijavaProvider prijavaProvider = PrijavaProvider();

  final _formKey = GlobalKey<FormState>();
  Map<String, dynamic> _initialValue = {};

  @override
  void initState() {
    super.initState();
    if (widget.prijava != null) {
      setState(() {
        _initialValue = {
          'ime': widget.prijava?.ime,
          'prezime': widget.prijava?.prezime,
          'email': widget.prijava?.email,
          'brojTelefona': widget.prijava?.brojTelefona,
          'datumPrijave': widget.prijava?.datumPrijave,
        };
        imeController.text = _initialValue['ime'] ?? '';
        prezimeController.text = _initialValue['prezime'] ?? '';
        emailController.text = _initialValue['email'] ?? '';
        brojTelefonaController.text = _initialValue['brojTelefona'] ?? '';
        startDateController.text =
            DateFormat('dd.MM.yyy').format(_initialValue['datumPrijave'] ?? '');
      });
    }
    prijavaProvider = context.read<PrijavaProvider>();
    _ucitajPodatke();
  }

  Future<void> _ucitajPodatke() async {
    var podaci = await prijavaProvider.get();

    setState(() {
      prijavaResult = podaci;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(
      child: Scaffold(
        appBar: AppBar(),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16.0),
                  TextFormField(
                    controller: imeController,
                    enabled: false,
                    decoration: const InputDecoration(labelText: 'Ime'),
                    validator: (name) => name!.length < 3
                        ? 'Tražena pozicija mora imati bar 3 slova'
                        : null,
                  ),
                  TextFormField(
                    controller: prezimeController,
                    enabled: false,
                    decoration: const InputDecoration(labelText: 'Prezime'),
                    validator: (name) => name!.length < 3
                        ? 'Tražena pozicija mora imati bar 3 slova'
                        : null,
                  ),
                  TextFormField(
                    controller: emailController,
                    enabled: false,
                    decoration: const InputDecoration(labelText: 'Email'),
                    validator: (name) => name!.length < 3
                        ? 'Tražena pozicija mora imati bar 3 slova'
                        : null,
                  ),
                  TextFormField(
                    controller: brojTelefonaController,
                    enabled: false,
                    decoration:
                        const InputDecoration(labelText: 'Broj telefona'),
                    validator: (value) =>
                        value!.isEmpty ? 'Polje ne može biti prazno' : null,
                  ),
                  TextFormField(
                    controller: startDateController,
                    enabled: false,
                    decoration:
                        const InputDecoration(labelText: 'Datum prijave'),
                    validator: (value) =>
                        value!.isEmpty ? 'Polje ne može biti prazno' : null,
                  ),
                  const SizedBox(height: 16.0),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
