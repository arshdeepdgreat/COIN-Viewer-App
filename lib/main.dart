import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

Future<void> main() async {
  Response res = await http.get(Uri.parse(
      "https://rest.coinapi.io/v1/assets/?apikey=3FA1E567-4C1F-4D94-A36F-6B8E326EC75C"));
  List<dynamic> Data = jsonDecode(res.body);
  List<dynamic> Rates = [0];
  for (var i = 0; i < 10; i++) {
    Response res2 = await http.get(Uri.parse(
        "https://rest.coinapi.io/v1/exchangerate/" +
            Data[i]["asset_id"] +
            "/USD?apikey=3FA1E567-4C1F-4D94-A36F-6B8E326EC75C"));
    //  print("https://rest.coinapi.io/v1/exchangerate/" +
    //     Data[i]["asset_id"] +
    //     "/USD?apikey=3FA1E567-4C1F-4D94-A36F-6B8E326EC75C");
    if (res2.body.isNotEmpty) {
      // List<dynamic> Data2 = jsonDecode(res2.body);
      Rates.add(jsonDecode(res2.body));
    }
  }
  // print(Rates);

  runApp(MyApp(data: Data, rate: Rates));
}

class MyApp extends StatelessWidget {
  final List<dynamic> data, rate;
  List<MaterialColor> primaries = <MaterialColor>[
    Colors.red,
    Colors.pink,
    Colors.purple,
    Colors.deepPurple,
    Colors.indigo,
    Colors.blue,
    Colors.lightBlue,
    Colors.cyan,
    Colors.teal,
    Colors.green,
    Colors.lightGreen,
    Colors.lime,
    Colors.yellow,
    Colors.amber,
    Colors.orange
  ];
  MyApp({Key? key, required this.data, required this.rate}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Crypto App',
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: Scaffold(
        appBar: AppBar(
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: IconButton(
                icon: const Icon(
                  Icons.settings,
                ),
                onPressed: () {},
              ),
            ),
          ],
          title: const Text('Crypto App'),
        ),
        body: Center(
          child: _customUIwidget(data, primaries, rate),
        ),
      ),
    );
  }
}

// getData(List<dynamic> data, int index, List<dynamic> rate) {
//   Response res2 = http.get(Uri.parse("https://rest.coinapi.io/v1/exchanges/" +
//       data[index]["exchange_id"] +
//       "/USD?apikey=3FA1E567-4C1F-4D94-A36F-6B8E326EC75C")) as http.Response;
//   List<dynamic> Data2 = jsonDecode(res2.body);
// }

Widget _customUIwidget(
    List<dynamic> data, List<MaterialColor> primaries, rate) {
  return ListView.builder(
    itemBuilder: (context, index) {
      // Response res2 = http.get(Uri.parse(
      //         "https://rest.coinapi.io/v1/exchanges/" +
      //             data[index]["exchange_id"] +
      //             "/USD?apikey=3FA1E567-4C1F-4D94-A36F-6B8E326EC75C"))
      //     as http.Response;
      // List<dynamic> Data2 = jsonDecode(res2.body);
      return ListTile(
        title: Text(data[index]["asset_id"],
            style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(
          data[index]['name'] +
              "\n" +
              "\$" +
              rate[index + 1]['rate'].toString(),
        ),
        isThreeLine: true,
        leading: CircleAvatar(
          backgroundColor: primaries[index % primaries.length],
          child: Text(
            data[index]["name"][0],
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      );
    },
    itemCount: 10,
  );
}
