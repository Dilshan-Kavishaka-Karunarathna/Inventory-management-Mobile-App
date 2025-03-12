import 'package:flutter/material.dart';
import '../company/company_yourstock_view.dart';
import 'areamanager_salesrep_request.dart';
import 'areamanager_stock_editing.dart';
import 'salesrepStockFromAreamanager.dart';
import '../future_status.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class areamanagerlogin_after extends StatelessWidget {
  final String userId;
  const areamanagerlogin_after({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
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
    return SingleChildScrollView(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/areamanager_ifc.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              top: 40,
              left: 20,
              child: Stack(
                children: [
                  IconButton(
                    icon: const Icon(Icons.notifications, size: 30, color: Color.fromARGB(255, 234, 12, 12)),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NotificationScreen(userId: userId),
                        ),
                      );
                    },
                  ),
                  StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance.collection('notifications').snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                        return const SizedBox();
                      }
                      final notificationCount = snapshot.data!.docs.length;

                      return Positioned(
                        right: 4,
                        top: 4,
                        child: Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                blurRadius: 6,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Text(
                            '$notificationCount',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),

            Positioned(
              top: 200,
              left: 30,
              child: buildIconButton(
                context,
                icon: Icons.inventory,
                label: 'Area Manager Stock',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => areamanager_stock_editing(userId: userId)),
                  );
                },
              ),
            ),

            Positioned(
              top: 200,
              right: 30,
              child: buildIconButton(
                context,
                icon: Icons.store,
                label: 'Sales Rep Stock',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => salesrepStockFromAreamanager(userId: userId)),
                  );
                },
              ),
            ),

            Positioned(
              top: 370,
              left: 30,
              child: buildIconButton(
                context,
                icon: Icons.business,
                label: 'Company View',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const company_yourstock_view()),
                  );
                },
              ),
            ),

            Positioned(
              top: 540,
              left: 30,
              child: buildIconButton(
                context,
                icon: Icons.request_page,
                label: 'Sales Rep Requests',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => areamanager_salesrep_request(userId: userId),
                    ),
                  );
                },
              ),
            ),

            Positioned(
              top: 370,
              right: 30,
              child: buildIconButton(
                context,
                icon: Icons.timeline,
                label: 'Future Status',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const future_status()),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildIconButton(BuildContext context,
      {required String label, required IconData icon, required VoidCallback onPressed}) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 150,
        height: 140,
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 14, 246, 146),
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: const Color.fromARGB(255, 19, 20, 19).withOpacity(0.4),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 60,
              color: Colors.black,
            ),
            const SizedBox(height: 10),
            Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NotificationScreen extends StatelessWidget {
  final String userId;
  const NotificationScreen({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notifications"),
        backgroundColor: Colors.blue,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('salesreps').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text(
                "No sales representatives found.",
                style: TextStyle(fontSize: 18),
              ),
            );
          }

          final salesReps = snapshot.data!.docs;

          return ListView.builder(
            itemCount: salesReps.length,
            itemBuilder: (context, index) {
              final salesRep = salesReps[index];
              final String salesRepId = salesRep['salesRepId'] ?? 'Unknown';
              final String salesRepName = salesRep['name'] ?? 'Unknown';

              return Card(
                margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                child: ListTile(
                  leading: const Icon(Icons.person),
                  title: Text(
                    salesRepName,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  subtitle: Text("ID: $salesRepId"),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            SalesRepLowStockProductsScreen(salesRepId: salesRepId),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class SalesRepLowStockProductsScreen extends StatelessWidget {
  final String salesRepId;
  const SalesRepLowStockProductsScreen({super.key, required this.salesRepId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Low Stock Products"),
        backgroundColor: Colors.blue,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection(salesRepId)
            .where('quantity', isLessThan: 50)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(
              child: Text(
                "No low-quantity products for SalesRep ID: $salesRepId",
                style: const TextStyle(fontSize: 18),
              ),
            );
          }

          final lowStockProducts = snapshot.data!.docs;

          return ListView.builder(
            itemCount: lowStockProducts.length,
            itemBuilder: (context, index) {
              final product = lowStockProducts[index].data() as Map<String, dynamic>;
              final productName = product['product_name'] ?? 'Unknown Product';
              final quantity = product['quantity'] ?? 'N/A';

              return Card(
                margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                child: ListTile(
                  leading: const Icon(Icons.inventory),
                  title: Text(
                    productName,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text("Quantity: $quantity"),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
