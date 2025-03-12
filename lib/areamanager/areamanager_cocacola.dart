import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class areamanager_cocacola extends StatelessWidget {
  final String userId;
  const areamanager_cocacola({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
         appBar:AppBar(
          title: const Text('Coca-Cola Stocks'),
          backgroundColor: Colors.green,
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

class BackgroundImage extends StatelessWidget {
  final String userId;
  const BackgroundImage({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Background Image
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("images/areamanager_view_to_others_cocacola.png"),
              fit: BoxFit.fill,
            ),
          ),
        ),
        // Overlay Table
        Positioned.fill(
          child: DataDisplayTable(userId: userId),
        ),
      ],
    );
  }
}

class DataDisplayTable extends StatelessWidget {
  final String userId;
  const DataDisplayTable({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    // Fetch the documents dynamically based on the shopId
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: fetchDocumentsWithPrefix(userId, "CC"),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return const Center(child: Text('Error fetching data.'));
        }
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No data found.'));
        }

        // Extract data from the snapshot
        final List<Map<String, dynamic>> docs = snapshot.data!;

        // Filter out duplicates based on product_id and keep the latest one
        final Map<String, Map<String, dynamic>> latestProducts = {};

        for (var data in docs) {
          final productId = data['product_id'] ?? 'N/A';
          final timestamp = data['timestamp']; // Firebase Timestamp object

          // Ensure timestamp is converted to DateTime
          DateTime timestampDateTime;
          if (timestamp is Timestamp) {
            timestampDateTime = timestamp.toDate(); // Convert to DateTime
          } else {
            timestampDateTime = DateTime(1970); // Default if no timestamp or invalid
          }

          // If this product_id has not been added or has a newer timestamp, update it
          if (!latestProducts.containsKey(productId) || timestampDateTime.isAfter(latestProducts[productId]!['timestamp'])) {
            latestProducts[productId] = {
              ...data,
              'timestamp': timestampDateTime, // Add the DateTime to the product data
            };
          }
        }

        // Convert the map to a list to render the data table
        final latestProductList = latestProducts.values.toList();

        return Center(
          child: DataTable(
            columns: const [
              DataColumn(label: Text('Product ID')),
              DataColumn(label: Text('Product Name')),
              DataColumn(label: Text('Quantity')),
            ],
            rows: latestProductList.map((data) {
              final productId = data['product_id'] ?? 'N/A';
              final productName = data['product_name'] ?? 'N/A';
              final quantity = data['quantity'] ?? 'N/A';

              return DataRow(cells: [
                DataCell(Text(productId.toString())),
                DataCell(Text(productName.toString())),
                DataCell(Text(quantity.toString())),
              ]);
            }).toList(),
          ),
        );
      },
    );
  }

  // Fetch documents from Firestore by shopId where product_id starts with "CC"
  Future<List<Map<String, dynamic>>> fetchDocumentsWithPrefix(String userId, String prefix) async {
    final List<Map<String, dynamic>> documents = [];
    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection(userId)
          .where('product_id', isGreaterThanOrEqualTo: prefix)
          .where('product_id', isLessThan: '${prefix}z')
          .get();

      for (var doc in querySnapshot.docs) {
        documents.add(doc.data());
      }
    } catch (e) {
      print('Error fetching documents from shop $userId: $e');
    }
    return documents;
  }
}
