import 'package:flutter/material.dart';
import 'logScreen.dart';

void main() {
  runApp(const shopinterface());
}

// ignore: camel_case_types
class shopinterface extends StatelessWidget {
  const shopinterface({super.key});

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
    // ignore: non_constant_identifier_names, prefer_typing_uninitialized_variables
    var ImageButton;
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("images/shop_ifc.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: [
          Align(
            alignment: const Alignment(-0.8, -0.2), // Example value to position the button
            child: TextButton(
              style: TextButton.styleFrom(
                textStyle: const TextStyle(fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
                foregroundColor: Colors.black, // Text color
                // backgroundColor: Colors.blue, // Background color
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const LogApp())
                );
              },
              child: const Text('Your Stock'),
            ),
          ),

          Align(
            alignment: const Alignment(0.7, -0.17), // Example value to position the button
            child: TextButton(
              style: TextButton.styleFrom(
                  textStyle: const TextStyle(fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                  foregroundColor: Colors.black
                // Text color
                // backgroundColor: Colors.blue, // Background color
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const LogApp())
                );
              },
              child: const Text('Sales Rep\n    Stock'),
            ),
          ),

          Align(
            alignment: const Alignment(0.0, 0.55), // Example value to position the button
            child: TextButton(
              style: TextButton.styleFrom(
                textStyle: const TextStyle(fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
                foregroundColor: Colors.black, // Text color
                // backgroundColor: Colors.blue, // Background color
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const LogApp())
                );
              },
              child: const Text('Area Manager\n       Stock'),
            ),
          ),

          Align(
            alignment: const Alignment(-0.2, 0.87), // Example value to position the button
            child: TextButton(
              style: TextButton.styleFrom(
                textStyle: const TextStyle(fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
                foregroundColor: Colors.black,
                // Text color
                // backgroundColor: Colors.blue, // Background color
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const LogApp())
                );
              },
              child: const Text('Future status'),
            ),
          ),

          Align(
            alignment: const Alignment(-0.2, 0.87), // Example value to position the button
            child: TextButton(
              style: ImageButton.styleFrom(
                textStyle: const TextStyle(fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
                foregroundColor: Colors.black,
                // Text color
                // backgroundColor: Colors.blue, // Background color
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const LogApp())
                );
              },
              child: const Text('Future status'),
            ),
          ),



        ],
      ),
    );
  }
}
