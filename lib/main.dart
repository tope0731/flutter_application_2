import 'package:flutter/material.dart';
import 'package:flutter_application_2/speechToText.dart';
import 'package:flutter_application_2/spt.dart';

void main() {
  WidgetsFlutterBinding();
  runApp(sttmain());
}

class sttmain extends StatelessWidget {
  const sttmain({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SpeechText(),
      debugShowCheckedModeBanner: false,
    );
  }
}
