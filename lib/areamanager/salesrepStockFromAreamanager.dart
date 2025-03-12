import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../colombo_salesrep/salesrep_yourstock_view.dart';

class salesrepStockFromAreamanager extends StatelessWidget {
  final String userId;
  const salesrepStockFromAreamanager({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Remove debug banner
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Salesrep List'),
          backgroundColor: Colors.green,
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
              image: AssetImage('images/SalesRep_List.png'), // Add your image path here
              fit: BoxFit.cover, // Adjust the image to cover the entire screen
            ),
          ),
          child: Center(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ShopListView(userId: userId),
            ),
          ),
        ),
      ),
    );
  }
}

class ShopListView extends StatelessWidget {
  final String userId;
  const ShopListView({super.key, required this.userId});

  Stream<List<Map<String, dynamic>>> fetchShopNames() {
    return FirebaseFirestore.instance
        .collection('salesreps')
        .where('areamanagerId', isEqualTo: userId) // Filter by salesRepId
        .snapshots()
        .map((querySnapshot) => querySnapshot.docs
            .map((doc) {
              final data = doc.data();
              return {
                'salesRepId': data['salesRepId'], // Extract shopId from the document data
                'name': data['name'], // Extract shopName
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
          final salesrepList = snapshot.data!;
          if (salesrepList.isEmpty) {
            return const Center(child: Text('No salesrep found.'));
          }
          return ListView.builder(
            shrinkWrap: true,
            itemCount: salesrepList.length,
            itemBuilder: (context, index) {
              final salesreps = salesrepList[index];
              return Container(
                margin: const EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.4),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: ListTile(
                  title: Text(
                    salesreps['name'] ?? 'Unnamed name',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => salesrep_yourstock_view(
                          salesRepId: salesreps['salesRepId'],
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
          return const Center(child: Text('No data available.'));
        }
      },
    );
  }
}
