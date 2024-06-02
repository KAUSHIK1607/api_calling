import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UkHoliday extends StatefulWidget {
  const UkHoliday({super.key});

  @override
  State<UkHoliday> createState() => _UkHolidayState();
}

class _UkHolidayState extends State<UkHoliday> {
  List<dynamic> holidatData = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: ApiPatch,
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        elevation: 10,
        title: Center(child: Text("Holidays")),
      ),
      body: ListView.builder(itemBuilder: (context, index) {
        return ListTile(
          title: Text(holidatData[index]["title"]),
          leading: CircleAvatar(
            child: Text("${index + 1}"),
          ),
          trailing: Text(holidatData[index]["date"]),
        );
      }),
    );
  }

  void ApiPatch() async {
    const uri = "https://www.gov.uk/bank-holidays.json";
    final url = Uri.parse(uri);
    final response = await http.get(url);
    final body = response.body;
    final json = jsonDecode(body);
    print(json);
    print(json['england-and-wales']['division']);

    setState(() {
      holidatData = json['england-and-wales']['events'];
    });
  }
}
