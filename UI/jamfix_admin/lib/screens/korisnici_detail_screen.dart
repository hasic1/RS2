import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:jamfix_admin/models/drzava.dart';
import 'package:jamfix_admin/models/korisnici.dart';
import 'package:jamfix_admin/models/korisnici_uloge.dart';
import 'package:jamfix_admin/models/pozicija.dart';
import 'package:jamfix_admin/models/search_result.dart';
import 'package:jamfix_admin/models/statusZahtjeva.dart';
import 'package:jamfix_admin/models/zahtjev.dart';
import 'package:jamfix_admin/providers/drzava_provider.dart';
import 'package:jamfix_admin/providers/korisniciUloge_provider.dart';
import 'package:jamfix_admin/providers/korisnici_provider.dart';
import 'package:jamfix_admin/providers/pozicija_provider.dart';
import 'package:jamfix_admin/providers/statusZahtjevaProvider.dart';
import 'package:jamfix_admin/providers/zahtjev_provider.dart';
import 'package:jamfix_admin/screens/korisnici_list_screen.dart';
import 'package:jamfix_admin/widgets/master_screen.dart';
import 'package:provider/provider.dart';

class KorisnciDetailScreen extends StatefulWidget {
  Korisnici? korisnici;
  KorisnciDetailScreen({this.korisnici, Key? key}) : super(key: key);
  @override
  State<KorisnciDetailScreen> createState() => _KorisnciDetailScreen();
}

class _KorisnciDetailScreen extends State<KorisnciDetailScreen> {
  final TextEditingController imeController = TextEditingController();
  final TextEditingController prezimeController = TextEditingController();
  final TextEditingController telefonController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController noviPasswordController = TextEditingController();
  final TextEditingController passwordPotvrdaController =
      TextEditingController();
  SearchResult<Drzava>? drzavaResult;
  SearchResult<Pozicija>? pozicijaResult;
  SearchResult<Korisnici>? korisniciResult;
  SearchResult<KorisniciUloge>? korisniciUlogeResult;
  KorisniciProvider _korisniciProvider = KorisniciProvider();
  PozicijaProvider _pozicijaProvider = PozicijaProvider();
  DrzavaProvider _drzavaProvider = DrzavaProvider();
  KorisniciUlogeProvider _korisniciUlogeProvider = KorisniciUlogeProvider();

  Map<String, dynamic> _initialValue = {};
  bool isLoading = true;
  bool aktivan = false;
  String? selectedPozicijaId;
  String? selectedDrzavaId;
  String? selectedUloga;

  @override
  void initState() {
    super.initState();
    if (widget.korisnici != null) {
      setState(() {
        _initialValue = {
          'ime': widget.korisnici?.ime,
          'prezime': widget.korisnici?.prezime,
          'telefon': widget.korisnici?.telefon,
          'noviPassword': widget.korisnici?.noviPassword,
          'passwordPotvrda': widget.korisnici?.passwordPotvrda,
          'drzavaId': widget.korisnici?.drzavaId,
          'pozicijaId': widget.korisnici?.pozicijaId,
          'aktivnost': widget.korisnici?.aktivnost,
          'email': widget.korisnici?.email,
        };
        imeController.text = _initialValue['ime'] ?? '';
        prezimeController.text = _initialValue['prezime'] ?? '';
        telefonController.text = _initialValue['telefon'] ?? '';
        noviPasswordController.text = _initialValue['noviPassword'] ?? '';
        passwordPotvrdaController.text = _initialValue['passwordPotvrda'] ?? '';
        emailController.text = _initialValue['email'] ?? '';
        aktivan = _initialValue['aktivnost'];
      });
    }
    _korisniciProvider = context.read<KorisniciProvider>();
    _pozicijaProvider = context.read<PozicijaProvider>();
    _drzavaProvider = context.read<DrzavaProvider>();
    _korisniciUlogeProvider = context.read<KorisniciUlogeProvider>();
    _ucitajPodatke();
  }

  Future<void> _ucitajPodatke() async {
    var pozicije = await _pozicijaProvider.get();
    var podaci = await _korisniciProvider.get();
    var drzava = await _drzavaProvider.get();
    var uloge = await _korisniciUlogeProvider.get();

    setState(() {
      pozicijaResult = pozicije;
      korisniciResult = podaci;
      drzavaResult = drzava;
      korisniciUlogeResult = uloge;
    });

    for (var korisnik in podaci.result) {
      String uloga = await fetchUlogeZaKorisnika(korisnik.korisnikId);
    }
  }

  Map<String, String> ulogeMap = {
    '1': 'Administrator',
    '2': 'Korisnik',
    '3': 'Zaposlenik',
    '4': 'Operater',
  };
  @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: imeController,
                  decoration: const InputDecoration(labelText: 'Ime'),
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  controller: prezimeController,
                  decoration: const InputDecoration(labelText: 'Prezime'),
                ),
                TextFormField(
                  controller: emailController,
                  decoration: const InputDecoration(labelText: 'Email'),
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  controller: telefonController,
                  decoration: const InputDecoration(labelText: 'Broj Telefona'),
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  controller: noviPasswordController,
                  decoration: const InputDecoration(labelText: 'Nova sifra'),
                ),
                TextFormField(
                  controller: passwordPotvrdaController,
                  decoration: const InputDecoration(labelText: 'Potvrdi sifru'),
                ),
                Row(
                  children: [
                    Expanded(
                      child: FormBuilderDropdown<String>(
                        name: 'drzavaId',
                        decoration: InputDecoration(
                          labelText: 'drzava',
                          suffix: IconButton(
                            icon: const Icon(Icons.close),
                            onPressed: () {
                              setState(() {
                                selectedDrzavaId =
                                    _initialValue['drzavaId']?.toString() ??
                                        null;
                              });
                            },
                          ),
                          hintText: 'Odaberi drzavu',
                        ),
                        items: drzavaResult?.result
                                .map((item) => DropdownMenuItem(
                                      alignment: AlignmentDirectional.center,
                                      value: item.drzavaId.toString(),
                                      child: Text(item.naziv ?? ""),
                                    ))
                                .toList() ??
                            [],
                        onChanged: (value) {
                          setState(() {
                            selectedDrzavaId = value;
                          });
                        },
                        initialValue: _initialValue['drzavaId'] != null &&
                                drzavaResult?.result != null &&
                                drzavaResult!.result
                                    .map((item) => item.drzavaId.toString())
                                    .contains(
                                        _initialValue['drzavaId'].toString())
                            ? _initialValue['drzavaId'].toString()
                            : null,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: FormBuilderDropdown<String>(
                        name: 'pozicijaId',
                        decoration: InputDecoration(
                          labelText: 'pozicijaId',
                          suffix: IconButton(
                            icon: const Icon(Icons.close),
                            onPressed: () {
                              setState(() {
                                selectedDrzavaId =
                                    _initialValue['pozicijaId']?.toString() ??
                                        null;
                              });
                            },
                          ),
                          hintText: 'Odaberi poziciju korisnika',
                        ),
                        items: pozicijaResult?.result
                                .map((item) => DropdownMenuItem(
                                      alignment: AlignmentDirectional.center,
                                      value: item.pozicijaId.toString(),
                                      child: Text(item.naziv ?? ""),
                                    ))
                                .toList() ??
                            [],
                        onChanged: (value) {
                          setState(() {
                            selectedPozicijaId = value;
                          });
                        },
                        initialValue: _initialValue['pozicijaId'] != null &&
                                pozicijaResult?.result != null &&
                                pozicijaResult!.result
                                    .map((item) => item.pozicijaId.toString())
                                    .contains(
                                        _initialValue['pozicijaId'].toString())
                            ? _initialValue['pozicijaId'].toString()
                            : null,
                      ),
                    ),
                  ],
                ),
                //----------------------------------------------------------------------
                Row(
                  children: [
                    Expanded(
                      child: FormBuilderDropdown<String>(
                        name: 'ulogaId',
                        decoration: InputDecoration(
                          labelText: 'Uloga',
                          suffix: IconButton(
                            icon: const Icon(Icons.close),
                            onPressed: () {
                              setState(() {
                                selectedUloga =
                                    _initialValue['ulogaId']?.toString() ??
                                        null;
                              });
                            },
                          ),
                          hintText: 'Odaberi ulogu korisnika',
                        ),
                        items: ulogeMap.entries
                            .map((entry) => DropdownMenuItem<String>(
                                  value: entry.key,
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      entry.value,
                                    ),
                                  ),
                                ))
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedUloga = value;
                          });
                        },
                        initialValue: ulogeMap.keys.first,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 25.0),
                Row(
                  children: [
                    Checkbox(
                      value: aktivan,
                      onChanged: (value) {
                        setState(() {
                          aktivan = value!;
                        });
                      },
                    ),
                    const Text('Aktivan korisnik'),
                  ],
                ),
                const SizedBox(height: 20.0),
                Align(
                  alignment: Alignment.bottomRight,
                  child: ElevatedButton(
                    onPressed: () async {
                      KorisniciUloge uloge = KorisniciUloge(
                        ulogaId: int.parse(selectedUloga ?? ""),
                        datumIzmjene: DateTime.now(),
                      );
                      Korisnici request = Korisnici(
                        aktivnost: aktivan,
                        pozicijaId: int.tryParse(selectedPozicijaId ??
                            _initialValue['pozicijaId'].toString()),
                        drzavaId: int.parse(selectedDrzavaId ??
                            _initialValue['drzavaId'].toString()),
                        ime: imeController.text,
                        prezime: prezimeController.text,
                        telefon: telefonController.text,
                        noviPassword: noviPasswordController.text,
                        email: emailController.text,
                        passwordPotvrda: passwordPotvrdaController.text,
                      );
                      Navigator.of(context).pop();
                      try {
                        _korisniciUlogeProvider.update(
                            widget.korisnici!.korisnikId!, uloge);
                        _korisniciProvider.update(
                            widget.korisnici!.korisnikId!, request);
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => KorisniciListScreen(),
                          ),
                        );
                      } on Exception catch (e) {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            title: const Text("Error"),
                            content: Text(e.toString()),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text("OK"),
                              )
                            ],
                          ),
                        );
                      }
                    },
                    child: const Text('Potvrdi Unos'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
