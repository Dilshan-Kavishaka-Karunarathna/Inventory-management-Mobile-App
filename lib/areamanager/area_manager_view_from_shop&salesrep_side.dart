import 'package:flutter/material.dart';
//are_manager_view_from_shopand_salesrep_side
import 'package:flutter_application_2/areamanager/areamanager_cocacola.dart';
import 'package:flutter_application_2/areamanager/areamanager_fanta.dart';
import 'package:flutter_application_2/areamanager/areamanager_portello.dart';
import 'package:flutter_application_2/areamanager/areamanager_sprite.dart';

void main() {
  runApp(const are_manager_view_from_shopand_salesrep_side());
}

// ignore: camel_case_types
class are_manager_view_from_shopand_salesrep_side extends StatelessWidget {
  const are_manager_view_from_shopand_salesrep_side({super.key});

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
    return Stack(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("images/area_manager_stock_view_from_shop_andsalesrep.png"),
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
                              builder: (context) => const areamanager_cocacola(userId: '',),
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
                          fontSize: 20, // Increased font size
                          fontWeight: FontWeight.bold, // Made text bold
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
                              builder: (context) => const areamanager_fanta(userId: '',),
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
                          fontSize: 20, // Increased font size
                          fontWeight: FontWeight.bold, // Made text bold
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
                              builder: (context) => const areamanager_portello(userId: '',),
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
                          fontSize: 20, // Increased font size
                          fontWeight: FontWeight.bold, // Made text bold
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
                              builder: (context) => const areamanager_portello(userId: '',),
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
                          fontSize: 20, // Increased font size
                          fontWeight: FontWeight.bold, // Made text bold
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
        color: Colors.white, // White background color
        border: Border.all(color: Colors.white, width: 2),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3), // Shadow color
            spreadRadius: 2, // How much the shadow spreads
            blurRadius: 5, // How blurry the shadow is
            offset: Offset(0, 4), // Horizontal and vertical offset of the shadow
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.asset(
          imagePath,
          fit: BoxFit.contain, // Scales the image proportionally to fit within the box.
        ),
      ),
    );
  }
}
