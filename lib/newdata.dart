import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'main.dart'; // Make sure this import is correct based on your project structure.

class NewData extends StatefulWidget {
  const NewData({Key? key}) : super(key: key);

  @override
  _NewDataState createState() => _NewDataState();
}

class _NewDataState extends State<NewData> {
  TextEditingController name = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController salary = TextEditingController();

  void addData() async {
    var url =
        Uri.parse('http://localhost/CRUD/create.php'); // Inserting Api Calling
    final response = await http.post(
      url,
      body: {
        "name": name.text,
        "address": address.text,
        "salary": salary.text,
      },
    ); // parameter passed
    if (response.statusCode == 200) {
      // Data successfully added
      // You can handle the response here if needed
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("Add New Blog")),
        shape: const BeveledRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
        ),
      ),
      body: ListView(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            child: TextFormField(
              controller: name,
              autofocus: true,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Enter Name',
                hintText: 'Enter Name',
                prefixIcon: Icon(Icons.title),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            child: TextFormField(
              maxLines: 5,
              controller: address,
              autofocus: true,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Enter Address',
                hintText: 'Enter Address',
                prefixIcon: Icon(Icons.text_snippet_outlined),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            child: TextFormField(
              maxLines: 5,
              controller: salary,
              autofocus: true,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Enter Salary',
                hintText: 'Enter Salary',
                prefixIcon: Icon(Icons.text_snippet_outlined),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            child: MaterialButton(
              child: const Text("Add Data"),
              color: Colors.amber,
              onPressed: () {
                addData();
                Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (BuildContext context) => const Home()),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
