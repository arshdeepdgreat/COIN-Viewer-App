import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

Future<void> main() async {
  Response res=await http.get(Uri.parse("https://rest.coinapi.io/v1/exchanges/?apikey=3FA1E567-4C1F-4D94-A36F-6B8E326EC75C"));
  List<dynamic> Data = jsonDecode(res.body);
  // print(data[0]['name']);
  runApp(MyApp(data: Data));
}
class MyApp extends StatelessWidget {
  final List<dynamic> data;
  List<MaterialColor> primaries = <MaterialColor>[ Colors.red, Colors.pink, Colors.purple, Colors.deepPurple, Colors.indigo, Colors.blue, Colors.lightBlue, Colors.cyan, Colors.teal, Colors.green, Colors.lightGreen, Colors.lime, Colors.yellow, Colors.amber, Colors.orange];
  MyApp({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Crypto App',
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Crypto App'),
        ),
        body: Center(
          child: Container(
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(data[index]["exchange_id"],
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text(data[index]['name']+"\n"+data[index]['website'],),
                    isThreeLine: true,
                    leading: CircleAvatar(
                      backgroundColor: primaries[index % primaries.length],
                      child: Text(data[index]["name"][0],
                          style: const TextStyle(fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                      ),
                    ),
                    );
                },
                itemCount: data.length,
              )),
        ),
      ),
    );
  }
}

