import 'package:flutter/material.dart';
import '../shop1/logScreen.dart';

void main() {
  runApp(const salesrep_stock_view());
}

// ignore: camel_case_types
class salesrep_stock_view extends StatelessWidget {
  const salesrep_stock_view({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
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
          image: AssetImage("images/salesrep_stock_view.png"),
          fit: BoxFit.fill, // Change from BoxFit.cover to BoxFit.fill for better fit
        ),
      ),
      child: Stack(
        children: [
          Align(
            alignment: const Alignment(-0.8, -0.15), // Example value to position the button
            child: TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Colors.black, // Text color
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const LogApp())
                );
              },
              child: RichText(
                text: const TextSpan(
                  text: 'Coca-colattt',
                  style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.bold, // Make text bold
                    color: Colors.black, // Ensure the color is black
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: const Alignment(0.6, -0.15), // Example value to position the button
            child: TextButton(
              style: TextButton.styleFrom(
                textStyle: const TextStyle(fontSize: 35),
                foregroundColor: Colors.black, // Text color
              ),
              onPressed: () {
                // Add your onPressed code here
              },
              child: const Text('Fanta'),
            ),
          ),
          Align(
            alignment: const Alignment(-0.65, 0.46), // Example value to position the button
            child: TextButton(
              style: TextButton.styleFrom(
                textStyle: const TextStyle(fontSize: 35),
                foregroundColor: Colors.black, // Text color
              ),
              onPressed: () {
                // Add your onPressed code here
              },
              child: const Text('Sprite'),
            ),
          ),

          Align(
            alignment: const Alignment(0.7, 0.46), // Example value to position the button
            child: TextButton(
              style: TextButton.styleFrom(
                textStyle: const TextStyle(fontSize: 35),
                foregroundColor: Colors.black, // Text color
              ),
              onPressed: () {
                // Add your onPressed code here
              },
              child: const Text('Portello'),
            ),
          ),
        ],
      ),
    );
  }
}
