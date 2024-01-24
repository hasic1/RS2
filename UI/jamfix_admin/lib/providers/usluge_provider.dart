import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:jamfix_admin/models/usluge.dart';
import 'package:jamfix_admin/providers/base_provider.dart';

class UslugeProvider extends BaseProvider<Usluge> {
  UslugeProvider() : super("Usluge");

  @override
  Usluge fromJson(data) {
    return Usluge.fromJson(data);
  }

  createPaymentIntent(String amount, String currency) async {
    try {
      // Zahtev body
      Map<String, dynamic> body = {
        'amount': calculateAmount(amount),
        'currency': currency,
      };

      // Napravi post zahtev ka Stripe-u
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

  calculateAmount(String amount) {
    final calculatedAmount = (int.parse(amount)) * 100;
    return calculatedAmount.toString();
  }
}
