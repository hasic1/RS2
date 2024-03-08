import 'package:flutter/material.dart';
import 'package:jamfix_mobilna/main.dart';
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
  final _formKey = GlobalKey<FormState>();

  KorisniciProvider _korisniciProvider = KorisniciProvider();
  String? selectedDrzavaId;

  @override
  void initState() {
    super.initState();
    _drzavaProvider = context.read<DrzavaProvider>();
  }

  String? validateEmail(String? email) {
    RegExp emailRegex = RegExp(r'^[\w\.-]+@[\w-]+\.\w{2,3}(\.\w{2,3})?$');
    final isEmailValid = emailRegex.hasMatch(email ?? '');
    if (!isEmailValid) {
      return 'Molimo unesite validan email';
    }
    return null;
  }

  String? validatePhoneNumber(String? phoneNumber) {
    RegExp phoneRegex = RegExp(r'^\d{3}-\d{3}-\d{3}$');
    final isPhoneValid = phoneRegex.hasMatch(phoneNumber ?? '');
    if (!isPhoneValid) {
      return 'Molimo unesite validan broj telefona u formatu 06X-XXX-XXX';
    }
    return null;
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
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      controller: imeController,
                      decoration: const InputDecoration(labelText: 'Ime'),
                      validator: (name) => name!.length < 3
                          ? 'Ime mora imati bar 3 slova'
                          : null,
                    ),
                    const SizedBox(height: 8.0),
                    TextFormField(
                      controller: prezimeController,
                      decoration: const InputDecoration(labelText: 'Prezime'),
                      validator: (name) => name!.length < 3
                          ? 'Prezime mora imati bar 3 slova'
                          : null,
                    ),
                    const SizedBox(height: 8.0),
                    TextFormField(
                      controller: emailController,
                      decoration: const InputDecoration(labelText: 'Email'),
                      validator: validateEmail,
                    ),
                    SizedBox(height: 8.0),
                    TextFormField(
                      controller: telefonController,
                      decoration: const InputDecoration(labelText: 'Telefon'),
                      validator: validatePhoneNumber,
                    ),
                    const SizedBox(height: 8.0),
                    TextFormField(
                      controller: korisnickoImeController,
                      decoration:
                          const InputDecoration(labelText: 'Korisničko ime'),
                      validator: (name) => name!.length < 3
                          ? 'Korisničko ime mora imati bar 3 slova'
                          : null,
                    ),
                    const SizedBox(height: 8.0),
                    TextFormField(
                      controller: passwordController,
                      decoration: const InputDecoration(labelText: 'Lozinka'),
                      obscureText: true,
                      validator: (name) => name!.length < 5
                          ? 'Lozinka mora imati bar 5 znakova'
                          : null,
                    ),
                    const SizedBox(height: 8.0),
                    TextFormField(
                      controller: passwordPotvrdaController,
                      decoration:
                          const InputDecoration(labelText: 'Potvrdi lozinku'),
                      obscureText: true,
                      validator: (name) =>
                          name!.length < 5 ? 'Unesite lozinku' : null,
                    ),
                    const SizedBox(height: 8.0),
                    FutureBuilder(
                      future: _drzavaProvider.get(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const CircularProgressIndicator();
                        } else if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        } else {
                          drzavaResult = snapshot.data as SearchResult<Drzava>?;
                          if (drzavaResult?.result.isNotEmpty ?? false) {
                            selectedDrzavaId =
                                drzavaResult!.result.first.drzavaId.toString();
                          }
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
                                  alignment: Alignment.center,
                                  items: (drzavaResult?.result
                                          .map<DropdownMenuItem<String>>(
                                            (item) => DropdownMenuItem<String>(
                                              alignment:
                                                  AlignmentDirectional.center,
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
                            if (_formKey.currentState!.validate()) {
                              var request = Korisnici(
                                ime: imeController.text,
                                prezime: prezimeController.text,
                                email: emailController.text,
                                telefon: telefonController.text,
                                korisnickoIme: korisnickoImeController.text,
                                password: passwordController.text,
                                passwordPotvrda: passwordPotvrdaController.text,
                                drzavaId: int.parse(selectedDrzavaId ?? '1'),
                                aktivnost: true,
                                pozicijaId: 1,
                              );
                              _korisniciProvider.insert(request);
                              showDialog(
                                context: context,
                                builder: (BuildContext context) => AlertDialog(
                                  title: const Text("Success"),
                                  content:
                                      const Text("Uspješno ste kreirali racun"),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => LoginPage(),
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
                          child: const Text('Registruj se'),
                        )),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}