import 'package:flutter/material.dart';
import 'areamanager_stock_editing.dart';
import '../shop1/logScreen.dart';
import 'package:flutter_application_2/colombo_salesrep/salesrep_from shop_ifc.dart';
import 'package:flutter_application_2/future_status.dart';


// ignore: camel_case_types
class company_view extends StatelessWidget {
  final String userId;
  const company_view({super.key,required this.userId});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: BackgroundImage(userId:userId),
      ),
    );
  }
}

class BackgroundImage extends StatelessWidget {
  final String userId;
  const BackgroundImage({super.key,required this.userId});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("images/Area Manager Company Stock View.png"),
          fit: BoxFit.fill,
        ),
      ),

    );
  }
}
