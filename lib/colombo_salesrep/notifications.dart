import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NotificationsPage extends StatelessWidget {
  final String salesRepId;

  const NotificationsPage({super.key, required this.salesRepId});

  Future<List<Map<String, dynamic>>> _fetchShopDetails() async {
    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection('shops')
          .where('salesRepId', isEqualTo: salesRepId)
          .get();

      final shopDetails = await Future.wait(querySnapshot.docs.map((doc) async {
        final data = doc.data();

        // Fetch low stock products for this shop
        final lowStockProducts = await _fetchLowStockProducts(data['shopId']);

        return {
          'shopName': data['shopName'] ?? 'Unknown',
          'shopId': data['shopId'] ?? 'Unknown',
          'location': data['shopAddress'] ?? 'N/A',
          'district': data['district'] ?? 'Unknown',
          'phone': data['phone'] ?? 'N/A',
          'lowStockCount': lowStockProducts.length, // Count of low stock products
        };
      }));

      return shopDetails;
    } catch (e) {
      print('Error fetching shop details: $e');
      return [];
    }
  }

  Future<List<Map<String, dynamic>>> _fetchLowStockProducts(String shopId) async {
    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection(shopId)
          .where('quantity', isLessThan: 50)
          .get();

      return querySnapshot.docs.map((doc) {
        final data = doc.data();
        return {
          'productName': data['product_name'] ?? 'Unknown',
          'quantity': data['quantity'] ?? 'N/A',
        };
      }).toList();
    } catch (e) {
      print('Error fetching low-stock products: $e');
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
          // Count the number of shops with low-stock products
          final lowStockShopsCount =
              shops.where((shop) => shop['lowStockCount'] > 0).length;

          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Shops with Low-Stock Products: $lowStockShopsCount',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: shops.length,
                  itemBuilder: (context, index) {
                    final shop = shops[index];
                    return Card(
                      margin:
                          const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                      child: ExpansionTile(
                        title: Text(shop['shopName']),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Shop ID: ${shop['shopId']}'),
                            Text('District: ${shop['district']}'),
                            Text('Phone: ${shop['phone']}'),
                          ],
                        ),
                        children: [
                          FutureBuilder<List<Map<String, dynamic>>>(
                            future: _fetchLowStockProducts(shop['shopId']),
                            builder: (context, productSnapshot) {
                              if (productSnapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                              if (productSnapshot.hasError) {
                                return const Padding(
                                  padding: EdgeInsets.all(12),
                                  child: Text(
                                    "Error fetching low-stock products.",
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                );
                              }
                              final products = productSnapshot.data ?? [];
                              if (products.isEmpty) {
                                return const Padding(
                                  padding: EdgeInsets.all(12),
                                  child: Text(
                                    "No products with low stock.",
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.black54,
                                    ),
                                  ),
                                );
                              }

                              return ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: products.length,
                                itemBuilder: (context, index) {
                                  final product = products[index];
                                  return ListTile(
                                    leading: CircleAvatar(
                                      backgroundColor: Colors.deepOrangeAccent,
                                      child: Text(
                                        "${index + 1}",
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    title: Text(
                                      product['productName'],
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        color: Colors.black87,
                                      ),
                                    ),
                                    subtitle: Text(
                                      "Quantity: ${product['quantity']}",
                                      style: const TextStyle(color: Colors.black54),
                                    ),
                                    trailing: const Icon(
                                      Icons.warning_amber_rounded,
                                      color: Colors.redAccent,
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
