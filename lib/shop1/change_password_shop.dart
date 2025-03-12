import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class change_password_shop extends StatelessWidget {
  final String shopId;
  const change_password_shop({super.key, required this.shopId});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Change Password'),
          backgroundColor: Colors.green,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: BackgroundImage(shopId: shopId),
      ),
    );
  }
}

class BackgroundImage extends StatefulWidget {
  final String shopId;
  const BackgroundImage({super.key, required this.shopId});

  @override
  _BackgroundImageState createState() => _BackgroundImageState();
}

class _BackgroundImageState extends State<BackgroundImage> {
  final TextEditingController _currenPasswordController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  Future<void> _saveToFirestore() async {
    String currentPassword = _currenPasswordController.text;
    String newPassword = _passwordController.text;
    String confirmPassword = _confirmPasswordController.text;

    if (newPassword != confirmPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('New password and confirm password do not match!')),
      );
      return;
    }

    try {
      // Query the 'shops' collection to find a document where 'shopId' matches the provided shopId
      QuerySnapshot shopQuerySnapshot = await FirebaseFirestore.instance
          .collection('shops')
          .where('shopId', isEqualTo: widget.shopId) // Match the 'shopId' field
          .get();

      if (shopQuerySnapshot.docs.isNotEmpty) {
        // If the shop is found
        DocumentSnapshot shopDoc = shopQuerySnapshot.docs.first;
        Map<String, dynamic> shopData = shopDoc.data() as Map<String, dynamic>;

        // Check if the current password entered matches the one in Firestore
        if (shopData['password'] == currentPassword) {
          // Update the password field in Firestore
          await FirebaseFirestore.instance.collection('shops').doc(shopDoc.id).update({
            'password': newPassword, // Set new password
          });

          // Clear all input fields
          _currenPasswordController.clear();
          _passwordController.clear();
          _confirmPasswordController.clear();

          // Show success message
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Password updated successfully!')),
          );
        } else {
          // Show error if current password doesn't match
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Current password is incorrect.')),
          );
        }
      } else {
        // If no document with the matching shopId is found
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Shop not found.')),
        );
      }
    } catch (e) {
      // Handle any errors such as network issues
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("images/shop_registration.png"),
          fit: BoxFit.fill,
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 300,
              child: _buildTextField("Current Password", _currenPasswordController),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: 300,
              child: _buildTextField("New Password", _passwordController),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: 300,
              child: _buildTextField("Confirm Password", _confirmPasswordController),
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: 250,
              child: ElevatedButton(
                onPressed: _saveToFirestore,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                ),
                child: const Text(
                  "Change",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String hintText, TextEditingController controller) {
    return TextField(
      controller: controller,
      obscureText: hintText.toLowerCase().contains("password"), // Hide text for password fields
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(color: Colors.black),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
