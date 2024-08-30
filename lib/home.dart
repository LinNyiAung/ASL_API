import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          Color(0xffE8083E), // Background color to match your design
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 20), // Add spacing for top padding
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                    'assets/logonobg.png', // Replace with your logo asset path
                    height: 120,
                  ),
                  Icon(Icons.notifications, color: Colors.white),
                ],
              ),
            ),
            SizedBox(height: 20),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                children: [
                  Icon(Icons.lightbulb, color: Color(0xFFFFC107)),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'Try to learn at least 2 signs per day.',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                children: [
                  Text(
                    'Everyone deserves the opportunity to connect and communicate.',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20),
                  Image.asset(
                    'assets/Illustration.png', // Replace with your illustration asset path
                    height: 150,
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
                  Container(
                    color: Colors.grey.withOpacity(0.7),
                    child: IconButton(
                      icon: Icon(Icons.home, color: Colors.white, size: 30),
                      onPressed: () {
                        Navigator.pushNamed(context, "/home");
                      },
                    ),
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
      ),
    );
  }
}
