import 'areamanager/areamanager_login.dart';
import 'package:flutter/material.dart';
import 'shop1/logScreen.dart';
import 'colombo_salesrep/Sales rep login.dart';



class Position extends StatelessWidget {
  const Position({super.key});

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
          image: AssetImage("images/position.png"),
          fit: BoxFit.fill, // Change from BoxFit.cover to BoxFit.fill for better fit
        ),
      ),
      child: Stack(
        children: [
          Align(
            alignment: const Alignment(0.0, -0.44), // Example value to position the button
            child: TextButton(
              style: TextButton.styleFrom(
                textStyle: const TextStyle(
                  fontSize: 35,
                  fontFamily: 'CustomFont',
                  fontWeight: FontWeight.bold, // Make text bold
                ),
                foregroundColor: Colors.black, // Text color
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const LogApp())
                );
              },
              child: const Text('Shop'),
            ),
          ),
          Align(
            alignment: const Alignment(0.0, 0.10), // Example value to position the button
            child: TextButton(
              style: TextButton.styleFrom(
                textStyle: const TextStyle(
                  fontSize: 35,
                  fontFamily: 'CustomFont',
                  fontWeight: FontWeight.bold, // Make text bold
                ),
                foregroundColor: Colors.black, // Text color
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginSalesRep())
                );
              },
              child: const Text('Sales Rep'),
            ),
          ),
          Align(
            alignment: const Alignment(0.0, 0.68), // Example value to position the button
            child: TextButton(
              style: TextButton.styleFrom(
                textStyle: const TextStyle(
                  fontSize: 35,
                  fontFamily: 'CustomFont',
                  fontWeight: FontWeight.bold, // Make text bold
                ),
                foregroundColor: Colors.black, // Text color
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const AreaManagerLogin())
                );
              },
              child: const Text('Area Manager'),
            ),
          ),
        ],
      ),
    );
  }
}
