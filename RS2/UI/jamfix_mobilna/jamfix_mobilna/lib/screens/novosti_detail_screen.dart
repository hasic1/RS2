import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:jamfix_mobilna/models/novosti.dart';
import 'package:jamfix_mobilna/models/search_result.dart';
import 'package:jamfix_mobilna/providers/novosti_provider.dart';
import 'package:jamfix_mobilna/widgets/master_screen.dart';
import 'package:provider/provider.dart';

class NovostiDetailScreen extends StatefulWidget {
  Novosti? novosti;
  NovostiDetailScreen({this.novosti, Key? key}) : super(key: key);
  @override
  State<NovostiDetailScreen> createState() => _NovostiDetailScreen();
}

class _NovostiDetailScreen extends State<NovostiDetailScreen> {
  final TextEditingController naslovController = TextEditingController();
  final TextEditingController sadrzajController = TextEditingController();
  SearchResult<Novosti>? novostiResult;
  NovostiProvider _novostiProvider = NovostiProvider();

  Map<String, dynamic> _initialValue = {};
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    if (widget.novosti != null) {
      setState(() {
        _initialValue = {
          'naslov': widget.novosti?.naslov,
          'sadrzaj': widget.novosti?.sadrzaj,
        };
        naslovController.text = _initialValue['ime'] ?? '';
        sadrzajController.text = _initialValue['prezime'] ?? '';
      });
    }
    _novostiProvider = context.read<NovostiProvider>();
    _ucitajPodatke();
  }

  Future<void> _ucitajPodatke() async {
    var novosti = await _novostiProvider.get();

    setState(() {
      novostiResult = novosti;
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Naslov novosti:\n ${widget.novosti != null ? widget.novosti!.naslov.toString() : ''}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16.0),
                const Text(
                  'Sadržaj novosti:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  widget.novosti != null
                      ? widget.novosti!.sadrzaj.toString()
                      : '',
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
