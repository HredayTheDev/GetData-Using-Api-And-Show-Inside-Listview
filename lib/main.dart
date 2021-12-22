import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<List<Data>> fetchData() async {
  final response = await http
      .get(Uri.parse('http://192.168.0.121:9010/api/getdocnurserlist'));
  if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body);
    return jsonResponse.map((data) => new Data.fromJson(data)).toList();
  } else {
    throw Exception('Unexpected error occured!');
  }
}

class Data {
  // final int userId;
  // final int id;
  // final String title;

  final String FirstName;
  final String LastName;
  final String userName;
  final String Photo;

  // Data({required this.userId, required this.id, required this.title});
  Data(
      {required this.FirstName,
      required this.LastName,
      required this.userName,
      required this.Photo});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      FirstName: json['FirstName'],
      LastName: json['LastName'],
      userName: json['userName'],
      Photo: json['Photo'],
    );
  }
}

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  // MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Future<List<Data>> futureData;

  @override
  void initState() {
    super.initState();
    futureData = fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter API and ListView Example',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Flutter ListView'),
        ),
        body: Center(
          child: FutureBuilder<List<Data>>(
            future: futureData,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<Data>? data = snapshot.data;
                return ListView.builder(
                    itemCount: data!.length,
                    itemBuilder: (BuildContext context, int index) {

                      return Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListTile(
                            leading: CircleAvatar(
                              radius: 40,
                              
                              
                              backgroundImage: NetworkImage(data[index].Photo),
                            
                            
                            ),
                      
                            title:  Text(data[index].FirstName,),
                            subtitle:  Text(data[index].LastName),
                      
                      
                      
                          ),
                        ),
                      );


                      // return Card(
                      //   color: Colors.black,
                      //   child: Container(
                      //     padding: const EdgeInsets.all(10),
                      //     height: MediaQuery.of(context).size.height * 0.2 / 2,
                      //     color: Colors.white,
                      //     child: Column(
                      //       children: [
                      //         Text(
                      //           data[index].FirstName,
                      //           style: const TextStyle(
                      //               fontWeight: FontWeight.bold,
                      //               color: Colors.black,
                      //               fontSize: 19),
                      //         ),
                      //         Text(data[index].LastName,
                      //             style: const TextStyle(
                      //                 fontWeight: FontWeight.bold,
                      //                 color: Colors.blue,
                      //                 fontSize: 17)),
                      //         Text(data[index].userName),
                      //       ],
                      //     ),
                      //   ),
                      // );
                    });
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }
              // By default show a loading spinner.
              return const CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}
