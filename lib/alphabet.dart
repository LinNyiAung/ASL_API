import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: AlphabetPage(),
    debugShowCheckedModeBanner: false,
  ));
}

class AlphabetPage extends StatelessWidget {
  final List<String> alphabet = [
    'A',
    'B',
    'C',
    'D',
    'E',
    'F',
    'G',
    'H',
    'I',
    'J',
    'K',
    'L',
    'M',
    'N',
    'O',
    'P',
    'Q',
    'R',
    'S',
    'T',
    'U',
    'V',
    'W',
    'X',
    'Y',
    'Z'
  ];

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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(
                  'assets/logonobg.png', // Replace with your logo asset path
                  height: 100,
                ),
                IconButton(
                  icon: Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () {
                    // Handle back button press
                    Navigator.pushNamed(context, "/library");
                  },
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4, // 4 columns
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  childAspectRatio: 1, // Square buttons
                ),
                itemCount: alphabet.length,
                itemBuilder: (context, index) {
                  return AlphabetButton(
                    letter: alphabet[index],
                    onPressed: () =>
                        onAlphabetPressed(context, alphabet[index]),
                  );
                },
              ),
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

  void onAlphabetPressed(BuildContext context, String letter) {
    switch (letter) {
      case 'A':
        // Perform action for 'A'
        Navigator.pushNamed(context, "/a");
        break;
      case 'B':
        // Perform action for 'B'
        Navigator.pushNamed(context, "/b");
        break;
      case 'C':
        // Perform action for 'C'
        Navigator.pushNamed(context, "/c");
        break;
      case 'D':
        // Perform action for 'D'
        Navigator.pushNamed(context, "/d");
        break;
      // Add similar cases for the rest of the alphabet
      case 'Z':
        // Perform action for 'Z'
        print('Z pressed');
        break;
      default:
        print('$letter pressed');
    }
  }
}

class AlphabetButton extends StatelessWidget {
  final String letter;
  final VoidCallback onPressed;

  AlphabetButton({required this.letter, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.all(10),
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      onPressed: onPressed,
      child: Text(
        letter,
        style: TextStyle(
          color: Colors.black,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
