import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_2/shop1/change_password_shop.dart';
import 'shop_signup.dart';
import 'shop_ifc.dart';
import 'shop_stock_editing.dart';
//import 'shop_ifc1.dart';




class LogApp extends StatelessWidget {
  const LogApp({super.key});

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

class BackgroundImage extends StatefulWidget {
  const BackgroundImage({super.key});

  @override
  State<BackgroundImage> createState() => _BackgroundImageState();
}

class _BackgroundImageState extends State<BackgroundImage> {
  final TextEditingController _shopIdController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _login() async {
    final shopId = _shopIdController.text.trim();
    final password = _passwordController.text.trim();

    if (shopId.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter both Shop ID and Password.")),
      );
      return;
    }

    try {
      // Fetch shop data from Firestore
      final shopDoc = await FirebaseFirestore.instance
          .collection('shops')
          .where('shopId', isEqualTo: shopId)
          .get();

      if (shopDoc.docs.isNotEmpty) {
        final shopData = shopDoc.docs.first.data();

        if (shopData['password'] == password) {
          final shopId = shopData['shopId']; // Get the interface type

         if (shopId == shopData['shopId']) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ShopInterface(shopId: shopId,)),
            );
        /*  } else if (shopId == 'SH02') {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ShopInterface1()),
            );
          } else if (shopId == 'SH03') {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ShopInterface2()),
            );

          }else if (shopId == 'SH04') {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ShopInterface4()),
            );
          } else if (shopId == 'SH05') {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ShopInterface5()),
            );
          } else if (shopId == 'SH06') {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ShopInterface6()),
            );*/

          }else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Invalid interface type.")),
            );
          }
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Invalid password.")),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Shop ID not found.")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    const double textFieldWidth = 320.0;
    const double loginButtonHeight = 50.0;

    return SingleChildScrollView(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/login_shop.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            // Shop ID input field
            Positioned(
              top: MediaQuery.of(context).size.height * 0.25,
              left: MediaQuery.of(context).size.width * 0.5 - textFieldWidth / 2,
              child: SizedBox(
                width: textFieldWidth,
                child: TextField(
                  controller: _shopIdController,
                  decoration: InputDecoration(
                    hintText: 'Shop ID',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  style: const TextStyle(color: Colors.black),
                ),
              ),
            ),

            // Password input field
            Positioned(
              top: MediaQuery.of(context).size.height * 0.35,
              left: MediaQuery.of(context).size.width * 0.5 - textFieldWidth / 2,
              child: SizedBox(
                width: textFieldWidth,
                child: TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: 'Password',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  style: const TextStyle(color: Colors.black),
                ),
              ),
            ),

            // Login button
            Positioned(
              top: MediaQuery.of(context).size.height * 0.45,
              left: MediaQuery.of(context).size.width * 0.5 - textFieldWidth / 2,
              child: SizedBox(
                width: textFieldWidth,
                height: loginButtonHeight,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  onPressed: _login,
                  child: const Text('Login', style: TextStyle(color: Colors.white)),
                ),
              ),
            ),
            
          ],
        ),
      ),
    );
  }
}
