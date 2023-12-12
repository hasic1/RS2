import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:jamfix_admin/screens/product_list_screen.dart';
import 'package:jamfix_admin/widgets/master_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  State<HomeScreen> createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    // Vaše komponente ili ekrani za svaki tab
    // Primjer:
    Container(color: Colors.white, child: Center(child: Text('Tab 1'))),
    Container(color: Colors.white, child: Center(child: Text('Tab 2'))),
    Container(color: Colors.white, child: Center(child: Text('Tab 3'))),
    Container(color: Colors.white, child: Center(child: Text('Tab 4'))),
    Container(color: Colors.white, child: Center(child: Text('Tab 5'))),
  ];

  @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(48), // Prilagodite visinu po potrebi
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildNavItem(0, Icons.home, 'Pocetna'),
                  _buildNavItem(1, Icons.book, 'Ponuda'),
                  _buildNavItem(2, Icons.school, 'Novosti'),
                  _buildNavItem(3, Icons.shopping_cart, 'Korpa'),
                  _buildNavItem(4, Icons.info_outline, 'O nama'),
                ],
              ),
            ),
          ),
        ),
        body: _pages[_currentIndex],
      ),
    );
  }

 Widget _buildNavItem(int index, IconData icon, String label) {
    return InkWell(
      onTap: () {
        setState(() {
          _currentIndex = index;
        });

        // Dodano: Otvori novu stranicu na temelju odabranog taba
        switch (index) {
          case 0:
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomeScreen()),
            );
            break;
          case 1:
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ProductListScreen()),
            );
            break;
          // Dodajte slične case za ostale tabove
        }
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: _currentIndex == index ? Colors.blue : Colors.grey),
          Text(
            label,
            style: TextStyle(
              color: _currentIndex == index ? Colors.blue : Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
