import 'package:flutter/material.dart';
import 'package:maps_app_actualizado/markers/markers.dart';

class TestMarkerScreen extends StatelessWidget {
  const TestMarkerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          color: Colors.red,
          width: 350,
          height: 150,
          child: CustomPaint(
              painter: StartMarkerPainter(destination: 'Mi casa', minutes: 10)),
        ),
      ),
    );
  }
}