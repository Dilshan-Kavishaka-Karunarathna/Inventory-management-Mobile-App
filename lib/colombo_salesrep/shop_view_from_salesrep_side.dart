import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../shop1/Shop your stoke View.dart'; // Import your stock view page

class shop_view_from_salesrep_side extends StatelessWidget {
  final String salesRepId;
  const shop_view_from_salesrep_side({super.key, required this.salesRepId});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Remove debug banner
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Shops List'),
          backgroundColor: Colors.blue,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/Sales_repview_Shop _stoke.png'), // Set background image
              fit: BoxFit.cover,
            ),
          ),
          child: Center( // Center the ListView on the screen
            child: ShopListView(salesRepId: salesRepId),
          ),
        ),
      ),
    );
  }
}

class ShopListView extends StatelessWidget {
  final String salesRepId;
  const ShopListView({super.key, required this.salesRepId});

  Stream<List<Map<String, dynamic>>> fetchShopNames() {
    return FirebaseFirestore.instance
        .collection('shops')
        .where('salesRepId', isEqualTo: salesRepId) // Filter by salesRepId
        .snapshots()
        .map((querySnapshot) => querySnapshot.docs
            .map((doc) {
              final data = doc.data();
              return {
                'shopId': data['shopId'], // Extract shopId from the document data
                'shopName': data['shopName'], // Extract shopName
              };
            })
            .toList());
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Map<String, dynamic>>>(  
      stream: fetchShopNames(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.hasData) {
          final shopList = snapshot.data!;
          if (shopList.isEmpty) {
            return const Center(
              child: Text(
                'No shops found.',
                style: TextStyle(color: Colors.white), // Text color for readability
              ),
            );
          }
          return ListView.builder(
            shrinkWrap: true, // Ensures ListView takes up only necessary space
            padding: const EdgeInsets.symmetric(vertical: 10), // Add padding for spacing
            itemCount: shopList.length,
            itemBuilder: (context, index) {
              final shop = shopList[index];
              return Card(
                color: Colors.white.withOpacity(0.9), // Semi-transparent background
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: ListTile(
                  title: Text(
                    shop['shopName'] ?? 'Unnamed Shop',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => shop_yourstock_view(
                          shopId: shop['shopId'],
                          title: '',
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          );
        } else {
          return const Center(
            child: Text(
              'No data available.',
              style: TextStyle(color: Colors.white), // Text color for readability
            ),
          );
        }
      },
    );
  }
}
