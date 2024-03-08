// ignore_for_file: use_build_context_synchronously
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:jamfix_admin/models/product.dart';
import 'package:jamfix_admin/models/usluge.dart';
import 'package:jamfix_admin/providers/usluge_provider.dart';
import 'package:flutter_stripe/flutter_stripe.dart'
    show
        Address,
        BillingDetails,
        CardPaymentMethodData,
        PaymentMethodData,
        PaymentMethodParams,
        PaymentSheetGooglePay,
        PaymentSheetResultStatus,
        SetupPaymentSheetParameters,
        Stripe,
        StripeException;
import 'package:jamfix_admin/screens/korisnik_product_list_screen.dart';
import 'package:jamfix_admin/utils/util.dart';
import 'package:provider/provider.dart';

class PlatiUsluguScreen extends StatefulWidget {
  final Product? product;

  PlatiUsluguScreen({this.product, Key? key}) : super(key: key);

  @override
  _PlatiUsluguScreenState createState() => _PlatiUsluguScreenState();
}

class _PlatiUsluguScreenState extends State<PlatiUsluguScreen> {
//   Map<String, dynamic>? paymentIntent;
//   bool isCheckboxChecked = false;
//   TextEditingController brojZiroracunaController = TextEditingController();
//   TextEditingController _expiryDateController = TextEditingController();
//   TextEditingController _cvcController = TextEditingController();
//   final _formKey = GlobalKey<FormState>();
//   UslugeProvider _uslugeProvider = UslugeProvider();
//   String? imePrezime1 = "${Authorization.ime!} ${Authorization.prezime!}";

//   @override
//   void initState() {
//     super.initState();
//     Future.delayed(Duration.zero, () {});
//     _uslugeProvider = context.read<UslugeProvider>();
//   }

//   String? validateCreditCardNumber(String? creditCardNumber) {
//     RegExp cardRegex = RegExp(r'^\d{4} \d{4} \d{4} \d{4}$');
//     final isCardValid = cardRegex.hasMatch(creditCardNumber ?? '');
//     if (!isCardValid) {
//       return 'Please enter a valid credit card number in the format XXXX XXXX XXXX XXXX';
//     }
//     return null;
//   }

//   String? validateExpiryDate(String? value) {
//     if (value == null || value.isEmpty) {
//       return 'Molimo unesite datum isteka kartice';
//     }
//     // Dodajte dodatne provjere po potrebi
//     return null;
//   }

//   void _showUgovorDialog() {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: const Text('Ugovor o plaćanju'),
//           content: const SingleChildScrollView(
//             child: Column(
//               children: [
//                 Text(
//                   'Ugovor o plaćanju\n\n'
//                   'Suglasan/na sam da ću izvršiti plaćanje za pruženu uslugu prema sljedećim uslovima:\n\n'
//                   '1. Broj Žiro Računa:\n'
//                   '   [Unesite broj žiro računa na koji će se izvršiti plaćanje.]\n\n'
//                   '2. Iznos Plaćanja:\n'
//                   '   [Iznos plaćanja ce biti u vrijednosti proizvoda koji ste odabrali, a valuta KM.]\n\n'
//                   '3. Prihvaćanje Uvjeta:\n'
//                   '   Potvrđujem da sam pročitao/la i prihvaćam uvjete plaćanja.\n\n'
//                   '4. Sigurnost Transakcije:\n'
//                   '   Osiguravamo odgovarajuće mjere sigurnosti zaštite vaših financijskih podataka.\n\n'
//                   '5. Povrat Sredstava:\n'
//                   '   Povrat sredstava moguć je sukladno uslovima naše politike povrata.\n\n'
//                   '6. Kontakt Informacije:\n'
//                   '   Za sva pitanja ili dodatne informacije, obratite nam se na [e-mail adresa] ili [telefonski broj].\n\n'
//                   'Hvala vam što koristite naše usluge.',
//                   style: TextStyle(fontSize: 16),
//                 ),
//               ],
//             ),
//           ),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//               child: const Text('Zatvori'),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Stranica za plaćanje'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const Text(
//                 'Molimo pročitajte uslove plaćanja prije nastavka:',
//                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//               ),
//               const SizedBox(height: 10),
//               TextFormField(
//                 controller: brojZiroracunaController,
//                 keyboardType: TextInputType.number,
//                 decoration:
//                     const InputDecoration(labelText: 'Broj kartice računa'),
//                 validator: validateCreditCardNumber,
//               ),
//               TextFormField(
//                 controller: _expiryDateController,
//                 decoration: InputDecoration(
//                   labelText: 'Datum isteka kartice (MM/YY)',
//                 ),
//                 validator: validateExpiryDate,
//               ),
//               TextFormField(
//                 decoration: InputDecoration(
//                   labelText: 'CVC kod',
//                 ),
//                 controller: _cvcController,
//                 keyboardType: TextInputType.number,
//                 validator: (cvc) =>
//                     cvc!.length < 3 ? 'CVC kod mora imati bar 3 znaka' : null,
//               ),
//               const SizedBox(height: 10),
//               Row(
//                 children: [
//                   Checkbox(
//                     value: isCheckboxChecked,
//                     onChanged: (value) {
//                       setState(() {
//                         isCheckboxChecked = value ?? false;
//                       });
//                       if (isCheckboxChecked) {
//                         _showUgovorDialog();
//                       }
//                     },
//                   ),
//                   const Text('Prihvaćam uslove plaćanja'),
//                 ],
//               ),
//               const SizedBox(height: 20),
//               ElevatedButton(
//                 onPressed: () async {
//                   if (_formKey.currentState!.validate() && isCheckboxChecked) {
//                     double? cijenaDouble = widget.product?.cijena;
//                     String cijenaString = cijenaDouble.toString();

//                     Usluge request = Usluge(
//                       imePrezime: imePrezime1,
//                       datum: DateTime.now(),
//                       brojRacuna: brojZiroracunaController.text,
//                       nazivPaketa: widget.product?.nazivProizvoda,
//                       cijena: cijenaString,
//                       proizvodId: widget.product?.proizvodId,
//                     );

//                     await sendPaymentDataToServer(request);
//                     double cijenaDoubleForStripe = cijenaDouble ?? 0.0;
//                     await stripeMakePayment(cijenaDoubleForStripe);
//                     showDialog(
//                       context: context,
//                       builder: (BuildContext context) => AlertDialog(
//                         title: const Text("Success"),
//                         content: const Text("Uspješno ste izvrsili placanje"),
//                         actions: [
//                           TextButton(
//                             onPressed: () {
//                               Navigator.pop(context);
//                               Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                   builder: (context) =>
//                                       const KorisnikProductListScreen(),
//                                 ),
//                               );
//                             },
//                             child: const Text("OK"),
//                           )
//                         ],
//                       ),
//                     );
//                   } else {
//                     // Prikaz poruke o grešci ako forma nije validna ili uslovi nisu prihvaćeni
//                     showDialog(
//                       context: context,
//                       builder: (BuildContext context) => AlertDialog(
//                         title: const Text("Error"),
//                         content: const Text("Niste prihvatili uslove placanja"),
//                         actions: [
//                           TextButton(
//                             onPressed: () => Navigator.pop(context),
//                             child: const Text("OK"),
//                           )
//                         ],
//                       ),
//                     );
//                   }
//                 },
//                 child: const Text('Plati'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Future<void> stripeMakePayment(double amount) async {
//     try {
//       var paymentIntent = await createPaymentIntent(amount, 'BAM');
//       await Stripe.instance
//           .initPaymentSheet(
//               paymentSheetParameters: SetupPaymentSheetParameters(
//                   billingDetails: const BillingDetails(
//                       name: 'YOUR NAME',
//                       email: 'YOUREMAIL@gmail.com',
//                       phone: 'YOUR NUMBER',
//                       address: Address(
//                           city: 'YOUR CITY',
//                           country: 'YOUR COUNTRY',
//                           line1: 'YOUR ADDRESS 1',
//                           line2: 'YOUR ADDRESS 2',
//                           postalCode: 'YOUR PINCODE',
//                           state: 'YOUR STATE')),
//                   paymentIntentClientSecret: paymentIntent['client_secret'],
//                   style: ThemeMode.dark,
//                   merchantDisplayName: 'Ikay'))
//           .then((value) {});

//       await displayPaymentSheet();
//     } catch (e) {
//       print(e.toString());
//     }
//   }

//   Future<void> displayPaymentSheet() async {
//     try {
//       await Stripe.instance.presentPaymentSheet();

//       print('Plaćanje uspešno završeno');
//     } on Exception catch (e) {
//       if (e is StripeException) {
//         print('Greška od Stripes-a: ${e.error.localizedMessage}');
//       } else {
//         print('Neočekivana greška: $e');
//       }
//     }
//   }

//   Future<Map<String, dynamic>> createPaymentIntent(
//       double amount, String currency) async {
//     try {
//       Map<String, dynamic> body = {
//         'amount': calculateAmount(amount.toString()),
//         'currency': currency,
//       };

//       var response = await http.post(
//         Uri.parse('https://api.stripe.com/v1/payment_intents'),
//         headers: {
//           'Authorization': 'Bearer ${dotenv.env['STRIPE_SECRET']}',
//           'Content-Type': 'application/x-www-form-urlencoded',
//         },
//         body: body,
//       );
//       return json.decode(response.body);
//     } catch (err) {
//       throw Exception(err.toString());
//     }
//   }

// // Funkcija za slanje podataka na server
//   Future<void> sendPaymentDataToServer(Usluge request) async {
//     try {
//       var response = await http.post(
//         Uri.parse('https://localhost:7097/Usluge'),
//         headers: {
//           'Content-Type': 'application/json',
//         },
//         body: json.encode(request.toJson()),
//       );

//       if (response.statusCode == 200) {
//       } else {
//         throw Exception(
//             'Neuspješno slanje na server. Status: ${response.statusCode}');
//       }
//     } catch (err) {
//       throw Exception('Greška prilikom slanja na server: $err');
//     }
//   }

//   calculateAmount(String amount) {
//     final a = (int.parse(amount)) * 100;
//     return a.toString();
//   }
late TextEditingController paymentController;
  late GlobalKey<FormState> paymentForm;
  Map<String, dynamic>? paymentIntentData;

  @override
  void initState() {
    super.initState();
    paymentController = TextEditingController();
    paymentForm = GlobalKey<FormState>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stripe Payment Example'),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.secondary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: paymentForm,
          child: ListView(
            shrinkWrap: true,
            children: [
              TextFormField(
                controller: paymentController,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Required field';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  hintText: 'Enter an amount',
                  fillColor: const Color(0xffF5F5F5),
                  filled: true,
                  border: InputBorder.none,
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: const BorderSide(
                      color: Color(0xff1D275C),
                      width: 2.01,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: const BorderSide(
                      color: Color(0xffCCCCCC),
                      width: 2.0,
                    ),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: const BorderSide(
                      color: Color(0xffD6001A),
                      width: 2.0,
                    ),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: const BorderSide(
                      color: Color(0xffF0642F),
                      width: 2.0,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  if (paymentForm.currentState!.validate()) {
                    debugPrint(paymentController.text);
                    var paymentAmount = int.parse(paymentController.text) * 100;

                    makePayment(amount: paymentAmount.toString(), currency: "USD");
                  }
                },
                child: const Text('Make Payment'),
              )
            ],
          ),
        ),
      ),
    );
  }
  Future<void> makePayment(
      {required String amount, required String currency}) async {
    try {
      paymentIntentData = await createPaymentIntent(amount, currency);
      const gpay = PaymentSheetGooglePay(
        merchantCountryCode: "US",
        currencyCode: "USD",
        testEnv: true,
      );
      if (paymentIntentData != null) {
        await Stripe.instance.initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
            googlePay: gpay,
            merchantDisplayName: 'Adiwele',
            paymentIntentClientSecret: paymentIntentData!['client_secret'],
            customerEphemeralKeySecret: paymentIntentData!['ephemeralKey'],
          ),
        );
        displayPaymentSheet();
      }
    } catch (e, s) {
      debugPrint('exception:$e$s');
    }
  }
  createPaymentIntent(String amount, String currency) async {
    try {
      Map<String, dynamic> body = {
        'amount': amount,
        'currency': currency,
        'payment_method_types[]': 'card'
      };
      var response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        body: body,
        headers: {
          'Authorization': 'Bearer sk_test_51OYqyiFJavMmN9lEHYOinCIgUffaB493XjhUGTvXmXgHizTZMQyfiBDD2gwT3ooovIwGBU91gXRwAEytsmByPcbc00V5LeI9dl',
          'Content-Type': 'application/x-www-form-urlencoded'
        },
      );

      return jsonDecode(response.body.toString());
    } catch (e) {
      debugPrint(e.toString());
    }
  }
  displayPaymentSheet() async {
    try {
      await Stripe.instance.presentPaymentSheet().then(
            (value) {},
          );
    } on StripeException catch (e) {
      debugPrint('Payment failed: ${e.error.localizedMessage}');
    } catch (e) {
      debugPrint('An unexpected error occurred: $e');
    }
  }
}
