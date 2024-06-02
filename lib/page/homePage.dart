import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> with TickerProviderStateMixin {
  List<dynamic> user = [];
  bool isLodiand = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed: fatchData,
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        elevation: 2,
        title: Center(child: Text("Api calling")),
      ),
      body: isLodiand
          ? Center(
              child: CircularProgressIndicator(
                semanticsLabel: 'Circular progress indicator',
              ),
            )
          : ListView.builder(
              itemBuilder: (context, index) {
                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.blue,
                    child: Text("${index + 1}"),
                  ),
                  title: Text(user[index]["email"]),
                  subtitle: Text(user[index]["name"]["first"]),
                );
              },
              itemCount: user.length,
            ),
    );
  }

  Future<void> fatchData() async {
    setState(() {
      isLodiand = true;
    });
    const uri = "https://randomuser.me/api/?results=5000";
    final url = Uri.parse(uri);
    final responce = await http.get(url);
    final body = responce.body;

    print(responce.body);
    final json = jsonDecode(body);
    setState(() {
      user = json['results'];
      isLodiand = false;
    });
  }
}
