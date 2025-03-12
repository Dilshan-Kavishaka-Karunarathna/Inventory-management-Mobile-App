// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_application_2/shop1/shop_stock_editing.dart';
import 'stock_coccola.dart';
import 'stock_sprite.dart';
import 'stock_fanta.dart';
import 'stock_portello.dart';

// ignore: camel_case_types
class shop_yourstock_view extends StatelessWidget {
  final String shopId;
  final String title;
  const shop_yourstock_view({super.key, required this.shopId, required this.title});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
        title: const Text('Shop Stock View'),
        backgroundColor: const Color.fromARGB(217, 7, 240, 85),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
        body: BackgroundImage(shopId: shopId, title: title),
      ),
    );
  }
}

class BackgroundImage extends StatelessWidget {
  final String shopId;
  final String title;
  const BackgroundImage({super.key, required this.shopId, required this.title});

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
          // Coca-Cola button
          Align(
            alignment: const Alignment(-0.8, -0.10),
            child: TextButton(
              style: TextButton.styleFrom(
                textStyle: const TextStyle(fontSize: 35),
                foregroundColor: Colors.black, // Text color
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => stock_coccola(
                      shopId: shopId,
                      title: title , // Pass the shopId + title to stock_coccola
                    ),
                  ),
                );
              },
              child: const Text('Coca-cola'),
            ),
          ),
          // Fanta button
          Align(
            alignment: const Alignment(0.6, -0.10),
            child: TextButton(
              style: TextButton.styleFrom(
                textStyle: const TextStyle(fontSize: 35),
                foregroundColor: Colors.black, // Text color
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => stock_fanta(
                      shopId: shopId,
                      title: title, // Pass the shopId + title to stock_fanta
                    ),
                  ),
                );
              },
              child: const Text('Fanta'),
            ),
          ),
          // Sprite button
          Align(
            alignment: const Alignment(-0.65, 0.55),
            child: TextButton(
              style: TextButton.styleFrom(
                textStyle: const TextStyle(fontSize: 35),
                foregroundColor: Colors.black, // Text color
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => stock_sprite(
                      shopId: shopId,
                      title: title, // Pass the shopId + title to stock_sprite
                    ),
                  ),
                );
              },
              child: const Text('Sprite'),
            ),
          ),
          // Portello button
          Align(
            alignment: const Alignment(0.7, 0.55),
            child: TextButton(
              style: TextButton.styleFrom(
                textStyle: const TextStyle(fontSize: 35),
                foregroundColor: Colors.black, // Text color
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => stock_portello(
                      shopId: shopId,
                      title: title , // Pass the shopId + title to stock_portello
                    ),
                  ),
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
