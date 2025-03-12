import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class shop_registration extends StatelessWidget {
  final String salesRepId;
  const shop_registration({super.key, required this.salesRepId});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Shop Registration'),
          backgroundColor: Colors.green,
          leading:IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          )
        ),
        body: BackgroundImage(salesRepId: salesRepId),
      ),
    );
  }
}

class BackgroundImage extends StatefulWidget {
  final String salesRepId;
  const BackgroundImage({super.key, required this.salesRepId});

  @override
  _BackgroundImageState createState() => _BackgroundImageState();
}

class _BackgroundImageState extends State<BackgroundImage> {
  final TextEditingController _salesRepIdController = TextEditingController();
  final TextEditingController _shopIdController = TextEditingController();
  final TextEditingController _shopNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _districtController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _salesRepIdController.text = widget.salesRepId; // Pre-fill salesRepId
  }

  Future<void> _saveToFirestore() async {
    String shopName = _shopNameController.text;

    if (shopName.isNotEmpty) {
      await FirebaseFirestore.instance.collection('shops').doc(shopName).set({
        'salesRepId': _salesRepIdController.text,
        'shopId': _shopIdController.text,
        'shopName': shopName,
        'password': _passwordController.text,
        'district': _districtController.text,
      });

      // Clear all input fields
      _salesRepIdController.clear();
      _shopIdController.clear();
      _shopNameController.clear();
      _passwordController.clear();
      _districtController.clear();

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Shop registered successfully!')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a shop name.')),
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
      child: SingleChildScrollView( // Wrap with SingleChildScrollView
  child: Padding(
    padding: const EdgeInsets.only(top: 150), // Add top padding
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 300,
          child: _buildTextField("salesRepId", _salesRepIdController),
        ),
        const SizedBox(height: 20),
        SizedBox(
          width: 300,
          child: _buildTextField("shopId", _shopIdController),
        ),
        const SizedBox(height: 20),
        SizedBox(
          width: 300,
          child: _buildTextField("shopName", _shopNameController),
        ),
        const SizedBox(height: 20),
        SizedBox(
          width: 300,
          child: _buildTextField("password", _passwordController),
        ),
        const SizedBox(height: 20),
        SizedBox(
          width: 300,
          child: _buildTextField("district", _districtController),
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
              "Submit",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ],
    ),
  ),
),

    );
  }

  Widget _buildTextField(String hintText, TextEditingController controller) {
    return TextField(
      controller: controller,
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
