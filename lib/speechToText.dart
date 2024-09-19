import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class SpeechText extends StatefulWidget {
  const SpeechText({super.key});

  @override
  State<SpeechText> createState() => _SpeechTextState();
}

class _SpeechTextState extends State<SpeechText> {
  stt.SpeechToText _speech = stt.SpeechToText();
  String _recognizedText = "";
  bool _isListening = false;

  @override
  void initState() {
    super.initState();
    initSpeechState();
  }

  void initSpeechState() async {
    bool available = await _speech.initialize();
    if (!mounted) return;
    // Speech service initialized but not setting _isListening here
  }

  void _startListening() {
    _speech.listen(onResult: (result) {
      if (result.recognizedWords == "a" || result.recognizedWords == "A") {
        print('The result is a');
        print(result.recognizedWords);

        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Letter Recognized"),
              content: Text("The recognized letter is 'A'."),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the dialog
                  },
                  child: Text("OK"),
                ),
              ],
            );
          },
        );
      } else {
        print('The result is not letter a');
        print(result.recognizedWords);
      }
      setState(() {
        _isListening = false;
      });
    });

    setState(() {
      _isListening = true;
    });
  }

  void _stopListening() {
    _speech.stop();
    setState(() {
      _isListening = false;
    });
    print('Stopped listening');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 10,
            child: Image.asset(
              'assets/a.png',
              height: 400,
              width: 400,
            ),
          ),
          Positioned(
            bottom: 10,
            right: 10,
            child: Center(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: _isListening ? null : _startListening,
                    icon: Icon(_isListening ? Icons.mic : Icons.mic_none),
                    iconSize: 100,
                    color: _isListening ? Colors.red : Colors.grey,
                  ),
                  IconButton(
                    onPressed: _isListening ? _stopListening : null,
                    icon: Icon(Icons.stop),
                    iconSize: 100,
                    color: Colors.grey,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
