import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../colombo_salesrep/salesrep_yourstock_view.dart';

class salesrep_stock_from_shop extends StatefulWidget {
  final String shopId;

  const salesrep_stock_from_shop({super.key, required this.shopId});

  @override
  _SalesRepStockFromShopState createState() => _SalesRepStockFromShopState();
}

class _SalesRepStockFromShopState extends State<salesrep_stock_from_shop> {
  @override
  void initState() {
    super.initState();
    fetchAndNavigate();
  }

  Future<void> fetchAndNavigate() async {
    try {
      // Access Firestore collection
      FirebaseFirestore firestore = FirebaseFirestore.instance;

      // Query to find the document with matching shopId
      var snapshot = await firestore
          .collection('shops')
          .where('shopId', isEqualTo: widget.shopId)
          .get();

      if (snapshot.docs.isNotEmpty) {
        // Extract salesRepId from the first document
        var salesRepId = snapshot.docs.first.data()['salesRepId'];

        // Navigate to salesrep_yourstock_view with salesRepId
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => salesrep_yourstock_view(salesRepId: salesRepId, title: '', ),
          ),
        );
      } else {
        // Handle the case where no matching shopId is found
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('No shop found with the given shopId')),
        );
      }
    } catch (e) {
      // Handle errors
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Fetching SalesRepId...')),
      body: Center(
        child: CircularProgressIndicator(), // Loading indicator while fetching data
      ),
    );
  }
}
