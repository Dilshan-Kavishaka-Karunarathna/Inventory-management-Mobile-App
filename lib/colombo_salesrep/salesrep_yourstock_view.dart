// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'salesrep_stock_editing.dart';
import 'salesrep_coccola.dart';
import 'salesrep_sprite.dart';
import 'salesrep_fanta.dart';
import 'salesrep_portello.dart';

// ignore: camel_case_types
class salesrep_yourstock_view extends StatelessWidget {
  final String salesRepId;
  final String title;
  const salesrep_yourstock_view({super.key, required this.salesRepId, required this.title});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text(title), // Removed 'const' to fix the error
          backgroundColor: Colors.green,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: BackgroundImage(salesRepId: salesRepId, title: title),
      ),
    );
  }
}

class BackgroundImage extends StatelessWidget {
  final String salesRepId;
  final String title;
  const BackgroundImage({super.key, required this.salesRepId, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("images/Shop your stoke View.png"),
          fit: BoxFit.fill,
        ),
      ),
      child: Stack(
        children: [
          Align(
            alignment: const Alignment(-0.8, -0.15),
            child: TextButton(
              style: TextButton.styleFrom(
                textStyle: const TextStyle(fontSize: 35),
                foregroundColor: Colors.black,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Salesrep_Stock_Coccola(salesRepId: salesRepId, title:title,),
                  ),
                );
              },
              child: const Text('Coca-cola'),
            ),
          ),
          Align(
            alignment: const Alignment(0.6, -0.15),
            child: TextButton(
              style: TextButton.styleFrom(
                textStyle: const TextStyle(fontSize: 35),
                foregroundColor: Colors.black,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => salesrep_fanta(salesRepId: salesRepId, title:title,),
                  ),
                );
              },
              child: const Text('Fanta'),
            ),
          ),
          Align(
            alignment: const Alignment(-0.65, 0.46),
            child: TextButton(
              style: TextButton.styleFrom(
                textStyle: const TextStyle(fontSize: 35),
                foregroundColor: Colors.black,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => salesrep_sprite(salesRepId: salesRepId, title:title,),
                  ),
                );
              },
              child: const Text('Sprite'),
            ),
          ),
          Align(
            alignment: const Alignment(0.7, 0.46),
            child: TextButton(
              style: TextButton.styleFrom(
                textStyle: const TextStyle(fontSize: 35),
                foregroundColor: Colors.black,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => salesrep_portello(salesRepId: salesRepId,title:title),
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
