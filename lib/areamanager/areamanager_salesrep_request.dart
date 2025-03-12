import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_2/colombo_salesrep/salesrep_yourstock_view.dart';


class areamanager_salesrep_request extends StatelessWidget {
  final String userId;
  const areamanager_salesrep_request({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Shop Requests'),
          backgroundColor: Colors.green,
          leading:IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
             Navigator.pop(context);
            },
          )
        ),

        body: BackgroundImage(userId: userId),
      ),
    );
  }
}

class BackgroundImage extends StatelessWidget {
  final String userId;
  const BackgroundImage({super.key, required this.userId});

  // Fetch shopid from Firestore documents (not the document id)
  Stream<List<Map<String, dynamic>>> fetchShopData() {
    return FirebaseFirestore.instance
        .collection('salesreps')
        .where('areamanagerId', isEqualTo:userId) // Filter by salesRepId
        .snapshots()
        .map((querySnapshot) => querySnapshot.docs.map((doc) {
              final data = doc.data();

              // Safely extract shopid and shopName with fallback values
              final salesRepId = data['salesRepId'] ?? ''; // Default to an empty string if null
              final name = data['name'] ?? 'Unnamed salesrep'; // Default to 'Unnamed Shop' if null

              return {
                'salesRepId': salesRepId,
                'name':name,
              };
            }).toList());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("images/Sales rep view Shop Request.png"),
          fit: BoxFit.fill,
        ),
      ),
      child: StreamBuilder<List<Map<String, dynamic>>>(
        stream: fetchShopData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final srList = snapshot.data!;
            if (srList.isEmpty) {
              return const Center(child: Text('No salesrep name found.'));
            }
            return Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: srList.map((sr) {
                    return GestureDetector(
                      onTap: () {
                        // Pass shopid and title to the next page
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => salesrep_yourstock_view(
                              salesRepId: sr['salesRepId'], // Pass the shopid
                              title: '${sr['salesRepId']} request products',  // Pass shopid and title
                            ),
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.8),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text(
                              sr['name'], // Display shopName
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            );
          } else {
            return const Center(child: Text('No data available.'));
          }
        },
      ),
    );
  }
}
