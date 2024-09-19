import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class home extends StatefulWidget {
  const home({super.key});

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  stt.SpeechToText _speech = stt.SpeechToText();
  String _recognizedText = "";
  bool _isListening = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initSpeechState();
  }

  void initSpeechState() async {
    bool available = await _speech.initialize();
    if (!mounted) return;
    // setState(() {
    //   _isListening = available;
    // });
  }

  void _startListening() {
    _speech.listen(onResult: (result) {
      if (result.recognizedWords == "a" || result.recognizedWords == "A") {
        print('The result is a');
      }
      else{
        
      }
      setState(() {
        _recognizedText = result.recognizedWords;
      });
    });
    setState(() {
      _isListening = true;
    });
  }

  void _copyText() {
    Clipboard.setData(ClipboardData(text: _recognizedText));
    _showSnackBar("Text Copied");
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      duration: Duration(seconds: 1),
    ));
  }

  @override
  Widget build(BuildContext context) {
    void _clearText() {
      print("naclear");
      setState(() {
        _recognizedText = "";
        _isListening = false;
      });
      print(_recognizedText);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              onPressed: _startListening,
              icon: Icon(_isListening ? Icons.mic : Icons.mic_none),
              iconSize: 100,
              color: _isListening ? Colors.red : Colors.grey,
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              height: MediaQuery.of(context).size.height / 4,
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.symmetric(horizontal: 30),
              decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black45,
                  ),
                  borderRadius: BorderRadius.circular(10)),
              child: Text(
                _recognizedText.isNotEmpty ? _recognizedText : 'Result here...',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 24),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: _recognizedText.isNotEmpty ? _copyText : null,
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(10)),
                    child: Text(
                      'Copy',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                GestureDetector(
                  onTap: _clearText,
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(10)),
                    child: Text(
                      'Clear',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
