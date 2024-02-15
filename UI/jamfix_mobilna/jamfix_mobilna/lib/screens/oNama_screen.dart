import 'package:flutter/material.dart';
import 'package:jamfix_mobilna/widgets/master_screen.dart';

class ONamaScreen extends StatefulWidget {
  const ONamaScreen({Key? key}) : super(key: key);

  @override
  State<ONamaScreen> createState() => _ONamaScreen();
}

class _ONamaScreen extends State<ONamaScreen> {
  @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: Image.asset(
                    "assets/images/Jamfix.jpg",
                    height: 150,
                    width: 150,
                  ),
                ),
                SizedBox(height: 10),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "O našoj aplikaciji:",
                    style:
                        TextStyle(fontSize: 30, fontWeight: FontWeight.normal),
                  ),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Row(
                    children: [
                      Expanded(
                        child: const Text(
                          '-Ljudi uvijek teže ka boljoj poziciji u bilo kojoj situaciji,\n'
                          '   naravno ako je u pitanju čekanje ne žele biti zapostavljeni,\n'
                          '   te žele da dođu na red u sto kraćem roku.\n'
                          '-Kada dođe do pucanja konekcije ili do nestanka TV programa,\n'
                          '   tada nastaje panika kod korisnika.\n'
                          '-Upravo ovdje, na ovaj problem kao rješenje se javlja aplikacija „JamFix“.\n'
                          '-Ova aplikacija omogućava korisnicima da iznesu svoj problem bez ikakvog čekanja,\n'
                          '   te do najsitnijeg detalja opišu isti.',
                          style: TextStyle(
                            fontSize: 18,
                            fontStyle: FontStyle.normal,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: Image.asset(
                          "assets/images/aboutus.jpg",
                          height: 250,
                          width: 450,
                        ),
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: Text(
                    "Ciljevi aplikacije",
                    style:
                        TextStyle(fontSize: 30, fontWeight: FontWeight.normal),
                    textAlign: TextAlign.left,
                  ),
                ),
                SizedBox(height: 10),
                Align(
                  child: Row(
                    children: [
                      Expanded(
                        child: Image.asset(
                          "assets/images/goals.jpg",
                          height: 250,
                          width: 450,
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          '- Poboljšati usluge koje se pružaju korisnicima koji koriste Internet,\n'
                          '  kanale i telefone, te firme koje koriste naše usluge.\n'
                          '- Ubrzati proces rješavanja problema u bilo koje doba dana.\n'
                          '- Dostupnost svih ponuda u svakom trenutku.\n'
                          '- Kreiranje novih paketa za korisnike.\n'
                          '- Evidencija korisnika.\n'
                          '- Lakše vođenje bilješki radnog naloga.\n'
                          '- Stvoriti bolju interakciju sa korisnicima naših usluga.\n',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.normal,
                          ),
                          textAlign: TextAlign.right,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 60),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
