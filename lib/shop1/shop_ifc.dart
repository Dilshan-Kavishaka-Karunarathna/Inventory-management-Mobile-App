import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/future_status.dart';
import 'package:flutter_application_2/shop1/change_password_shop.dart';
import '../areamanager/areamanager_yourstock_view.dart';
import 'notifications.dart'; // Import the NotificationPage
import 'logScreen.dart';
import 'salesrep_stock_from_shop.dart';
import 'shop_stock_editing.dart';
class ShopInterface extends StatelessWidget {
  final String shopId;
  const ShopInterface({super.key, required this.shopId});

  // Fetch the count of low-stock products
  Future<int> _getLowStockCount(String shopId) async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection(shopId)
        .where('quantity', isLessThan: 50) // Check if quantity is less than 50
        .get();
    return snapshot.docs.length; // Return the count of low-stock products
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: FutureBuilder<int>(
          future: _getLowStockCount(shopId), // Fetch the low-stock count
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return const Center(child: Text("Error fetching data"));
            }
            final lowStockCount = snapshot.data ?? 0;

            return BackgroundImage(
              shopId: shopId,
              lowStockCount: lowStockCount, // Pass the low-stock count to BackgroundImage
            );
          },
        ),
      ),
    );
  }
}

class BackgroundImage extends StatelessWidget {
  final String shopId;
  final int lowStockCount;

  const BackgroundImage({super.key, required this.shopId, required this.lowStockCount});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("images/shop_ifc.png"), // Background image
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        children: [
          // Notification button at the top-left with count badge
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.only(top: 80, left: 15),
              child: Ink(
                decoration: const ShapeDecoration(
                  color: Color.fromARGB(255, 251, 253, 251),
                  shape: CircleBorder(),
                ),
                child: Stack(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.notifications),
                      color: const Color.fromARGB(255, 0, 0, 0),
                      onPressed: () {
                        // Navigate to the notification page
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => NotificationPage(shopId: shopId),
                          ),
                        );
                      },
                    ),
                    if (lowStockCount > 0) // Only show the badge if there's low stock
                      Positioned(
                        right: 0,
                        top: -0,
                        child: CircleAvatar(
                          radius: 10,
                          backgroundColor: Colors.red,
                          child: Text(
                            '$lowStockCount',
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),

        
          // Stock buttons
          Expanded(
            child: GridView.count(
              crossAxisCount:2,
              crossAxisSpacing: 20,
              mainAxisSpacing: 60,
              padding: const EdgeInsets.all(20),
              children: [
                _buildStockButton(
                  context,
                  label: 'Your Stock',
                  icon: Icons.inventory_2,
                  onPressed: () {
                    // Your stock action
                       Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            shop_stock_editing(shopId: shopId),
                      ),
                    );
                  },
                ),
                _buildStockButton(
                  context,
                  label: 'Sales Rep\nStock',
                  icon: Icons.people,
                  onPressed: () {
                     Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>  salesrep_stock_from_shop(shopId:shopId),
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
                        builder: (context) => areamanager_yourstock_view(userId:'Area1'),
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
                // New Change Password Button
      _buildStockButton(
        context,
        label: 'Change Password',
        icon: Icons.lock,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => change_password_shop(shopId: shopId), // Navigate to change password page
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

  // Stock button widget
  // Stock button widget
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
