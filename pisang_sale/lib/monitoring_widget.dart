import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class SensorWidget extends StatefulWidget {
  @override
  _SensorWidgetState createState() => _SensorWidgetState();
}

class _SensorWidgetState extends State<SensorWidget> {
  final databaseRef = FirebaseDatabase.instance.ref();

  Map<String, dynamic> sensorData = {
    "Asap": 0,
    "Suhu": 0,
    "Tingkat Kematangan": 0,
    "Warna B": 0,
    "Warna G": 0,
    "Warna R": 0,
  };

  @override
  void initState() {
    super.initState();
    databaseRef.child('sensor').onValue.listen((event) {
      setState(() {
        sensorData = event.snapshot.value as Map<String, dynamic>;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildSensorItem('Asap', Icons.air, sensorData['Asap']),
            _buildSensorItem('Suhu', Icons.whatshot, sensorData['Suhu']),
            _buildSensorItem('Tingkat Kematangan', Icons.fastfood,
                sensorData['Tingkat Kematangan']),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildSensorItem('Warna B', Icons.color_lens, sensorData['Warna B']),
            _buildSensorItem('Warna G', Icons.color_lens, sensorData['Warna G']),
            _buildSensorItem('Warna R', Icons.color_lens, sensorData['Warna R']),
          ],
        ),
      ],
    );
  }

  Widget _buildSensorItem(String title, IconData icon, dynamic value) {
    return Column(
      children: [
        Icon(icon, size: 32),
        SizedBox(height: 8),
        Text(
          title,
          style: TextStyle(fontSize: 16),
        ),
        SizedBox(height: 8),
        Text(
          value.toString(),
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}