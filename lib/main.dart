//Real Time
import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final cameras = await availableCameras();
  final firstCamera = cameras.first;

  runApp(MaterialApp(
    home: ASLSignLanguageTranslator(camera: firstCamera),
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
  Timer? _timer;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("ASL Sign Language Translator")),
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Stack(
              children: [
                CameraPreview(_controller),
                Positioned(
                  bottom: 50,
                  left: 20,
                  child: Container(
                    padding: EdgeInsets.all(10),
                    color: Colors.black54,
                    child: Text(
                      _prediction,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                      ),
                    ),
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





//With Button
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:camera/camera.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   final cameras = await availableCameras();
//   final firstCamera = cameras.first;

//   runApp(MaterialApp(
//     home: ASLSignLanguageTranslator(camera: firstCamera),
//   ));
// }

// class ASLSignLanguageTranslator extends StatefulWidget {
//   final CameraDescription camera;

//   ASLSignLanguageTranslator({required this.camera});

//   @override
//   _ASLSignLanguageTranslatorState createState() =>
//       _ASLSignLanguageTranslatorState();
// }

// class _ASLSignLanguageTranslatorState extends State<ASLSignLanguageTranslator> {
//   late CameraController _controller;
//   late Future<void> _initializeControllerFuture;
//   String _prediction = '';

//   @override
//   void initState() {
//     super.initState();
//     _controller = CameraController(
//       widget.camera,
//       ResolutionPreset.high,
//     );
//     _initializeControllerFuture = _controller.initialize();
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   Future<void> _captureAndPredict() async {
//     try {
//       await _initializeControllerFuture;
//       final image = await _controller.takePicture();

//       final prediction = await _predictImage(File(image.path));
//       setState(() {
//         _prediction = prediction;
//       });
//     } catch (e) {
//       print(e);
//     }
//   }

//   Future<String> _predictImage(File imageFile) async {
//     final apiKey = 'Gwru7IA64wnYwtdLTeMI'; // Replace with your Roboflow API key
//     final modelId = 'american-sign-language-letters/6';
//     final apiUrl = 'https://detect.roboflow.com/$modelId';

//     final request =
//         http.MultipartRequest('POST', Uri.parse('$apiUrl?api_key=$apiKey'));
//     request.files
//         .add(await http.MultipartFile.fromPath('file', imageFile.path));

//     final response = await request.send();

//     if (response.statusCode == 200) {
//       final responseData = await response.stream.bytesToString();
//       final json = jsonDecode(responseData);
//       final predictions = json['predictions'];

//       if (predictions.isNotEmpty) {
//         return predictions[0]['class'];
//       } else {
//         return 'No prediction';
//       }
//     } else {
//       return 'Error: ${response.reasonPhrase}';
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("ASL Sign Language Translator")),
//       body: FutureBuilder<void>(
//         future: _initializeControllerFuture,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.done) {
//             return Stack(
//               children: [
//                 CameraPreview(_controller),
//                 Positioned(
//                   bottom: 50,
//                   left: 20,
//                   child: Container(
//                     padding: EdgeInsets.all(10),
//                     color: Colors.black54,
//                     child: Text(
//                       _prediction,
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 24,
//                       ),
//                     ),
//                   ),
//                 ),
//                 Positioned(
//                   bottom: 50,
//                   right: 20,
//                   child: FloatingActionButton(
//                     onPressed: _captureAndPredict,
//                     child: Icon(Icons.camera),
//                   ),
//                 ),
//               ],
//             );
//           } else {
//             return Center(child: CircularProgressIndicator());
//           }
//         },
//       ),
//     );
//   }
// }
