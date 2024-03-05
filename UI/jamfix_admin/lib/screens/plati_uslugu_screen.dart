import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:jamfix_admin/models/product.dart';
import 'package:jamfix_admin/models/uslugaStavke.dart';
import 'package:jamfix_admin/models/usluge.dart';
import 'package:jamfix_admin/providers/usluge_provider.dart';
import 'package:flutter_stripe/flutter_stripe.dart'
    show
        Address,
        BillingDetails,
        //PaymentSheetResultStatus,
        SetupPaymentSheetParameters,
        Stripe,
        StripeException;
import 'package:jamfix_admin/screens/korisnik_product_list_screen.dart';
import 'package:provider/provider.dart';

class PlatiUsluguScreen extends StatefulWidget {
  final Product? product;

  PlatiUsluguScreen({this.product, Key? key}) : super(key: key);

  @override
  _PlatiUsluguScreenState createState() => _PlatiUsluguScreenState();
}

class _PlatiUsluguScreenState extends State<PlatiUsluguScreen> {
  bool isCheckboxChecked = false;
  TextEditingController brojZiroracunaController = TextEditingController();
  TextEditingController imePrezimeController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  UslugeProvider _uslugeProvider = UslugeProvider();
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {});
    _uslugeProvider = context.read<UslugeProvider>();
  }

  String? validateCreditCardNumber(String? creditCardNumber) {
    RegExp cardRegex = RegExp(r'^\d{4} \d{4} \d{4} \d{4}$');
    final isCardValid = cardRegex.hasMatch(creditCardNumber ?? '');
    if (!isCardValid) {
      return 'Please enter a valid credit card number in the format XXXX XXXX XXXX XXXX';
    }
    return null;
  }

  void _showUgovorDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Ugovor o plaćanju'),
          content: const SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  'Ugovor o plaćanju\n\n'
                  'Suglasan/na sam da ću izvršiti plaćanje za pruženu uslugu prema sljedećim uvjetima:\n\n'
                  '1. Broj Žiro Računa:\n'
                  '   [Unesite broj žiro računa na koji će se izvršiti plaćanje.]\n\n'
                  '2. Iznos Plaćanja:\n'
                  '   [Iznos plaćanja ce biti u vrijednosti proizvoda koji ste odabrali, a valuta KM.]\n\n'
                  '3. Prihvaćanje Uvjeta:\n'
                  '   Potvrđujem da sam pročitao/la i prihvaćam uvjete plaćanja.\n\n'
                  '4. Sigurnost Transakcije:\n'
                  '   Osiguravamo odgovarajuće mjere sigurnosti zaštite vaših financijskih podataka.\n\n'
                  '5. Povrat Sredstava:\n'
                  '   Povrat sredstava moguć je sukladno uvjetima naše politike povrata.\n\n'
                  '6. Kontakt Informacije:\n'
                  '   Za sva pitanja ili dodatne informacije, obratite nam se na [e-mail adresa] ili [telefonski broj].\n\n'
                  'Hvala vam što koristite naše usluge.',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Zatvori'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stranica za plaćanje'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Molimo pročitajte uvjete plaćanja prije nastavka:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: imePrezimeController,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(labelText: 'Ime i prezime'),
                validator: (name) => name!.isEmpty ? 'Polje je obavezno' : null,
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: brojZiroracunaController,
                keyboardType: TextInputType.number,
                decoration:
                    const InputDecoration(labelText: 'Broj kartice računa'),
                validator: validateCreditCardNumber,
              ),
              const SizedBox(height: 10),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Iznos u KM'),
                validator: (name) => name!.isEmpty ? 'Polje je obavezno' : null,
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Checkbox(
                    value: isCheckboxChecked,
                    onChanged: (value) {
                      _showUgovorDialog();
                      setState(() {
                        isCheckboxChecked = value ?? false;
                      });
                    },
                  ),
                  const Text('Prihvaćam uvjete plaćanja'),
                ],
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    double? cijenaDouble = widget.product?.cijena;
                    String cijenaString = cijenaDouble.toString();

                    Usluge request = Usluge(
                        imePrezime: imePrezimeController.text,
                        datum: DateTime.now(),
                        brojRacuna: brojZiroracunaController.text,
                        nazivPaketa: widget.product?.nazivProizvoda,
                        cijena: cijenaString,
                        proizvodId: widget.product?.proizvodId);

                    await sendPaymentDataToServer(request);

                    double cijenaDoubleForStripe = cijenaDouble ?? 0.0;
                    await stripeMakePayment(cijenaDoubleForStripe);
                    showDialog(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        title: const Text("Success"),
                        content: const Text("Uspješno ste kreirali racun"),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      KorisnikProductListScreen(),
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
                child: const Text('Plati'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Funkcija za slanje podataka na server
  Future<void> sendPaymentDataToServer(Usluge request) async {
    try {
      var response = await http.post(
        Uri.parse('https://localhost:7097/Usluge'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode(request.toJson()),
      );

      if (response.statusCode == 200) {
      } else {
        throw Exception(
            'Neuspješno slanje na server. Status: ${response.statusCode}');
      }
    } catch (err) {
      throw Exception('Greška prilikom slanja na server: $err');
    }
  }

  Future<void> stripeMakePayment(double amount) async {
    try {
      var paymentIntent = await createPaymentIntent(amount, 'BAM');
      await Stripe.instance
          .initPaymentSheet(
              paymentSheetParameters: SetupPaymentSheetParameters(
                  billingDetails: const BillingDetails(
                      name: 'YOUR NAME',
                      email: 'YOUREMAIL@gmail.com',
                      phone: 'YOUR NUMBER',
                      address: Address(
                          city: 'YOUR CITY',
                          country: 'YOUR COUNTRY',
                          line1: 'YOUR ADDRESS 1',
                          line2: 'YOUR ADDRESS 2',
                          postalCode: 'YOUR PINCODE',
                          state: 'YOUR STATE')),
                  paymentIntentClientSecret: paymentIntent['client_secret'],
                  style: ThemeMode.dark,
                  merchantDisplayName: 'Ikay'))
          .then((value) {});

      await displayPaymentSheet();
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  Future<void> displayPaymentSheet() async {
    try {
      await Stripe.instance.presentPaymentSheet();

      Fluttertoast.showToast(msg: 'Plaćanje uspešno završeno');
    } on Exception catch (e) {
      if (e is StripeException) {
        Fluttertoast.showToast(
            msg: 'Greška od Stripes-a: ${e.error.localizedMessage}');
      } else {
        Fluttertoast.showToast(msg: 'Neočekivana greška: $e');
      }
    }
  }

  Future<Map<String, dynamic>> createPaymentIntent(
      double amount, String currency) async {
    try {
      Map<String, dynamic> body = {
        'amount': calculateAmount(amount),
        'currency': currency,
      };

      var response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        headers: {
          'Authorization': 'Bearer ${dotenv.env['STRIPE_SECRET']}',
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: body,
      );
      return json.decode(response.body);
    } catch (err) {
      throw Exception(err.toString());
    }
  }

  String calculateAmount(double amount) {
    final calculatedAmount = (amount * 100).toInt();
    return calculatedAmount.toString();
  }
}
