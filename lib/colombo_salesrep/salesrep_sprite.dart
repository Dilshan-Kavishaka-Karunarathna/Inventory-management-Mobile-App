import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class salesrep_sprite extends StatelessWidget {
  final String salesRepId;
  final String title;

  const salesrep_sprite({super.key, required this.salesRepId, required this.title});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Sprite Stocks'),
          backgroundColor: Colors.green,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: BackgroundImage(salesRepId:salesRepId, title: title),
      ),
    );
  }
}

class BackgroundImage extends StatelessWidget {
  final String salesRepId;
  final String title;

  const BackgroundImage({super.key, required this.salesRepId, required this.title});

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
              image: AssetImage("images/salesrep_view_sprite.png"),
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
                  DataDisplayTableWithPrefix(salesRepId:salesRepId),
                  const SizedBox(height: 20), // Space between tables
                  DataDisplayTableWithTitle(salesRepId:salesRepId, title: title),
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
  final String salesRepId;

  const DataDisplayTableWithPrefix({super.key, required this.salesRepId});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: fetchDocumentsWithPrefix(salesRepId, "SP"),
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
      String salesRepId, String prefix) async {
    final List<Map<String, dynamic>> documents = [];
    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection(salesRepId)
          .where('product_id', isGreaterThanOrEqualTo: prefix)
          .where('product_id', isLessThan: '${prefix}z')
          .get();

      for (var doc in querySnapshot.docs) {
        documents.add(doc.data());
      }
    } catch (e) {
      print('Error fetching documents from shop $salesRepId: $e');
    }
    return documents;
  }
}

class DataDisplayTableWithTitle extends StatelessWidget {
  final String salesRepId;
  final String title;

  const DataDisplayTableWithTitle(
      {super.key, required this.salesRepId, required this.title});

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
        final bool isRequestProducts = title == '$salesRepId request products';

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
          .where('request_product_id', whereIn: ['SP1', 'SP2', 'SP3', 'SP4', 'SP5']) // Filter for these IDs
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
