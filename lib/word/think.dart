import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: ThinkPage(),
  ));
}

class ThinkPage extends StatefulWidget {
  @override
  _ThinkPageState createState() => _ThinkPageState();
}

class _ThinkPageState extends State<ThinkPage> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset('assets/words/think.mp4')
      ..initialize().then((_) {
        setState(() {}); // Update the UI when the video is loaded
        _controller.play(); // Auto-play the video
        _controller.setLooping(true);
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffFF004A), // Red background color
      appBar: AppBar(
        backgroundColor: Color(0xffFF004A),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pushNamed(context, "/word");
          },
        ),
        title: Image.asset(
          'assets/logonobg.png', // Replace with your logo asset path
          height: 120,
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                SizedBox(height: 20),
                Container(
                  height: 300,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: _controller.value.isInitialized
                        ? AspectRatio(
                            aspectRatio: _controller.value.aspectRatio,
                            child: VideoPlayer(_controller),
                          )
                        : Center(
                            child: CircularProgressIndicator(),
                          ),
                  ),
                ),
                SizedBox(height: 20),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Description',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Think',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Spacer(),
          Container(
            color: Color(0xffBB0032),
            height: 100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  icon: Icon(Icons.home, color: Colors.white, size: 30),
                  onPressed: () {
                    Navigator.pushNamed(context, "/home");
                  },
                ),
                IconButton(
                  icon: Icon(Icons.camera_alt, color: Colors.white, size: 30),
                  onPressed: () {
                    Navigator.pushNamed(context, "/asl");
                  },
                ),
                Container(
                  color: Colors.grey.withOpacity(0.7),
                  child: IconButton(
                    icon: Icon(Icons.book, color: Colors.white, size: 30),
                    onPressed: () {
                      Navigator.pushNamed(context, "/library");
                    },
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.settings, color: Colors.white, size: 30),
                  onPressed: () {
                    Navigator.pushNamed(context, "/setting");
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
