import 'package:flutter/material.dart';

void main() {
  runApp(const future_status());
}

// ignore: camel_case_types
class future_status extends StatelessWidget {
  const future_status({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar:AppBar(
          title: const Text('Future Status'),
          backgroundColor: Colors.green,
          leading:IconButton(
            icon:Icon(Icons.arrow_back_ios),
            onPressed: (){
              Navigator.pop(context);
            },
          ),
        ),
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
              image: AssetImage("images/future status.png"),
              fit: BoxFit.fill,
            ),
          ),
        ),

      ],
    );
  }
}


