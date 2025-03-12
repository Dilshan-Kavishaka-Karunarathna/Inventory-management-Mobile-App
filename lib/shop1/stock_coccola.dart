import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class stock_coccola extends StatelessWidget {
  final String shopId;
  final String title;

  const stock_coccola({super.key, required this.shopId, required this.title});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
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
        body: BackgroundImage(shopId: shopId, title: title),
      ),
    );
  }
}

class BackgroundImage extends StatelessWidget {
  final String shopId;
  final String title;

  const BackgroundImage({super.key, required this.shopId, required this.title});

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
              image: AssetImage("images/Scocacola.png"),
              fit: BoxFit.fill,
            ),
          ),
        ),
        // Overlay Table
        Positioned.fill(
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  DataDisplayTableWithPrefix(shopId: shopId),
                  const SizedBox(height: 20), // Space between tables
                  DataDisplayTableWithTitle(shopId: shopId, title: title),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class DataDisplayTableWithPrefix extends StatelessWidget {
  final String shopId;

  const DataDisplayTableWithPrefix({super.key, required this.shopId});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: fetchDocumentsWithPrefix(shopId, "CC"),
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

        final List<Map<String, dynamic>> docs = snapshot.data!;

        final Map<String, Map<String, dynamic>> latestProducts = {};
        for (var data in docs) {
          final productId = data['product_id'] ?? 'N/A';
          final timestamp = data['timestamp'];

          DateTime timestampDateTime;
          if (timestamp is Timestamp) {
            timestampDateTime = timestamp.toDate();
          } else {
            timestampDateTime = DateTime(1970);
          }

          if (!latestProducts.containsKey(productId) ||
              timestampDateTime.isAfter(latestProducts[productId]!['timestamp'])) {
            latestProducts[productId] = {
              ...data,
              'timestamp': timestampDateTime,
            };
          }
        }

        final latestProductList = latestProducts.values.toList();

        return DataTable(
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
        );
      },
    );
  }

  Future<List<Map<String, dynamic>>> fetchDocumentsWithPrefix(
      String shopId, String prefix) async {
    final List<Map<String, dynamic>> documents = [];
    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection(shopId)
          .where('product_id', isGreaterThanOrEqualTo: prefix)
          .where('product_id', isLessThan: '${prefix}z')
          .get();

      for (var doc in querySnapshot.docs) {
        documents.add(doc.data());
      }
    } catch (e) {
      print('Error fetching documents from shop $shopId: $e');
    }
    return documents;
  }
}

class DataDisplayTableWithTitle extends StatelessWidget {
  final String shopId;
  final String title;

  const DataDisplayTableWithTitle(
      {super.key, required this.shopId, required this.title});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: fetchDocuments(title),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return const Center(child: Text('Error fetching data.'));
        }
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text(''));
        }

        final List<Map<String, dynamic>> docs = snapshot.data!;
        final bool isRequestProducts = title == '$shopId request products';

        // Filter the latest document for each request_product_id
        final Map<String, Map<String, dynamic>> latestRequestProducts = {};

        for (var data in docs) {
          final requestProductId = data['request_product_id'] ?? 'N/A';
          final timestamp = data['timestamp'];

          DateTime timestampDateTime;
          if (timestamp is Timestamp) {
            timestampDateTime = timestamp.toDate();
          } else {
            timestampDateTime = DateTime(1970);
          }

          if (!latestRequestProducts.containsKey(requestProductId) ||
              timestampDateTime.isAfter(latestRequestProducts[requestProductId]!['timestamp'])) {
            latestRequestProducts[requestProductId] = {
              ...data,
              'timestamp': timestampDateTime,
            };
          }
        }

        final latestRequestProductList = latestRequestProducts.values.toList();

        return DataTable(
          columns: isRequestProducts
              ? const [
                  DataColumn(label: Text('RProductID')),
                  DataColumn(label: Text('RProductName')),
                  DataColumn(label: Text('RQuantity')),
                  
                 
                ]
              : const [
                  DataColumn(label: Text('Product ID')),
                  DataColumn(label: Text('Product Name')),
                  DataColumn(label: Text('Quantity')),
                 
                ],
          rows: latestRequestProductList.map((data) {
            final productId = data['request_product_id'] ?? 'N/A';
            final productName = data['request_product_name'] ?? 'N/A';
            final quantity = data['request_quantity'] ?? 'N/A';
            


            return DataRow(cells: [
              DataCell(Text(productId.toString())),
              DataCell(Text(productName.toString())),
              DataCell(Text(quantity.toString())),
             
            ]);
          }).toList(),
        );
      },
    );
  }

  Future<List<Map<String, dynamic>>> fetchDocuments(String title) async {
    final List<Map<String, dynamic>> documents = [];
    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection(title)
          .where('request_product_id', whereIn: ['CC1', 'CC2', 'CC3', 'CC4', 'CC5']) // Filter for these IDs
          .get();

      for (var doc in querySnapshot.docs) {
        documents.add(doc.data());
      }
    } catch (e) {
      print('Error fetching documents from collection $title: $e');
    }
    return documents;
  }
}
