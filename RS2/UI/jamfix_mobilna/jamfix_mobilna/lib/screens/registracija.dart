import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jamfix_mobilna/main.dart';
import 'package:jamfix_mobilna/models/drzava.dart';
import 'package:jamfix_mobilna/models/korisnici.dart';
import 'package:jamfix_mobilna/models/search_result.dart';
import 'package:jamfix_mobilna/providers/drzava_provider.dart';
import 'package:jamfix_mobilna/providers/korisnici_provider.dart';
import 'package:jamfix_mobilna/utils/utils.dart';
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
  final TextEditingController transakcijskiRacunController =
      TextEditingController();
  TextEditingController _startDateController = TextEditingController();

  DrzavaProvider _drzavaProvider = DrzavaProvider();
  SearchResult<Drzava>? drzavaResult;
  final _formKey = GlobalKey<FormState>();
  DateTime? selectedDate;

  KorisniciProvider _korisniciProvider = KorisniciProvider();
  String? selectedDrzavaId = '1';

  @override
  void initState() {
    super.initState();
    _drzavaProvider = context.read<DrzavaProvider>();
  }

  String? validateEmail(String? email) {
    RegExp emailRegex = RegExp(r'^[\w\.-]+@[\w-]+\.\w{2,3}(\.\w{2,3})?$');
    final isEmailValid = emailRegex.hasMatch(email ?? '');
    if (!isEmailValid) {
      return 'Molimo unesite validan email\nu formatu example@example.com';
    }
    return null;
  }

  String? validatePhoneNumber(String? phoneNumber) {
    RegExp phoneRegex = RegExp(r'^\d{3}-\d{3}-\d{3}$');
    final isPhoneValid = phoneRegex.hasMatch(phoneNumber ?? '');
    if (!isPhoneValid) {
      return 'Molimo unesite validan broj telefona\nu formatu 06X-XXX-XXX';
    }
    return null;
  }

  String? validateCreditCardNumber(String? creditCardNumber) {
    RegExp cardRegex = RegExp(r'^\d{4} \d{4} \d{4} \d{4}$');
    final isCardValid = cardRegex.hasMatch(creditCardNumber ?? '');
    if (!isCardValid) {
      return 'Molimo unesite validan broj transakcijskog racuna\nu formatu XXXX XXXX XXXX XXXX';
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
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        LengthLimitingTextInputFormatter(11),
                        FilteringTextInputFormatter.allow(RegExp(r'^[0-9-]*$')),
                      ],
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
                      controller: transakcijskiRacunController,
                      decoration: const InputDecoration(
                          labelText: 'Transakcijski racun'),
                      validator: validateCreditCardNumber,
                      keyboardType: TextInputType.phone,
                      inputFormatters: <TextInputFormatter>[
                        LengthLimitingTextInputFormatter(19),
                        FilteringTextInputFormatter.allow(RegExp(r'^[0-9 ]*$')),
                      ],
                    ),
                    const SizedBox(height: 8.0),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: _startDateController,
                            decoration: const InputDecoration(
                              labelText: 'Datum rodjenja',
                              hintText: 'Odaberite datum',
                              labelStyle: TextStyle(color: Colors.black),
                              hintStyle: TextStyle(color: Colors.black),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                              ),
                            ),
                            onTap: () async {
                              DateTime? pickedDate = await showDatePicker(
                                context: context,
                                initialDate: selectedDate,
                                firstDate: DateTime(1950),
                                lastDate: DateTime(2101),
                              );

                              if (pickedDate != null &&
                                  pickedDate != selectedDate) {
                                setState(() {
                                  selectedDate = pickedDate;
                                  _startDateController.text =
                                      "${pickedDate.day}.${pickedDate.month}.${pickedDate.year}.";
                                });
                              }
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Obavezan unos datuma!';
                              }
                              return null;
                            },
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ],
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
                    Row(
                      children: [
                        Expanded(
                          child: FutureBuilder(
                            future: _drzavaProvider.getDrzave(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const CircularProgressIndicator();
                              } else if (snapshot.hasError) {
                                return Text('Greška: ${snapshot.error}');
                              } else {
                                drzavaResult =
                                    snapshot.data as SearchResult<Drzava>?;
                                return DropdownButton<String>(
                                  value: selectedDrzavaId,
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      selectedDrzavaId = newValue;
                                    });
                                  },
                                  items: (drzavaResult?.result
                                          .map(
                                            (item) => DropdownMenuItem<String>(
                                              value: item.drzavaId.toString(),
                                              child: Text(item.naziv ?? ""),
                                            ),
                                          )
                                          .toList()) ??
                                      [],
                                );
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8.0),
                    Align(
                        alignment: Alignment.center,
                        child: ElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              String drzavaId = selectedDrzavaId ??
                                  Authorization.drzavaID.toString();
                              var request = Korisnici(
                                  ime: imeController.text,
                                  prezime: prezimeController.text,
                                  email: emailController.text,
                                  telefon: telefonController.text,
                                  korisnickoIme: korisnickoImeController.text,
                                  password: passwordController.text,
                                  passwordPotvrda:
                                      passwordPotvrdaController.text,
                                  drzavaId: int.parse(drzavaId),
                                  aktivnost: true,
                                  pozicijaId: 1,
                                  datumRodjenja: selectedDate ?? DateTime.now(),
                                  transakcijskiRacun:
                                      transakcijskiRacunController.text);
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
