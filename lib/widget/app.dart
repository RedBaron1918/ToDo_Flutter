import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todoapp/data/data.dart';
import 'package:todoapp/widget/dialog_widget.dart';
import 'package:todoapp/widget/tile_widget.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  final _myBox = Hive.box('mybox');
  ToDoDataBase db = ToDoDataBase();

  final _controller = TextEditingController();

  @override
  void initState() {
    if (_myBox.get("TODOLIST") == null) {
      db.createInitialData();
    } else {
      db.loadData();
    }
    super.initState();
  }

  void checkBoxChanged(bool? value, int index) {
    setState(() {
      db.toDoList[index][1] = !db.toDoList[index][1];
    });
    db.updateDataBase();
  }

  void saveTask() {
    if (_controller.text.isNotEmpty) {
      setState(() {
        db.toDoList.add([_controller.text, false]);
        _controller.text = '';
        Navigator.of(context).pop();
      });
      db.updateDataBase();
    }
  }

  void deleteTask(int index) {
    setState(() {
      db.toDoList.removeAt(index);
    });
    db.updateDataBase();
  }

  void createTask() {
    showDialog(
      context: context,
      builder: (context) {
        return DialogWidget(
          controller: _controller,
          onCancel: () {
            Navigator.of(context).pop();
          },
          onSave: saveTask,
        );
      },
    );
  }

  void editTask(int index) {
    String taskText = db.toDoList[index][0];
    _controller.text = taskText;
    showDialog(
      context: context,
      builder: (context) {
        return DialogWidget(
          controller: _controller,
          onCancel: () {
            Navigator.of(context).pop();
          },
          onSave: () {
            setState(() {
              db.toDoList[index][0] = _controller.text;
              _controller.text = '';
              Navigator.of(context).pop();
            });
            db.updateDataBase();
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 49, 49, 49),
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 49, 49, 49),
          title: const Text("To-Do"),
          centerTitle: true,
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.redAccent,
          onPressed: createTask,
          child: const Icon(Icons.add),
        ),
        body: ListView.builder(
          itemCount: db.toDoList.length,
          itemBuilder: (context, index) {
            var itemindex = db.toDoList[index];
            return TileWidget(
                onEdited: () => editTask(index),
                onChanged: (value) => checkBoxChanged(value, index),
                taskCompleted: itemindex[1],
                deleteFunction: (context) => deleteTask(index),
                taskname: itemindex[0]);
          },
        ));
  }
}
