import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_2/colombo_salesrep/salesrep_ifc.dart';
import 'salesrep_signup.dart';


void main() {
  runApp(const LoginSalesRep());
}

class LoginSalesRep extends StatelessWidget {
  const LoginSalesRep({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
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
  final TextEditingController _userIdController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Function to handle login
  Future<void> _login() async {
    final userId = _userIdController.text.trim();
    final password = _passwordController.text.trim();

    // Validate inputs
    if (userId.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter both User ID and Password.")),
      );
      return;
    }

    try {
      // Try to sign in with Firebase Authentication
      final UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: '$userId@company.com', // Use Sales Rep ID as the email
        password: password,
      );

      // Fetch user data from Firestore
      final docSnapshot = await FirebaseFirestore.instance
          .collection('salesreps')
          .doc(userCredential.user?.uid)
          .get();

      if (docSnapshot.exists) {
        final userData = docSnapshot.data();

        if (userData != null) {
          final salesRepId = userData['salesRepId']; // Get the interface type

          // Navigate to the appropriate interface based on the interfaceType
          if (salesRepId == userData['salesRepId']) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => salesrep_interface(salesRepId:salesRepId)),
            );
          }/* else if (salesRepId == 'SR2') {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) =>const salesrep2_interface()),
            );
          } else if (salesRepId == 'SR3') {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) =>const salesrep3_interface()),
            );
          } */else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Invalid interface type.")),
            );
          }
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Sales Rep not found in the system.")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Login failed: ${e.toString()}")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    const textFieldWidth = 320.0;
    const double loginButtonHeight = 50.0;

    return SingleChildScrollView(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/Sales rep login.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            // User ID field
            Positioned(
              top: MediaQuery.of(context).size.height * 0.25 + 50.0,
              left: MediaQuery.of(context).size.width * 0.5 - textFieldWidth / 2,
              child: SizedBox(
                width: textFieldWidth,
                child: TextField(
                  controller: _userIdController,
                  decoration: InputDecoration(
                    hintText: 'User ID',
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
            // Password field
            Positioned(
              top: MediaQuery.of(context).size.height * 0.24 + 130.0,
              left: MediaQuery.of(context).size.width * 0.5 - textFieldWidth / 2,
              child: SizedBox(
                width: textFieldWidth,
                child: TextField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    hintText: 'Enter Password',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  obscureText: true, // To hide the password text
                  style: const TextStyle(color: Colors.black),
                ),
              ),
            ),
            // Login button
            Positioned(
              top: MediaQuery.of(context).size.height * 0.24 + 210.0,
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
                  onPressed: _login, // Call the login method
                  child: const Text('Login', style: TextStyle(color: Colors.white)),
                ),
              ),
            ),
            // Button to create a new account
            Positioned(
              top: MediaQuery.of(context).size.height * 0.32 + 290.0,
              left: MediaQuery.of(context).size.width * 0.5 - textFieldWidth / 2,
              child: SizedBox(
                width: textFieldWidth,
                height: loginButtonHeight,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const SalesRepSignup()),
                    );
                  },
                  child: const Text('Create a new account', style: TextStyle(color: Colors.black)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
