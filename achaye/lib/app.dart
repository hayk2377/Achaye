import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class AchayeApp extends StatelessWidget {
  const AchayeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("achaye")),
      body: Center(child: Dummy()),
    );
  }
}

class Dummy extends StatefulWidget {
  const Dummy({super.key});

  @override
  State<Dummy> createState() => _DummyState();
}

Future<Map<String, String>> tryGet() async {
  var response = await http.get(Uri.parse("https://localhost:3000"));
  print("--------response is -----------");
  print(response);
  return jsonDecode(response.body);
}

class _DummyState extends State<Dummy> {
  Map? reply;

  @override
  void initState() {
    tryGet().then((map) => setState(() {
          reply = map;
        }));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dummy();
  }
}
