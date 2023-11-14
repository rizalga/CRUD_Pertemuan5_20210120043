import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'details.dart';
import 'newdata.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "CRUD",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late Future<List> futureData;

  @override
  void initState() {
    super.initState();
    futureData = getData();
  }

  Future<List> getData() async {
    var url = Uri.parse('http://localhost/CRUD/list.php'); // API Link
    final response = await http.post(url);
    return jsonDecode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("PHP MySQL CRUD")),
        shape: const BeveledRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (BuildContext context) => NewData(),
          ),
        ),
        child: const Icon(Icons.add),
      ),
      body: FutureBuilder<List>(
        future: futureData,
        builder: (ctx, snapshot) {
          if (snapshot.hasError) {
            print("Error: ${snapshot.error}");
            return Center(child: Text("Error fetching data"));
          }
          if (snapshot.hasData) {
            return Items(list: snapshot.data!);
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}

class Items extends StatelessWidget {
  final List list;

  Items({Key? key, required this.list}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: list.length,
      itemBuilder: (ctx, i) {
        return Card(
          child: Container(
            padding: EdgeInsets.all(10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 1, right: 9),
                  child: Text('${i + 1}'),
                ),
                Column(
                  children: [
                    Text('Nama : ${list[i]['name']}'),
                    Text('Alamat : ${list[i]['address']}'),
                    Text('Penghasilan : ${list[i]['salary']}'),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10, left: 10),
                  child: TextButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.blueAccent)),
                    onPressed: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (BuildContext context) =>
                            Details(list: list, index: i),
                      ),
                    ),
                    child: Text(
                      "detail",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
