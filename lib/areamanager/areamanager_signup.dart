import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'areamanager_login.dart';

void main() {
  runApp(const AreaManagerSignup());
}

class AreaManagerSignup extends StatelessWidget {
  const AreaManagerSignup({super.key});

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
  _BackgroundImageState createState() => _BackgroundImageState();
}

class _BackgroundImageState extends State<BackgroundImage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _nicController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _provinceController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  // Function to handle the signup process
  Future<void> _signup() async {
    final name = _nameController.text.trim();
    final id = _idController.text.trim();
    final address = _addressController.text.trim();
    final nic = _nicController.text.trim();
    final phone = _phoneController.text.trim();
    final province = _provinceController.text.trim();
    final password = _passwordController.text.trim();
    final confirmPassword = _confirmPasswordController.text.trim();

    // Validate fields
    if (name.isEmpty || id.isEmpty || address.isEmpty || nic.isEmpty || phone.isEmpty || province.isEmpty || password.isEmpty || confirmPassword.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Please fill all the fields")));
      return;
    }

    if (password != confirmPassword) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Passwords do not match")));
      return;
    }

    try {
      // Create user with Firebase Authentication
      final UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: '$id@company.com', // Use the Area Manager ID as the email
        password: password,
      );

      // Save the Area Manager details to Firestore
      final user = userCredential.user;
      if (user != null) {
        await FirebaseFirestore.instance.collection('area_managers').doc(user.uid).set({
          'name': name,
          'id': id,
          'address': address,
          'nic': nic,
          'phone': phone,
          'province': province,
          'password':password,
        });

        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Area Manager created successfully")));
        
        // Navigate to login screen after successful signup
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const AreaManagerLogin()),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Signup failed: ${e.toString()}")));
    }
  }

  @override
  Widget build(BuildContext context) {
    const textFieldWidth = 320.0;
    const double signupButtonHeight = 50.0;

    return SingleChildScrollView(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/areamanager_signup.png"), // Use the appropriate image path
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              top: MediaQuery.of(context).size.height * 0.20,
              left: MediaQuery.of(context).size.width * 0.5 - textFieldWidth / 2,
              child: SizedBox(
                width: textFieldWidth,
                child: TextField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    hintText: 'Area Manager Name',
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
            Positioned(
              top: MediaQuery.of(context).size.height * 0.29,
              left: MediaQuery.of(context).size.width * 0.5 - textFieldWidth / 2,
              child: SizedBox(
                width: textFieldWidth,
                child: TextField(
                  controller: _idController,
                  decoration: InputDecoration(
                    hintText: 'Area Manager ID',
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
            Positioned(
              top: MediaQuery.of(context).size.height * 0.38,
              left: MediaQuery.of(context).size.width * 0.5 - textFieldWidth / 2,
              child: SizedBox(
                width: textFieldWidth,
                child: TextField(
                  controller: _addressController,
                  decoration: InputDecoration(
                    hintText: 'Area Manager Address',
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
            Positioned(
              top: MediaQuery.of(context).size.height * 0.47,
              left: MediaQuery.of(context).size.width * 0.5 - textFieldWidth / 2,
              child: SizedBox(
                width: textFieldWidth,
                child: TextField(
                  controller: _nicController,
                  decoration: InputDecoration(
                    hintText: 'Area Manager NIC',
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
            Positioned(
              top: MediaQuery.of(context).size.height * 0.56,
              left: MediaQuery.of(context).size.width * 0.5 - textFieldWidth / 2,
              child: SizedBox(
                width: textFieldWidth,
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
            Positioned(
              top: MediaQuery.of(context).size.height * 0.65,
              left: MediaQuery.of(context).size.width * 0.5 - textFieldWidth / 2,
              child: SizedBox(
                width: textFieldWidth,
                child: TextField(
                  controller: _provinceController,
                  decoration: InputDecoration(
                    hintText: 'Province',
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
            Positioned(
              top: MediaQuery.of(context).size.height * 0.74,
              left: MediaQuery.of(context).size.width * 0.5 - textFieldWidth / 2,
              child: SizedBox(
                width: textFieldWidth,
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
            Positioned(
              top: MediaQuery.of(context).size.height * 0.83,
              left: MediaQuery.of(context).size.width * 0.5 - textFieldWidth / 2,
              child: SizedBox(
                width: textFieldWidth,
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
            Positioned(
              top: MediaQuery.of(context).size.height * 0.92,
              left: MediaQuery.of(context).size.width * 0.5 - textFieldWidth / 2,
              child: SizedBox(
                width: textFieldWidth,
                height: signupButtonHeight,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all<Color>(Colors.black),
                    shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                  onPressed: _signup,
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

