import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../shop1/Shop your stoke View.dart';

class Sales_rep_view_shop_requests extends StatelessWidget {
  final String salesRepId;
  const Sales_rep_view_shop_requests({super.key, required this.salesRepId});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Shop Requests'),
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

class BackgroundImage extends StatelessWidget {
  final String salesRepId;
  const BackgroundImage({super.key, required this.salesRepId});

  // Fetch shopid from Firestore documents (not the document id)
  Stream<List<Map<String, dynamic>>> fetchShopData() {
    return FirebaseFirestore.instance
        .collection('shops')
        .where('salesRepId', isEqualTo: salesRepId) // Filter by salesRepId
        .snapshots()
        .map((querySnapshot) => querySnapshot.docs.map((doc) {
              final data = doc.data();

              // Safely extract shopid and shopName with fallback values
              final shopid = data['shopId'] ?? ''; // Default to an empty string if null
              final shopName = data['shopName'] ?? 'Unnamed Shop'; // Default to 'Unnamed Shop' if null

              return {
                'shopId': shopid,
                'shopName': shopName,
              };
            }).toList());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("images/Sales rep view Shop Request.png"),
          fit: BoxFit.fill,
        ),
      ),
      child: StreamBuilder<List<Map<String, dynamic>>>(
        stream: fetchShopData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final shopList = snapshot.data!;
            if (shopList.isEmpty) {
              return const Center(child: Text('No shops found.'));
            }
            return Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: shopList.map((shop) {
                    return GestureDetector(
                      onTap: () {
                        // Pass shopid and title to the next page
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => shop_yourstock_view(
                              shopId: shop['shopId'], // Pass the shopid
                              title: '${shop['shopId']} request products', // Pass shopid and title
                            ),
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.8),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text(
                              shop['shopName'], // Display shopName
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            );
          } else {
            return const Center(child: Text('No data available.'));
          }
        },
      ),
    );
  }
}
