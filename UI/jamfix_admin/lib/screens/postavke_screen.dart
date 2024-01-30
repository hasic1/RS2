import 'package:flutter/material.dart';
import 'package:jamfix_admin/models/drzava.dart';
import 'package:jamfix_admin/models/korisnici.dart';
import 'package:jamfix_admin/models/search_result.dart';
import 'package:jamfix_admin/providers/drzava_provider.dart';
import 'package:jamfix_admin/providers/korisnici_provider.dart';
import 'package:jamfix_admin/utils/util.dart';
import 'package:jamfix_admin/widgets/master_screen.dart';
import 'package:provider/provider.dart';

class PostavkeScreen extends StatefulWidget {
  @override
  _PostavkeScreen createState() => _PostavkeScreen();
}

class _PostavkeScreen extends State<PostavkeScreen> {
  TextEditingController _imeController = TextEditingController();
  TextEditingController _prezimeController = TextEditingController();
  TextEditingController _noviPasswordController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _telefonController = TextEditingController();
  TextEditingController _passwordPotvrdaController = TextEditingController();
  KorisniciProvider _korisniciProvider = KorisniciProvider();
  DrzavaProvider _drzavaProvider = DrzavaProvider();
  SearchResult<Drzava>? drzavaResult;

  String? selectedDrzavaId;

  @override
  void initState() {
    super.initState();
    _drzavaProvider = context.read<DrzavaProvider>();
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(Authorization.rola!),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Ime: ${Authorization.ime}',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 40.0),
                        Text(
                          'Prezime: ${Authorization.prezime}',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 40.0),
                        Text(
                          'Email: ${Authorization.email}',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 40.0),
                        Text(
                          'Telefon: ${Authorization.telefon}',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 40.0),
                        Text(
                          'Username: ${Authorization.korisnickoIme}',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextFormField(
                            controller: _imeController,
                            decoration: InputDecoration(labelText: 'Ime'),
                          ),
                          const SizedBox(height: 8.0),
                          TextFormField(
                            controller: _prezimeController,
                            decoration: InputDecoration(labelText: 'Prezime'),
                          ),
                          const SizedBox(height: 8.0),
                          TextFormField(
                            controller: _emailController,
                            decoration: InputDecoration(labelText: 'Email'),
                          ),
                          const SizedBox(height: 8.0),
                          TextFormField(
                            controller: _telefonController,
                            decoration: InputDecoration(labelText: 'Telefon'),
                          ),
                          const SizedBox(height: 8.0),
                          TextFormField(
                            controller: _noviPasswordController,
                            decoration:
                                InputDecoration(labelText: 'Novi password'),
                          ),
                          const SizedBox(height: 8.0),
                          TextFormField(
                            controller: _passwordPotvrdaController,
                            decoration:
                                InputDecoration(labelText: 'Password potvrda'),
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
                                drzavaResult =
                                    snapshot.data as SearchResult<Drzava>?;
                                selectedDrzavaId = (drzavaResult
                                        ?.result.first.drzavaId
                                        .toString()) ??
                                    null;

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
                                                  (item) =>
                                                      DropdownMenuItem<String>(
                                                    value: item.drzavaId
                                                        .toString(),
                                                    child:
                                                        Text(item.naziv ?? ""),
                                                  ),
                                                )
                                                .toList()) ??
                                            [],
                                      ),
                                    ),
                                  ],
                                );
                              }
                            },
                          ),
                          SizedBox(height: 16),
                          Align(
                            alignment: Alignment.centerRight,
                            child: ElevatedButton(
                              onPressed: () async {
                                var request = Korisnici(
                                  ime: _imeController.text,
                                  prezime: _prezimeController.text,
                                  telefon: _telefonController.text,
                                  email: _emailController.text,
                                  drzavaId: int.parse(selectedDrzavaId!),
                                );
                                try {
                                  _korisniciProvider.update(
                                      Authorization.id, request);
                                  Navigator.pop(context);
                                } on Exception catch (e) {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        AlertDialog(
                                      title: const Text("Error"),
                                      content: Text(e.toString()),
                                      actions: [
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.pop(context),
                                          child: const Text("OK"),
                                        ),
                                      ],
                                    ),
                                  );
                                }
                              },
                              child: Text('Ažuriraj podatke'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
