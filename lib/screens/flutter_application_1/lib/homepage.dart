import 'package:flutter/material.dart';
import 'package:flutter_application_1/task_add.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        backgroundColor: Colors.amber,
      ),
      body: Center(child: Text("No tasks yet, to add a task")),
      backgroundColor: Colors.blue,
       floatingActionButton: FloatingActionButton(
        onPressed: () {
         Navigator.push(context, MaterialPageRoute(builder: (context)=>TaskAdd()));
        },
        child: Icon(Icons.add),
        tooltip: 'Add',
      ),
   
    );
  }
}