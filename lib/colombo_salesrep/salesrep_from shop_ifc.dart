import 'package:flutter/material.dart';
import 'package:flutter_application_2/colombo_salesrep/salesrep_coccola.dart';
import 'package:flutter_application_2/colombo_salesrep/salesrep_sprite.dart';
import 'package:flutter_application_2/colombo_salesrep/salesrep_fanta.dart';
import 'package:flutter_application_2/colombo_salesrep/salesrep_portello.dart';

void main() {
  runApp(const SalesRepFromShopApp());
}

// ignore: camel_case_types
class SalesRepFromShopApp extends StatelessWidget {
  const SalesRepFromShopApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar:AppBar(
          title: const Text('Sales Rep'),
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
  const BackgroundImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("images/Sales Rep stock View.png"),
              fit: BoxFit.fill,
            ),
          ),
        ),
        Positioned(
          top: 160,
          left: 40,
          child: Column(
            children: [
              Row(
                children: [
                  Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>  Salesrep_Stock_Coccola(salesRepId: "cocacola123", title: '', ),
                            ),
                          );
                        },
                        child: CartWidget(imagePath: "images/1.png"),
                      ),
                      const SizedBox(height: 5),
                      const Text(
                        'CocaCola',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 50),
                  Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const salesrep_fanta(salesRepId: "fanta123", title: '',),
                            ),
                          );
                        },
                        child: CartWidget(imagePath: "images/fantabottle.png"),
                      ),
                      const SizedBox(height: 5),
                      const Text(
                        'Fanta',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const salesrep_portello(salesRepId: "portello123",title: '',),
                            ),
                          );
                        },
                        child: CartWidget(imagePath: "images/portellobottle.png"),
                      ),
                      const SizedBox(height: 5),
                      const Text(
                        'Portello',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 50),
                  Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const salesrep_sprite(salesRepId: "sprite123", title: '',),
                            ),
                          );
                        },
                        child: CartWidget(imagePath: "images/spritebottle.png"),
                      ),
                      const SizedBox(height: 5),
                      const Text(
                        'Sprite',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class CartWidget extends StatelessWidget {
  final String imagePath;

  const CartWidget({required this.imagePath, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 130,
      height: 130,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.white, width: 2),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.asset(
          imagePath,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
