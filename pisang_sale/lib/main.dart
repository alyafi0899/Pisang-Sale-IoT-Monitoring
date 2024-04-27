import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:pisang_sale/card.dart';
import 'package:pisang_sale/monitoring_widget.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 255, 208, 1)),
        useMaterial3: true,
      ),
      home: MyHomePage(title: 'Pisang Sale',)
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late DatabaseReference _databaseReference;

  @override
  void initState() {
    super.initState();
    _databaseReference = FirebaseDatabase.instance.ref().child('sensor');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body:Column(
        children: [
          Container(
            margin: EdgeInsets.all(20),
            child: Row(
              children: [
                Container(
                  height: 90,
                  child: Image.network(
                  'https://uxwing.com/wp-content/themes/uxwing/download/fruits-vegetables/banana-icon.png',
                  errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                    return Text('Error loading image: $exception');
                  },
                ),
                ),
                Container(alignment: Alignment.center, child: Text("Monitorig IoT Pisang Sale", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),),)
              ],
              
            ),
          ),
          StreamBuilder(
              stream: _databaseReference.onValue,
              builder: (context, snapshot) {
                if (snapshot.hasData && !snapshot.hasError && snapshot.data?.snapshot.value != null) {
                  Map data = snapshot.data?.snapshot.value as Map;
                  return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                              MyCard(
                                icon: Icons.hot_tub,
                                title: 'Asap',
                                value: '${data['Asap']}',
                                ),
                                MyCard(
                                icon: Icons.thermostat,
                                title: 'Suhu',
                                value: '${data['Suhu']}℃',
                                ),
                                MyCard(
                                icon: Icons.calendar_today,
                                title: 'Tingkat\nKematangan',
                                value: '${data['Tingkat Kematangan']}',
                                ),
                            ],
                          ),
                          Column(
                            children: [
                              MyCard(
                                icon: Icons.color_lens,
                                title: 'Warna R',
                                value: '${data['Warna B']}',
                                ),
                                MyCard(
                                icon: Icons.color_lens,
                                title: 'Warna G',
                                value: '${data['Warna B']}',
                                ),
                                MyCard(
                                icon: Icons.color_lens,
                                title: 'Warna B',
                                value: '${data['Warna B']}',
                                ),
                            ],
                          ),
                        ],
                    
                  );
                } else {
                  return CircularProgressIndicator();
                }
              },
            ),
        ],
      ),
    );
  }
}
