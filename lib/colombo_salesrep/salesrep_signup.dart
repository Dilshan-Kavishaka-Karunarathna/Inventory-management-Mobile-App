import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'Sales rep login.dart';

void main() {
  runApp(const SalesRepSignup());
}

class SalesRepSignup extends StatelessWidget {
  const SalesRepSignup({super.key});

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
  // Text controllers for all the fields
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _salesRepIdController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _nicController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _districtController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  // Function to handle signup
  Future<void> _signup() async {
    final name = _nameController.text.trim();
    final salesRepId = _salesRepIdController.text.trim();
    final address = _addressController.text.trim();
    final nic = _nicController.text.trim();
    final phone = _phoneController.text.trim();
    final district = _districtController.text.trim();
    final password = _passwordController.text.trim();
    final confirmPassword = _confirmPasswordController.text.trim();

    // Validate inputs
    if (name.isEmpty || salesRepId.isEmpty || address.isEmpty || nic.isEmpty || phone.isEmpty || district.isEmpty || password.isEmpty || confirmPassword.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill in all fields.")),
      );
      return;
    }

    if (password != confirmPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Passwords do not match.")),
      );
      return;
    }

    try {
      // Create a new user in Firebase Auth (for email and password authentication)
      final UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: '$salesRepId@company.com', // Use the salesRepId as the email
        password: password,
      );

      // Get the user UID
      final userId = userCredential.user?.uid;

      // Save the sales rep data to Firestore
      await FirebaseFirestore.instance.collection('salesreps').doc(userId).set({
        'name': name,
        'salesRepId': salesRepId,
        'address': address,
        'nic': nic,
        'phone': phone,
        'district': district,
        'email': '$salesRepId@company.com', // Same email as used in FirebaseAuth
        'password':password,
      });

      // After successfully saving to Firestore, navigate to the login screen
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const LoginSalesRep()),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: ${e.toString()}")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    const textFieldWidth = 320.0;
    //const double loginButtonHeight = 50.0;

    return SingleChildScrollView(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/salesrep_signup.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            // Sales Rep Name
            Positioned(
              top: MediaQuery.of(context).size.height * 0.19 + 10,
              left: MediaQuery.of(context).size.width * 0.5 - textFieldWidth / 2,
              child: SizedBox(
                width: textFieldWidth,
                height: 50,
                child: TextField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    hintText: 'Sales Rep Name',
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
            // Sales Rep ID
            Positioned(
              top: MediaQuery.of(context).size.height * 0.28 + 5,
              left: MediaQuery.of(context).size.width * 0.5 - textFieldWidth / 2,
              child: SizedBox(
                width: textFieldWidth,
                height: 50,
                child: TextField(
                  controller: _salesRepIdController,
                  decoration: InputDecoration(
                    hintText: 'Sales Rep ID',
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
            // Sales Rep Address
            Positioned(
              top: MediaQuery.of(context).size.height * 0.37,
              left: MediaQuery.of(context).size.width * 0.5 - textFieldWidth / 2,
              child: SizedBox(
                width: textFieldWidth,
                height: 50,
                child: TextField(
                  controller: _addressController,
                  decoration: InputDecoration(
                    hintText: 'Sales Rep Address',
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
            // Sales Rep NIC
            Positioned(
              top: MediaQuery.of(context).size.height * 0.45,
              left: MediaQuery.of(context).size.width * 0.5 - textFieldWidth / 2,
              child: SizedBox(
                width: textFieldWidth,
                height: 50,
                child: TextField(
                  controller: _nicController,
                  decoration: InputDecoration(
                    hintText: 'Sales Rep NIC',
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
            // Phone Number
            Positioned(
              top: MediaQuery.of(context).size.height * 0.54,
              left: MediaQuery.of(context).size.width * 0.5 - textFieldWidth / 2,
              child: SizedBox(
                width: textFieldWidth,
                height: 50,
                child: TextField(
                  controller: _phoneController,
                  decoration: InputDecoration(
                    hintText: 'Phone Number',
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
            // District
            Positioned(
              top: MediaQuery.of(context).size.height * 0.62,
              left: MediaQuery.of(context).size.width * 0.5 - textFieldWidth / 2,
              child: SizedBox(
                width: textFieldWidth,
                height: 50,
                child: TextField(
                  controller: _districtController,
                  decoration: InputDecoration(
                    hintText: 'District',
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
            // Create Password
            Positioned(
              top: MediaQuery.of(context).size.height * 0.71,
              left: MediaQuery.of(context).size.width * 0.5 - textFieldWidth / 2,
              child: SizedBox(
                width: textFieldWidth,
                height: 50,
                child: TextField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    hintText: 'Create Password',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  obscureText: true,
                  style: const TextStyle(color: Colors.black),
                ),
              ),
            ),
            // Confirm Password
            Positioned(
              top: MediaQuery.of(context).size.height * 0.79,
              left: MediaQuery.of(context).size.width * 0.5 - textFieldWidth / 2,
              child: SizedBox(
                width: textFieldWidth,
                height: 50,
                child: TextField(
                  controller: _confirmPasswordController,
                  decoration: InputDecoration(
                    hintText: 'Confirm Password',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  obscureText: true,
                  style: const TextStyle(color: Colors.black),
                ),
              ),
            ),
            // Create Account Button
            Positioned(
              top: MediaQuery.of(context).size.height * 0.87 - 2,
              left: MediaQuery.of(context).size.width * 0.5 - textFieldWidth / 2,
              child: SizedBox(
                width: textFieldWidth,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  onPressed: _signup, // Call the signup method
                  child: const Text('Create', style: TextStyle(color: Colors.white)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
