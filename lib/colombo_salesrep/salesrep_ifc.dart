import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:badges/badges.dart' as badges;

import '../areamanager/areamanager_yourstock_view.dart';
import 'salesrep_stock_editing.dart';
import '../shop1/logScreen.dart';
import 'shop_registration.dart';
import 'notifications.dart';
import 'shop_details.dart';
import 'package:flutter_application_2/future_status.dart';
import 'shop_view_from_salesrep_side.dart';
import 'package:flutter_application_2/colombo_salesrep/Sales rep view Shop Request.dart';


class salesrep_interface extends StatefulWidget {
  final String salesRepId;
  const salesrep_interface({super.key, required this.salesRepId});

  @override
  _salesrep_interfaceState createState() => _salesrep_interfaceState();
}

class _salesrep_interfaceState extends State<salesrep_interface> {
  int lowStockShopsCount = 0;
  int shopCount = 0;

  @override
  void initState() {
    super.initState();
    _fetchLowStockShopsCount();
    _fetchShopCount();
  }

  Future<void> _fetchLowStockShopsCount() async {
    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection('shops')
          .where('salesRepId', isEqualTo: widget.salesRepId)
          .get();

      int count = 0;
      for (var shop in querySnapshot.docs) {
        final shopId = shop.id;
        final productsQuerySnapshot = await FirebaseFirestore.instance
            .collection(shopId)
            .where('quantity', isLessThan: 50)
            .get();

        if (productsQuerySnapshot.docs.isNotEmpty) {
          count++;
        }
      }

      setState(() {
        lowStockShopsCount = count;
      });
    } catch (e) {
      print('Error fetching low stock shops count: $e');
    }
  }

  Future<void> _fetchShopCount() async {
    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection('shops')
          .where('salesRepId', isEqualTo: widget.salesRepId)
          .get();

      setState(() {
        shopCount = querySnapshot.docs.length;
      });
    } catch (e) {
      print('Error fetching shop count: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Sales Rep Interface'),
          actions: [
            badges.Badge(
              position: badges.BadgePosition.topEnd(top: 0, end: 3),
              showBadge: lowStockShopsCount > 0,
              badgeContent: Text(
                '$lowStockShopsCount',
                style: const TextStyle(color: Color.fromARGB(255, 23, 211, 70), fontSize: 12),
              ),
              child: IconButton(
                icon: const Icon(Icons.notifications),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NotificationsPage(
                        salesRepId: widget.salesRepId,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
        body: BackgroundImage(salesRepId: widget.salesRepId),
      ),
    );
  }
}

class BackgroundImage extends StatelessWidget {
  final String salesRepId;
  const BackgroundImage({super.key, required this.salesRepId});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("images/salesrep_ifc.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        children: [
          
          Expanded(
            child: GridView.count(
              
              crossAxisCount: 2,
              crossAxisSpacing: 20,
              mainAxisSpacing: 50,
              padding: const EdgeInsets.all(20),
              children: [
                _buildStockButton(
                  context,
                  label: 'Your Stock',
                  icon: Icons.inventory_2,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            salesrep_stock_editing(salesRepId: salesRepId),
                      ),
                    );
                  },
                ),
                _buildStockButton(
                  context,
                  label: 'Shop Stock',
                  icon: Icons.store,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            shop_view_from_salesrep_side(salesRepId: salesRepId),
                      ),
                    );
                  },
                ),
                _buildStockButton(
                  context,
                  label: 'Area Manager\nStock',
                  icon: Icons.manage_accounts,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            areamanager_yourstock_view(userId: 'Area1'),
                      ),
                    );
                  },
                ),
                _buildStockButton(
                  context,
                  label: 'Future Status',
                  icon: Icons.trending_up,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const future_status(),
                      ),
                    );
                  },
                ),
                _buildStockButton(
                  context,
                  label: 'Shop Requests',
                  icon: Icons.request_page,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            Sales_rep_view_shop_requests(salesRepId: salesRepId),
                      ),
                    );
                  },
                ),
                _buildStockButton(
                  context,
                  label: 'Shop Registration',
                  icon: Icons.app_registration,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            shop_registration(salesRepId: salesRepId),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

 Widget _buildStockButton(BuildContext context,
    {required String label, required IconData icon, required VoidCallback onPressed}) {
  return GestureDetector(
    onTap: onPressed,
    child: Container(
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 8, 241, 202),
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(255, 0, 0, 0).withOpacity(0.7),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Highlight shadow effect for the icon
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.yellow.withOpacity(0.8),
                  blurRadius: 20,
                  spreadRadius: 5,
                ),
              ],
            ),
            child: Icon(
              icon,
              size: 50,
              color: const Color.fromARGB(255, 249, 2, 2),
            ),
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
