import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jamfix_mobilna/models/product.dart';
import 'package:jamfix_mobilna/models/usluge.dart';
import 'package:jamfix_mobilna/providers/controller.dart';
import 'package:jamfix_mobilna/providers/usluge_provider.dart';
import 'package:jamfix_mobilna/utils/utils.dart';
import 'package:jamfix_mobilna/widgets/master_screen.dart';
import 'package:provider/provider.dart';

class PlatiUsluguScreen extends StatefulWidget {
  final Product? product;

  PlatiUsluguScreen({this.product, Key? key}) : super(key: key);

  @override
  _PlatiUsluguScreenState createState() => _PlatiUsluguScreenState();
}

class _PlatiUsluguScreenState extends State<PlatiUsluguScreen> {
  Map<String, dynamic>? paymentIntent;
  bool isCheckboxChecked = false;
  TextEditingController brojZiroracunaController = TextEditingController();
  UslugeProvider _uslugeProvider = UslugeProvider();
  String imePrezime1 = "${Authorization.ime} ${Authorization.prezime}";

  get http => null;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {});
    _uslugeProvider = context.read<UslugeProvider>();
  }

  @override
  Widget build(BuildContext context) {
    final paymentController = Get.put(PaymentController());
    return MasterScreenWidget(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: ElevatedButton(
                  onPressed: () {
                    if (widget.product != null) {
                      String cijenaString =
                          widget.product!.cijena!.toInt().toString();
                      paymentController.makePayment(
                          amount: cijenaString, currency: 'BAM');
                      Usluge request = Usluge(
                        imePrezime: imePrezime1,
                        datum: DateTime.now(),
                        brojRacuna: Authorization.brojRacuna ?? '',
                        nazivPaketa: widget.product?.nazivProizvoda,
                        cijena: cijenaString,
                        proizvodId: widget.product?.proizvodId,
                      );
                      _uslugeProvider.insert(request);
                    }
                  },
                  child: Text("Make Payment")),
            )
          ],
        ),
      ),
    );
  }
}
