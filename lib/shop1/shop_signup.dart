import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'logScreen.dart'; // Ensure this file exists and is implemented correctly.

void main() {
  runApp(const ShopSignup());
}

// Class for shop signup page
class ShopSignup extends StatelessWidget {
  const ShopSignup({super.key});

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

// BackgroundImage widget with signup functionality
class BackgroundImage extends StatefulWidget {
  const BackgroundImage({super.key});

  @override
  State<BackgroundImage> createState() => _BackgroundImageState();
}

class _BackgroundImageState extends State<BackgroundImage> {
  // Controllers for form inputs
  final TextEditingController _shopNameController = TextEditingController();
  final TextEditingController _shopIdController = TextEditingController();
  final TextEditingController _shopOwnerController = TextEditingController();
  final TextEditingController _shopAddressController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _districtController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  // Sign-up function
  Future<void> _signUp() async {
    final shopName = _shopNameController.text.trim();
    final shopId = _shopIdController.text.trim();
    final shopOwner = _shopOwnerController.text.trim();
    final shopAddress = _shopAddressController.text.trim();
    final phone = _phoneController.text.trim();
    final district = _districtController.text.trim();
    final password = _passwordController.text.trim();
    final confirmPassword = _confirmPasswordController.text.trim();

    // Validate inputs
    if (shopName.isEmpty ||
        shopId.isEmpty ||
        shopOwner.isEmpty ||
        shopAddress.isEmpty ||
        phone.isEmpty ||
        district.isEmpty ||
        password.isEmpty ||
        confirmPassword.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill all fields.")),
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
      // Sign up user with Firebase Authentication
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: "$shopId@shopapp.com", // Using shop ID as email
        password: password,
      );

      // Store additional user data in Firestore
      await FirebaseFirestore.instance.collection('shops').doc(userCredential.user!.uid).set({
        'shopName': shopName,
        'shopId': shopId,
        'shopOwner': shopOwner,
        'shopAddress': shopAddress,
        'phone': phone,
        'district': district,
        'password':password,
      });

      // Navigate to LogApp screen after successful signup
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const LogApp()),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
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
            image: AssetImage("images/shop_signup.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            // Input fields for shop details
            _buildTextField(context, 0.13, textFieldWidth, 'Shop Name', _shopNameController),
            _buildTextField(context, 0.22, textFieldWidth, 'Shop ID', _shopIdController),
            _buildTextField(context, 0.31, textFieldWidth, 'Shop Owner Name', _shopOwnerController),
            _buildTextField(context, 0.40, textFieldWidth, 'Shop Address', _shopAddressController),
            _buildTextField(context, 0.49, textFieldWidth, 'Phone Number', _phoneController),
            _buildTextField(context, 0.58, textFieldWidth, 'District', _districtController),
            _buildTextField(context, 0.67, textFieldWidth, 'Create Password', _passwordController, obscureText: true),
            _buildTextField(context, 0.76, textFieldWidth, 'Confirm Password', _confirmPasswordController, obscureText: true),

            // Signup button
            Positioned(
              top: MediaQuery.of(context).size.height * 0.86,
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
                  onPressed: _signUp,
                  child: const Text('Signup', style: TextStyle(color: Colors.white)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Positioned _buildTextField(
    BuildContext context,
    double topPercentage,
    double width,
    String hintText,
    TextEditingController controller, {
    bool obscureText = false,
  }) {
    return Positioned(
      top: MediaQuery.of(context).size.height * topPercentage,
      left: MediaQuery.of(context).size.width * 0.5 - width / 2,
      child: SizedBox(
        width: width,
        child: TextField(
          controller: controller,
          obscureText: obscureText,
          decoration: InputDecoration(
            hintText: hintText,
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          style: const TextStyle(color: Colors.black),
        ),
      ),
    );
  }
}
