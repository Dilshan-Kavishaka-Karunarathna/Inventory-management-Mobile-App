//import 'package:fk/salesrep_from%20shop_ifc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
//import 'shop_signup.dart';
// ignore: unused_import
import '../colombo_salesrep/salesrep_from shop_ifc.dart';
import 'Shop your stoke View.dart';
import 'shop_ifc.dart';
import '/Shop your stoke View.dart';


class shop_stock_editing extends StatelessWidget {
  final String shopId;
  const shop_stock_editing({super.key, required this.shopId});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar:AppBar(
          title: const Text('Shop Stock View'),
          backgroundColor: const Color.fromARGB(255, 86, 215, 16),
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
  final TextEditingController _productIdController = TextEditingController();
  final TextEditingController _productNameController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();

  final TextEditingController _requestProductIdController =TextEditingController();
  final TextEditingController _requestProductNameController =TextEditingController();
  final TextEditingController _requestQuantityController =TextEditingController();

  void _addDataToFirestore() async {
    final String productId = _productIdController.text.trim();
    final String productName = _productNameController.text.trim();
    final String quantity = _quantityController.text.trim();

    if (productId.isEmpty || productName.isEmpty || quantity.isEmpty) {
      // Show error if fields are empty
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('All fields are required!')),
      );
      return;
    }

    try {
      // Reference Firestore collection based on shopId
      final collectionRef = FirebaseFirestore.instance.collection(widget.shopId);

      // Add a new document with an auto-generated ID
      await collectionRef.add({
        'product_id': productId,
        'product_name': productName,
        'quantity': int.tryParse(quantity) ?? 0,
        'timestamp': FieldValue.serverTimestamp(),
      });

      // Clear fields and show success message
      _productIdController.clear();
      _productNameController.clear();
      _quantityController.clear();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('$productName added successfully!')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to add data: $e')),
      );
    }
  }

    void _requestProduct() async {
    final String requestProductId = _requestProductIdController.text.trim();
    final String requestProductName =_requestProductNameController.text.trim();
    final String requestQuantity = _requestQuantityController.text.trim();

      if (requestProductId.isEmpty || requestProductName.isEmpty || requestQuantity.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('All fields are required!')),
      );
      return;
    }

    try {
      final collectionName = "${widget.shopId} request products";
      final collectionRef =
          FirebaseFirestore.instance.collection(collectionName);

      await collectionRef.add({
        'request_product_id': requestProductId,
        'request_product_name': requestProductName,
        'request_quantity': int.tryParse(requestQuantity) ?? 0,
        'timestamp': FieldValue.serverTimestamp(),
      });


       _requestProductIdController.clear();
      _requestProductNameController.clear();
      _requestQuantityController.clear();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('$requestProductName requested successfully!')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to request product: $e')),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
const double textFieldWidth = 320.0; 
const double buttonWidth = 120.0; 
const double buttonHeight = 50.0; 
const double secondButtonWidth = 120.0; 
const double secondButtonHeight = 50.0; 
const double newButtonWidth = 170.0; // Width for the new button const double newButtonHeight = 50.0
const double newButtonHeight=50.0;

    return SingleChildScrollView(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/shop_stock_edit.png"),
            fit: BoxFit.cover,
          ),
        ),

        child: Stack(
          children: [
            Positioned(
              top: MediaQuery.of(context).size.height * 0.14,
              left: MediaQuery.of(context).size.width * 0.5 - textFieldWidth / 2,
              child: SizedBox(
                width: textFieldWidth,
                child: TextField(
                  controller: _productIdController,
                  decoration: InputDecoration(
                    hintText: 'Product ID',
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
              top: MediaQuery.of(context).size.height * 0.24,
              left: MediaQuery.of(context).size.width * 0.5 - textFieldWidth / 2,
              child: SizedBox(
                width: textFieldWidth,
                child: TextField(
                  controller: _productNameController,
                  decoration: InputDecoration(
                    hintText: 'Product Name',
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
              top: MediaQuery.of(context).size.height * 0.34,
              left: MediaQuery.of(context).size.width * 0.5 - textFieldWidth / 2,
              child: SizedBox(
                width: textFieldWidth,
                child: TextField(
                  controller:_quantityController,
                  decoration: InputDecoration(
                    hintText: 'Quantity',
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
              top: MediaQuery.of(context).size.height * 0.34 + 70.0,
              left: MediaQuery.of(context).size.width * 0.25 - buttonWidth / 2,
              child: SizedBox(
                width: buttonWidth,
                height: buttonHeight,
                child: ElevatedButton(
                  onPressed: _addDataToFirestore,
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all<Color>(Colors.black),
                    shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                 
                  child: const Text('Enter Data', style: TextStyle(color: Colors.white)),
                ),
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.34 + 70.0,
              left: MediaQuery.of(context).size.width * 0.58 + buttonWidth / 2 - secondButtonWidth / 2,
              child: SizedBox(
                width: secondButtonWidth,
                height: secondButtonHeight,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all<Color>(Colors.black),
                    shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => shop_yourstock_view(shopId: widget.shopId, title:'',)),
                    );
                  },
                  child: const Text('View', style: TextStyle(color: Colors.white)),
                ),
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.56,
              left: MediaQuery.of(context).size.width * 0.5 - textFieldWidth / 2,
              child: SizedBox(
                width: textFieldWidth,
                child: TextField(
                  controller: _requestProductIdController,
              
                  decoration: InputDecoration(
                    hintText: 'Request Product ID',
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
              top: MediaQuery.of(context).size.height * 0.66,
              left: MediaQuery.of(context).size.width * 0.5 - textFieldWidth / 2,
              child: SizedBox(
                width: textFieldWidth,
                child: TextField(
                  controller: _requestProductNameController,
                  decoration: InputDecoration(
                    hintText: 'Request Product Name',
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
              top: MediaQuery.of(context).size.height * 0.76,
              left: MediaQuery.of(context).size.width * 0.5 - textFieldWidth / 2,
              child: SizedBox(
                width: textFieldWidth,
                child: TextField(
                  controller: _requestQuantityController,
                  decoration: InputDecoration(
                    hintText: 'Request Quantity',
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
              top: MediaQuery.of(context).size.height * 0.76 + 70.0,
              left: MediaQuery.of(context).size.width * 0.5 - newButtonWidth / 2,
              child: SizedBox(
                width: newButtonWidth,
                height: newButtonHeight,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all<Color>(Colors.black),
                    shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                  onPressed:_requestProduct,
                  child: const Text('Request Product', style: TextStyle(color: Colors.white)),
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
