import 'package:flutter/material.dart';
import 'package:todoapp/widget/tile_widget.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  List toDoList = [
    ["stuff", false],
    ["stuff", false],
    ["stuff", false],
  ];
  void checkBoxChanged(bool? value, int index) {
    setState(() {
      toDoList[index][1] = !toDoList[index][1];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.yellow[200],
        appBar: AppBar(
          title: Text("To-Do"),
          centerTitle: true,
        ),
        body: ListView.builder(
          itemCount: toDoList.length,
          itemBuilder: (context, index) {
            var itemindex = toDoList[index];
            return TileWidget(
                onChanged: (value) => checkBoxChanged(value, index),
                taskCompleted: itemindex[1],
                taskname: itemindex[0]);
          },
        ));
  }
}
