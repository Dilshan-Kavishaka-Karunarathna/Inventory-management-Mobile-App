// ignore_for_file: file_names
import 'package:flutter/material.dart';

import 'company_cocacola.dart';
import 'company_fanta.dart';
import 'company_portello.dart';
import 'company_sprite.dart';





// ignore: camel_case_types
class company_yourstock_view extends StatelessWidget {
  
 
  const company_yourstock_view({super.key,});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
         appBar:AppBar(
          title: const Text('Company Stocks'),
          backgroundColor: Colors.green,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: BackgroundImage(),
      ),
    );
  }
}

class BackgroundImage extends StatelessWidget {
  
  const BackgroundImage({super.key,});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("images/Shop your stoke View.png"),
          fit: BoxFit.fill, // Change from BoxFit.cover to BoxFit.fill for better fit
        ),
      ),
      child: Stack(
        children: [
          Align(
            alignment: const Alignment(-0.8, -0.15), // Example value to position the button
            child: TextButton(
              style: TextButton.styleFrom(
                textStyle: const TextStyle(fontSize: 35),
                foregroundColor: Colors.black, // Text color
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>  const company_coccola())
                );
              },
              child: const Text('Coca-cola'),
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
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const company_fanta())
                );
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
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>const company_sprite())
                );
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
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const company_portello())
                );
              },
              child: const Text('Portello'),
            ),
          ),
        ],
      ),
    );
  }
}
