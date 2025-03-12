import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ShopDetailsPage extends StatelessWidget {
  final String salesRepId;

  const ShopDetailsPage({super.key, required this.salesRepId});

  Future<List<Map<String, dynamic>>> _fetchShopDetails() async {
    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection('shops')
          .where('salesRepId', isEqualTo: salesRepId)
          .get();

      // Parse the document data to a list of shop details
      final shopDetails = querySnapshot.docs.map((doc) {
        final data = doc.data();
        return {
          'shopName': data['shopName'] ?? 'Unknown', // Handle missing `shopName`
          'shopId': doc.id,
          'location': data['shopAddress'] ?? 'N/A', // Use `shopAddress` if `location` is missing
          'district': data['district'] ?? 'Unknown', // Optional district field
          'phone': data['phone'] ?? 'N/A', // Optional phone number
        };
      }).toList();

      return shopDetails;
    } catch (e) {
      print('Error fetching shop details: $e');
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shop Details'),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _fetchShopDetails(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No shops found.'));
          }

          final shops = snapshot.data!;
          return ListView.builder(
            itemCount: shops.length,
            itemBuilder: (context, index) {
              final shop = shops[index];
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                child: ListTile(
                  title: Text(shop['shopName']),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Shop ID: ${shop['shopId']}'),
                      Text('District: ${shop['district']}'),
                      Text('Phone: ${shop['phone']}'),
                    ],
                  ),
                  trailing: Text('Location: ${shop['location']}'),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
