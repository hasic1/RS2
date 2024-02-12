import 'package:flutter/material.dart';
import 'package:jamfix_mobilna/models/drzava.dart';
import 'package:jamfix_mobilna/models/korisnici.dart';
import 'package:jamfix_mobilna/models/search_result.dart';
import 'package:jamfix_mobilna/providers/drzava_provider.dart';
import 'package:jamfix_mobilna/providers/korisnici_provider.dart';
import 'package:provider/provider.dart';

class RegistracijaScreen extends StatefulWidget {
  const RegistracijaScreen({Key? key}) : super(key: key);

  @override
  State<RegistracijaScreen> createState() => _RegistracijaScreen();
}

class _RegistracijaScreen extends State<RegistracijaScreen> {
  final TextEditingController imeController = TextEditingController();
  final TextEditingController prezimeController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController telefonController = TextEditingController();
  final TextEditingController korisnickoImeController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController passwordPotvrdaController =
      TextEditingController();
  DrzavaProvider _drzavaProvider = DrzavaProvider();
  SearchResult<Drzava>? drzavaResult;

  KorisniciProvider _korisniciProvider = KorisniciProvider();
  String? selectedDrzavaId;

  @override
  void initState() {
    super.initState();
    _drzavaProvider = context.read<DrzavaProvider>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              width: 300.0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    controller: imeController,
                    decoration: const InputDecoration(labelText: 'Ime'),
                  ),
                  const SizedBox(height: 8.0),
                  TextFormField(
                    controller: prezimeController,
                    decoration: const InputDecoration(labelText: 'Prezime'),
                  ),
                  const SizedBox(height: 8.0),
                  TextFormField(
                    controller: emailController,
                    decoration: const InputDecoration(labelText: 'Email'),
                  ),
                  SizedBox(height: 8.0),
                  TextFormField(
                    controller: telefonController,
                    decoration: const InputDecoration(labelText: 'Telefon'),
                  ),
                  const SizedBox(height: 8.0),
                  TextFormField(
                    controller: korisnickoImeController,
                    decoration:
                        const InputDecoration(labelText: 'Korisničko Ime'),
                  ),
                  const SizedBox(height: 8.0),
                  TextFormField(
                    controller: passwordController,
                    decoration: const InputDecoration(labelText: 'Lozinka'),
                    obscureText: true,
                  ),
                  const SizedBox(height: 8.0),
                  TextFormField(
                    controller: passwordPotvrdaController,
                    decoration:
                        const InputDecoration(labelText: 'Potvrdi Lozinku'),
                    obscureText: true,
                  ),
                  const SizedBox(height: 8.0),
                  FutureBuilder(
                    future: _drzavaProvider.get(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else {
                        drzavaResult = snapshot.data as SearchResult<Drzava>?;
                        return Row(
                          children: [
                            Expanded(
                              child: DropdownButton<String>(
                                value: selectedDrzavaId,
                                onChanged: (String? newValue) {
                                  setState(() {
                                    selectedDrzavaId = newValue;
                                  });
                                },
                                items: (drzavaResult?.result
                                        .map<DropdownMenuItem<String>>(
                                          (item) => DropdownMenuItem<String>(
                                            value: item.drzavaId.toString(),
                                            child: Text(item.naziv ?? ""),
                                          ),
                                        )
                                        .toList()) ??
                                    [],
                              ),
                            )
                          ],
                        );
                      }
                    },
                  ),
                  const SizedBox(height: 8.0),
                  Align(
                      alignment: Alignment.center,
                      child: ElevatedButton(
                        onPressed: () async {
                          if (selectedDrzavaId != null) {
                            var request = Korisnici(
                                ime: imeController.text,
                                prezime: prezimeController.text,
                                email: emailController.text,
                                telefon: telefonController.text,
                                korisnickoIme: korisnickoImeController.text,
                                password: passwordController.text,
                                passwordPotvrda: passwordPotvrdaController.text,
                                drzavaId: int.parse(selectedDrzavaId!),
                                aktivnost: true,
                                pozicijaId: 1,
                                );
                            try {
                              _korisniciProvider.insert(request);
                              Navigator.pop(context);
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
                          }
                        },
                        child: const Text('Registruj se'),
                      )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
