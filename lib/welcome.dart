import 'package:flutter/material.dart';  

class Welcome extends StatefulWidget {


  final int id;
  final String name;


  Welcome({required this.id,required this.name});

  @override
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Appbar"),),

      body: Center(
        child: Column(
          children: [
            Center(child: Text("${widget.id}"
            
            ),

            
            
            
            
            ),

            Text("${widget.name}"),
          ],
        ),
      )
      
    );
  }
}