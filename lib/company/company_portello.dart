import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Import Firestore

// ignore: camel_case_types
class company_portello extends StatelessWidget {
  const company_portello({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: BackgroundImage(),
      ),
    );
  }
}

class BackgroundImage extends StatelessWidget {
  const BackgroundImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("images/stock_portello.png"),
              fit: BoxFit.fill,
            ),
          ),
        ),
        const Center(
          child: ProductTable(), // Center the table on the page
        ),
      ],
    );
  }
}

class ProductTable extends StatelessWidget {
  const ProductTable({super.key});

  @override
  Widget build(BuildContext context) {
    final CollectionReference collection =
        FirebaseFirestore.instance.collection('webMainStor');

    return StreamBuilder<QuerySnapshot>(
      stream: collection
          .where('product_id', isGreaterThanOrEqualTo: 'PO')
          .where('product_id', isLessThan: 'PP') // Limits to "CC" prefix
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }

        if (snapshot.hasError) {
          return const Text('Error loading data');
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Text('No products found');
        }

        final products = snapshot.data!.docs;

        return Container(
          width: MediaQuery.of(context).size.width * 0.8, // Constrain table width
          decoration: BoxDecoration(
            //color: Colors.white.withOpacity(0.9),
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              columnSpacing: 20.0,
              columns: const [
                DataColumn(label: Text('Product ID', style: TextStyle(fontWeight: FontWeight.bold))),
                DataColumn(label: Text('Product Name', style: TextStyle(fontWeight: FontWeight.bold))),
                DataColumn(label: Text('Quantity', style: TextStyle(fontWeight: FontWeight.bold))),
              ],
              rows: products.map((product) {
                final productId = product['product_id'] ?? 'Unknown';
                final productName = product['product_name'] ?? 'Unknown';
                final quantity = product['quantity']?.toString() ?? 'Unknown';

                return DataRow(cells: [
                  DataCell(Text(productId)),
                  DataCell(Text(productName)),
                  DataCell(Text(quantity)),
                ]);
              }).toList(),
            ),
          ),
        );
      },
    );
  }
}
