// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'areamanager_portello.dart';
import 'areamanager_sprite.dart';
import 'areamanager_fanta.dart';
import 'areamanager_cocacola.dart';




// ignore: camel_case_types
class areamanager_yourstock_view extends StatelessWidget {
  final String userId;
 
  const areamanager_yourstock_view({super.key,required this.userId,});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Your Stock'),
          backgroundColor: Colors.green,
          leading:IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          )
        ),
        body: BackgroundImage(userId:userId),
      ),
    );
  }
}

class BackgroundImage extends StatelessWidget {
  final String userId;
  const BackgroundImage({super.key,required this.userId,});

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
                    MaterialPageRoute(builder: (context) =>  areamanager_cocacola(userId:userId))
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
                    MaterialPageRoute(builder: (context) => areamanager_fanta(userId: userId,))
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
                    MaterialPageRoute(builder: (context) =>areamanager_sprite(userId:userId,))
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
                    MaterialPageRoute(builder: (context) => areamanager_portello(userId:userId,))
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
