import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: SettingsPage(),
    debugShowCheckedModeBanner: false,
  ));
}

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool isTextToSpeechEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          Color(0xffE8083E), // Background color to match your design
      body: Column(
        children: [
          SizedBox(height: 20), // Top padding
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Image.asset(
              'assets/logonobg.png', // Replace with your logo asset path
              height: 250,
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Text To Speech",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                    ),
                  ),
                  Switch(
                    value: isTextToSpeechEnabled,
                    onChanged: (value) {
                      setState(() {
                        isTextToSpeechEnabled = value;
                      });
                    },
                    activeColor: Colors.white,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 20),
          Expanded(
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 20),
              children: [
                SettingButton(
                  title: "Language",
                  onPressed: () {
                    // Action for "Language"
                    print("Language pressed");
                  },
                ),
                SettingButton(
                  title: "Terms and Conditions",
                  onPressed: () {
                    // Action for "Terms and Conditions"
                    print("Terms and Conditions pressed");
                  },
                ),
                SettingButton(
                  title: "About Us.",
                  onPressed: () {
                    // Action for "About Us."
                    print("About Us pressed");
                  },
                ),
              ],
            ),
          ),

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
                IconButton(
                  icon: Icon(Icons.book, color: Colors.white, size: 30),
                  onPressed: () {
                    Navigator.pushNamed(context, "/library");
                  },
                ),
                Container(
                  color: Colors.grey.withOpacity(0.7),
                  child: IconButton(
                    icon: Icon(Icons.settings, color: Colors.white, size: 30),
                    onPressed: () {
                      Navigator.pushNamed(context, "/setting");
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SettingButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;

  SettingButton({required this.title, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 15),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.all(15),
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        onPressed: onPressed,
        child: Text(
          title,
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}
