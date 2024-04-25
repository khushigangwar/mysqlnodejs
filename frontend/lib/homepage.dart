import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mysqlnodejs/students.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<List<Students>> students = getStudent();

  static Future<List<Students>> getStudent() async {
    http.Response response =
        await http.get(Uri.parse("http://localhost:3000/connect"));
    final data = jsonDecode(response.body);
    return data.map<Students>((json) => Students.fromJson(json)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Nodejs flutter")),
      body: Center(
          child: FutureBuilder(
              future: students,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasData) {
                  final students = snapshot.data!;
                  return buildUsers(students);
                } else {
                  return const Text("No data found");
                }
              })),
    );
  }
}

Widget buildUsers(List<Students> students) {
  return ListView.builder(
      itemCount: students.length,
      itemBuilder: (context, index) {
        final allStudents = students[index];
        return Card(
          child: ListTile(
            title: Text(allStudents.name),
            subtitle: Text(allStudents.email),
          ),
        );
      });
}
