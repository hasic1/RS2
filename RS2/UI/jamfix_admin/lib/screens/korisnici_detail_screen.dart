import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:jamfix_admin/models/drzava.dart';
import 'package:jamfix_admin/models/korisnici.dart';
import 'package:jamfix_admin/models/korisnici_uloge.dart';
import 'package:jamfix_admin/models/pozicija.dart';
import 'package:jamfix_admin/models/search_result.dart';
import 'package:jamfix_admin/models/uloge.dart';
import 'package:jamfix_admin/providers/drzava_provider.dart';
import 'package:jamfix_admin/providers/korisniciUloge_provider.dart';
import 'package:jamfix_admin/providers/korisnici_provider.dart';
import 'package:jamfix_admin/providers/pozicija_provider.dart';
import 'package:jamfix_admin/providers/uloge_provider.dart';
import 'package:jamfix_admin/screens/korisnici_list_screen.dart';
import 'package:jamfix_admin/utils/util.dart';
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

  SearchResult<KorisniciUloge>? korisniciUlogeResult;
  SearchResult<Korisnici>? korisniciResult;
  SearchResult<Pozicija>? pozicijaResult;
  SearchResult<Drzava>? drzavaResult;
  SearchResult<Uloge>? ulogeResult;

  KorisniciUlogeProvider _korisniciUlogeProvider = KorisniciUlogeProvider();
  KorisniciProvider _korisniciProvider = KorisniciProvider();
  PozicijaProvider _pozicijaProvider = PozicijaProvider();
  DrzavaProvider _drzavaProvider = DrzavaProvider();
  UlogeProvider _ulogeProvider = UlogeProvider();

  final _formKey = GlobalKey<FormState>();
  Map<String, dynamic> _initialValue = {};
  bool isLoading = true;
  bool aktivan = false;
  String? selectedPozicijaId;
  String? selectedDrzavaId;
  String? selectedUloga;
  DateTime? selectedDate;

  String? validateEmail(String? email) {
    RegExp emailRegex = RegExp(r'^[\w\.-]+@[\w-]+\.\w{2,3}(\.\w{2,3})?$');
    final isEmailValid = emailRegex.hasMatch(email ?? '');
    if (!isEmailValid) {
      return 'Please enter a valid email';
    }
    return null;
  }

  String? validatePhoneNumber(String? phoneNumber) {
    RegExp phoneRegex = RegExp(r'^\d{3}-\d{3}-\d{3}$');
    final isPhoneValid = phoneRegex.hasMatch(phoneNumber ?? '');
    if (!isPhoneValid) {
      return 'Please enter a valid phone number in the format XXX-XXX-XXX';
    }
    return null;
  }

  @override
  void initState() {
    super.initState();
    if (widget.korisnici != null) {
      setState(() {
        _initialValue = {
          'ime': widget.korisnici?.ime,
          'prezime': widget.korisnici?.prezime,
          'telefon': widget.korisnici?.telefon,
          'drzavaId': widget.korisnici?.drzavaId,
          'pozicijaId': widget.korisnici?.pozicijaId,
          'aktivnost': widget.korisnici?.aktivnost,
          'email': widget.korisnici?.email,
        };
        imeController.text = _initialValue['ime'] ?? '';
        prezimeController.text = _initialValue['prezime'] ?? '';
        telefonController.text = _initialValue['telefon'] ?? '';
        emailController.text = _initialValue['email'] ?? '';
        aktivan = _initialValue['aktivnost'];
      });
    }
    _korisniciUlogeProvider = context.read<KorisniciUlogeProvider>();
    _korisniciProvider = context.read<KorisniciProvider>();
    _pozicijaProvider = context.read<PozicijaProvider>();
    _drzavaProvider = context.read<DrzavaProvider>();
    _ulogeProvider = context.read<UlogeProvider>();
    _ucitajPodatke();
  }

  Future<void> _ucitajPodatke() async {
    var korisniciUloge = await _korisniciUlogeProvider.get();
    var pozicije = await _pozicijaProvider.get();
    var podaci = await _korisniciProvider.get();
    var drzava = await _drzavaProvider.get();
    var uloge = await _ulogeProvider.get();

    setState(() {
      korisniciUlogeResult = korisniciUloge;
      pozicijaResult = pozicije;
      korisniciResult = podaci;
      drzavaResult = drzava;
      ulogeResult = uloge;
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
        appBar: AppBar(),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    controller: imeController,
                    decoration: const InputDecoration(labelText: 'Ime'),
                    validator: (name) =>
                        name!.length < 3 ? 'Ime mora imati bar 3 slova' : null,
                  ),
                  const SizedBox(height: 16.0),
                  TextFormField(
                    controller: prezimeController,
                    decoration: const InputDecoration(labelText: 'Prezime'),
                    validator: (name) => name!.length < 3
                        ? 'Prezime mora imati bar 3 slova'
                        : null,
                  ),
                  TextFormField(
                    controller: emailController,
                    decoration: const InputDecoration(labelText: 'Email'),
                    validator: validateEmail,
                  ),
                  const SizedBox(height: 16.0),
                  TextFormField(
                    controller: telefonController,
                    decoration:
                        const InputDecoration(labelText: 'Broj Telefona'),
                    validator: validatePhoneNumber,
                  ),
                  const SizedBox(height: 16.0),
                  Row(
                    children: [
                      Expanded(
                        child: FormBuilderDropdown<String>(
                          name: 'drzavaId',
                          decoration: InputDecoration(
                            labelText: 'Drzava',
                            suffix: IconButton(
                              icon: const Icon(Icons.close),
                              onPressed: () {
                                setState(() {
                                  selectedDrzavaId =
                                      _initialValue['drzavaId']?.toString() ??
                                          "1";
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
                              : "1",
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 15.0),
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
                  Align(
                    alignment: Alignment.bottomRight,
                    child: ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          String drzavaId = selectedDrzavaId ?? "1";

                          Korisnici request = Korisnici(
                              ime: imeController.text,
                              prezime: prezimeController.text,
                              telefon: telefonController.text,
                              email: emailController.text,
                              drzavaId: int.parse(drzavaId),
                              aktivnost: aktivan,
                              pozicijaId: int.parse(
                                  widget.korisnici!.pozicijaId.toString()),
                              noviPassword: Authorization.psw,
                              passwordPotvrda: Authorization.psw,
                              datumVrijeme: selectedDate ?? DateTime.now(),
                              transakcijskiRacun: Authorization.brojRacuna);
                          _korisniciProvider.update(
                              widget.korisnici!.korisnikId!, request);
                          showDialog(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                              title: const Text("Success"),
                              content:
                                  const Text("Uspješno ste izvršili promjene"),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const KorisniciListScreen(),
                                      ),
                                    );
                                  },
                                  child: const Text("OK"),
                                )
                              ],
                            ),
                          );
                        }
                      },
                      child: const Text('Potvrdi Unos'),
                    ),
                  ), //------------------------------------------------------------
                  const Text("Promjeni poziciju"),
                  Row(
                    children: [
                      Expanded(
                        child: FormBuilderDropdown<String>(
                          name: 'pozicijaId',
                          decoration: InputDecoration(
                            labelText: 'Pozicija',
                            suffix: IconButton(
                              icon: const Icon(Icons.close),
                              onPressed: () {
                                setState(() {
                                  selectedDrzavaId =
                                      _initialValue['pozicijaId']?.toString() ??
                                          "1";
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
                                      .contains(_initialValue['pozicijaId']
                                          .toString())
                              ? _initialValue['pozicijaId'].toString()
                              : "1",
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5.0),

                  Align(
                    alignment: Alignment.bottomRight,
                    child: ElevatedButton(
                      onPressed: () async {
                        if (widget.korisnici != null) {
                          String pozicijaId = selectedPozicijaId ?? "1";
                          Korisnici request = Korisnici(
                              ime: imeController.text,
                              prezime: prezimeController.text,
                              telefon: telefonController.text,
                              email: emailController.text,
                              drzavaId: int.parse(
                                  widget.korisnici!.drzavaId.toString()),
                              aktivnost: aktivan,
                              pozicijaId: int.parse(pozicijaId),
                              noviPassword: Authorization.psw,
                              passwordPotvrda: Authorization.psw,
                              datumVrijeme: selectedDate ?? DateTime.now(),
                              transakcijskiRacun: Authorization.brojRacuna);
                          _korisniciProvider.update(
                              widget.korisnici!.korisnikId!, request);
                          showDialog(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                              title: const Text("Success"),
                              content:
                                  const Text("Uspješno ste izvršili promjene"),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const KorisniciListScreen(),
                                      ),
                                    );
                                  },
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
                  const SizedBox(
                    height: 5,
                  ),
                  //----------------------------------------------------------------------
                  const Text("Promjeni ulogu"),
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
                                    selectedDrzavaId =
                                        _initialValue['ulogaId']?.toString() ??
                                            "1";
                                  });
                                },
                              ),
                              hintText: 'Odaberi ulogu korisnika',
                            ),
                            items: ulogeResult?.result
                                    .map((item) => DropdownMenuItem(
                                          alignment:
                                              AlignmentDirectional.center,
                                          value: item.ulogaId.toString(),
                                          child: Text(item.naziv ?? ""),
                                        ))
                                    .toList() ??
                                [],
                            onChanged: (value) {
                              setState(() {
                                selectedUloga = value;
                              });
                            },
                            initialValue: ulogeResult != null &&
                                    ulogeResult!.result.isNotEmpty
                                ? ulogeResult!.result.first.ulogaId.toString()
                                : "1"),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5.0),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: ElevatedButton(
                      onPressed: () async {
                        if (widget.korisnici != null) {
                          String ulogaId = selectedUloga ?? "1";
                          KorisniciUloge uloge = KorisniciUloge(
                            korisnikId: widget.korisnici!.korisnikId,
                            ulogaId: int.parse(ulogaId),
                            datumIzmjene: DateTime.now(),
                          );
                          Navigator.of(context).pop();
                          for (var element in korisniciUlogeResult!.result) {
                            if (element.korisnikId ==
                                widget.korisnici!.korisnikId) {
                              _korisniciUlogeProvider.update(
                                  element.korisnikUlogaId, uloge);
                            }
                          }
                          showDialog(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                              title: const Text("Success"),
                              content:
                                  const Text("Uspješno ste izvršili promjene"),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const KorisniciListScreen(),
                                      ),
                                    );
                                  },
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
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2024),
      lastDate: DateTime(2025),
    );

    if (pickedDate != null) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );

      if (pickedTime != null) {
        setState(() {
          selectedDate = DateTime(
            pickedDate.year,
            pickedDate.month,
            pickedDate.day,
            pickedTime.hour,
            pickedTime.minute,
          );
        });
      }
    }
  }
}
