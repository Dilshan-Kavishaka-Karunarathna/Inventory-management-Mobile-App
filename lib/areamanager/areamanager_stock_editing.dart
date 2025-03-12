import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'areamanager_yourstock_view.dart';



class areamanager_stock_editing extends StatelessWidget {
  final String userId;
  const areamanager_stock_editing({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Stock Editing'),
          backgroundColor: Colors.blue,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: BackgroundImage(userId: userId),
      ),
    );
  }
}

class BackgroundImage extends StatefulWidget {
  final String userId;
  const BackgroundImage({super.key, required this.userId});

  @override
  _BackgroundImageState createState() => _BackgroundImageState();
}

class _BackgroundImageState extends State<BackgroundImage> {
  final TextEditingController _productIdController = TextEditingController();
  final TextEditingController _productNameController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();

  final TextEditingController _requestProductIdController = TextEditingController();
  final TextEditingController _requestProductNameController = TextEditingController();
  final TextEditingController _requestQuantityController = TextEditingController();

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
      final collectionRef = FirebaseFirestore.instance.collection(widget.userId);

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

    void _addRequestToFirestore() async {
    final String requestProductId = _requestProductIdController.text.trim();
    final String requestProductName = _requestProductNameController.text.trim();
    final String requestQuantity = _requestQuantityController.text.trim();

      if (requestProductId.isEmpty || requestProductName.isEmpty || requestQuantity.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('All fields are required!')),
      );
      return;
    }

    final String collectionName = '${widget.userId} request_products';

    try {
      // Reference the specific collection
      final collectionRef = FirebaseFirestore.instance.collection(collectionName);

      // Add a new document with an auto-generated ID
      await collectionRef.add({
        'product_id': requestProductId,
        'product_name': requestProductName,
        'quantity': int.tryParse(requestQuantity) ?? 0,
        'timestamp': FieldValue.serverTimestamp(),
      });

      // Clear fields and show success message
      _requestProductIdController.clear();
      _requestProductNameController.clear();
      _requestQuantityController.clear();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('$requestProductName request sent successfully!')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to send request: $e')),
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
                      MaterialPageRoute(builder: (context) => areamanager_yourstock_view(userId: widget.userId,)),
                    );
                  },
                  child: const Text('View', style: TextStyle(color: Colors.white)),
                ),
              ),
            ),

            // Request Product ID field
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

            // Request Product Name field
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

            // Request Quantity field
            Positioned(
              top: MediaQuery.of(context).size.height * 0.76,
              left: MediaQuery.of(context).size.width * 0.5 - textFieldWidth / 2,
              child: SizedBox(
                width: textFieldWidth,
                child: TextField(
                   controller:  _requestQuantityController,
                 
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

            // Request Product button
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
                  // Call the new function
                  onPressed: _addRequestToFirestore,
                  child: const Text('Request Product ', style: TextStyle(color: Colors.white)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
