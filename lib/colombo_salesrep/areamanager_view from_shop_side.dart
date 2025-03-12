import 'package:flutter/material.dart';
import 'package:flutter_application_2/colombo_salesrep/shop_view_from_salesrep_side.dart';


// ignore: camel_case_types
class areamanager_view_from_salesrep_side extends StatelessWidget {
  final String salesRepId;
  const areamanager_view_from_salesrep_side({super.key,required this.salesRepId});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: BackgroundImage(salesRepId:salesRepId,),
      ),
    );
  }
}

class BackgroundImage extends StatelessWidget {
  final String salesRepId;
  const BackgroundImage({super.key,required this.salesRepId});


  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("images/areamanager_view_from_shop_side.png.png"),
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
