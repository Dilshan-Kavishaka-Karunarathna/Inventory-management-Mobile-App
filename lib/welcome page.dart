// ignore_for_file: file_names

import 'package:flutter/material.dart';
//import 'logScreen.dart'; // Importing the log screen where you want to navigate
import 'main_position.dart'; // Importing the main position page

void main() {
  runApp(const WelcomeScreen());
}

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: BackgroundImage(),
      ),
    );
  }
}

class BackgroundImage extends StatelessWidget {
  const BackgroundImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("images/Welcome.jpg"),
          fit: BoxFit.fill, // Ensure the background image fills the entire screen
        ),
      ),
      child: Stack(
        children: [
          // Get Start button using DecoratedBox
          Align(
            alignment: const Alignment(0.0, 0.6), // Position the DecoratedBox button
            child: GestureDetector(
              onTap: () {
                // Navigate to the main position screen when the button is pressed
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Position()), // Navigate to the main position widget
                );
              },
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: const Color(0xFFE38C5A), // Updated button background color
                  borderRadius: BorderRadius.circular(30), // Increased radius for more rounded corners
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 5,
                      offset: const Offset(2, 2),
                    ),
                  ],
                ),
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 40),
                  child: Text(
                    'Get Start',
                    style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.bold, // Makes the text bold
                      fontStyle: FontStyle.italic, // Makes the text italic
                      color: Colors.black, // Text color
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
