import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_tts/flutter_tts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final cameras = await availableCameras();
  final firstCamera = cameras.first;

  runApp(MaterialApp(
    home: ASLSignLanguageTranslator(camera: firstCamera),
    debugShowCheckedModeBanner: false,
  ));
}

class ASLSignLanguageTranslator extends StatefulWidget {
  final CameraDescription camera;

  ASLSignLanguageTranslator({required this.camera});

  @override
  _ASLSignLanguageTranslatorState createState() =>
      _ASLSignLanguageTranslatorState();
}

class _ASLSignLanguageTranslatorState extends State<ASLSignLanguageTranslator> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;
  String _prediction = '';
  String _lastSpokenPrediction = ''; // Track the last spoken prediction
  Timer? _timer;
  final FlutterTts _flutterTts = FlutterTts();

  @override
  void initState() {
    super.initState();
    _controller = CameraController(
      widget.camera,
      ResolutionPreset.high,
    );
    _initializeControllerFuture = _controller.initialize().then((_) {
      // Start the timer for real-time prediction
      _startPredictionTimer();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _timer?.cancel();
    super.dispose();
  }

  void _startPredictionTimer() {
    const interval = Duration(seconds: 1); // Adjust the interval as needed
    _timer = Timer.periodic(interval, (timer) async {
      await _captureAndPredict();
    });
  }

  Future<void> _captureAndPredict() async {
    try {
      if (!_controller.value.isInitialized) {
        return;
      }

      // If the camera is not taking a picture
      if (_controller.value.isTakingPicture) {
        return;
      }

      final image = await _controller.takePicture();
      final prediction = await _predictImage(File(image.path));
      setState(() {
        _prediction = prediction;
      });

      // Convert prediction to speech only if it's different from the last spoken prediction
      if (_prediction.isNotEmpty &&
          _prediction != 'No prediction' &&
          _prediction != _lastSpokenPrediction) {
        await _speakPrediction(_prediction);
        _lastSpokenPrediction =
            _prediction; // Update the last spoken prediction
      }
    } catch (e) {
      print(e);
    }
  }

  Future<String> _predictImage(File imageFile) async {
    final apiKey = 'Gwru7IA64wnYwtdLTeMI'; // Replace with your Roboflow API key
    final modelId = 'american-sign-language-letters/6';
    final apiUrl = 'https://detect.roboflow.com/$modelId';

    final request =
        http.MultipartRequest('POST', Uri.parse('$apiUrl?api_key=$apiKey'));
    request.files
        .add(await http.MultipartFile.fromPath('file', imageFile.path));

    final response = await request.send();

    if (response.statusCode == 200) {
      final responseData = await response.stream.bytesToString();
      final json = jsonDecode(responseData);
      final predictions = json['predictions'];

      if (predictions.isNotEmpty) {
        return predictions[0]['class'];
      } else {
        return 'No prediction';
      }
    } else {
      return 'Error: ${response.reasonPhrase}';
    }
  }

  Future<void> _speakPrediction(String prediction) async {
    await _flutterTts.setLanguage('en-US');
    await _flutterTts.setPitch(1.0);
    await _flutterTts.speak(prediction);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          Color(0xffb52727), // Background color to match your design
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Column(
              children: [
                SizedBox(height: 15), // Top padding
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Image.asset(
                    'assets/logonobg.png', // Replace with your logo asset path
                    height: 90,
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: CameraPreview(_controller),
                ),
                Spacer(),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Text(
                    _prediction.isNotEmpty ? _prediction : "Output Text",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  color: Color(0xffBB0032),
                  height: 80,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      IconButton(
                        icon: Icon(Icons.home, color: Colors.white, size: 30),
                        onPressed: () {
                          Navigator.pushNamed(context, "/home");
                        },
                      ),
                      Container(
                        color: Colors.grey.withOpacity(0.7),
                        child: IconButton(
                          icon: Icon(Icons.camera_alt,
                              color: Colors.white, size: 30),
                          onPressed: () {
                            Navigator.pushNamed(context, "/asl");
                          },
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.book, color: Colors.white, size: 30),
                        onPressed: () {
                          Navigator.pushNamed(context, "/library");
                        },
                      ),
                      IconButton(
                        icon:
                            Icon(Icons.settings, color: Colors.white, size: 30),
                        onPressed: () {
                          Navigator.pushNamed(context, "/setting");
                        },
                      ),
                    ],
                  ),
                ),
              ],
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
