import 'package:flutter/material.dart';
import './screens/product_list_screen.dart';

void main() {
  runApp(const MyMaterialApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MyMaterialApp(),
    );
  }
}
class MyAppBar extends StatelessWidget {
  String title;
  MyAppBar({Key? key,required this.title}) :super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(title);
  }
}


class Counter extends StatefulWidget {
  const Counter({super.key});

  @override
  State<Counter> createState() => _CounterState();
}

class _CounterState extends State<Counter> {
int _count=0;
void _incrementCounter(){
    setState(() 
  {    
    _count++;
  });  
}

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('You have pusheddd $_count times'),
        ElevatedButton(onPressed: _incrementCounter, child:Text("Bakir Hasic"))
      ],
    );
  }
}

class LayoutExample extends StatelessWidget {
  const LayoutExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 150,
          color: Colors.red,
            child:Center(
              child: Container(
              height: 100,
              color: Colors.blue,
              child: Text("Exampe text"),
              alignment: Alignment.bottomLeft,
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text("Item 1"),
            Text("Item 1"),
            Text("Item 1"),
          ],
        ),
        Container(
          height: 150,
          color: Colors.red,
          child: Text("Contain"),
          alignment: Alignment.center,
        )
      ],
    );
  }
}

class MyMaterialApp extends StatelessWidget {
  const MyMaterialApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title:'RS II Material app',
      theme: ThemeData(primarySwatch: Colors.red),
      home: LoginPage(),
      );
  }
}

class LoginPage extends StatelessWidget {
 LoginPage({super.key});

TextEditingController _usernameController= new TextEditingController();
TextEditingController _passwordController= new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: Center(
        child: Container(
        constraints: BoxConstraints(maxWidth: 400,maxHeight: 400),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0), 
              child: Column(children: [
              //Image.network("https://www.fit.ba/content/public/images/og-image.jpg",height: 100,width: 100,),
              Image.asset("assets/images/og-image.jpg",height: 100,width: 100,),
              TextField(
                decoration: InputDecoration(
                  labelText: "Username",
                  prefixIcon: Icon(Icons.email)
                ),
                controller: _usernameController,
              ),
              SizedBox(height: 8,),
              TextField(
                decoration: InputDecoration(
                  labelText: "Password",
                  prefixIcon: Icon(Icons.password)
                ),
                controller: _passwordController,
              ),
              SizedBox(height: 8,),
              ElevatedButton(onPressed: (){
                var username = _usernameController.text;
                var password = _passwordController.value;
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>
                    const ProductListScreen()
                    ),
                  );
                }, child:Text("Login"))
              ]),
            ),
          ),
        ),
      ),
    );
  }
}