import 'package:flutter/material.dart';
import 'package:todos/add Task.dart';
import 'edit Task.dart';
import 'package:todos/Task.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  DateTime today = new DateTime.now();
  late Task newTask;
  List<Task> tasks = [
    Task("zoom call", "8pm", "Human Computer Interaction lectures"),
    Task("Wash clothes", "7pm", "Arch"),
  ];

  void updateTask(Task t) {
    setState(() {
      tasks.add(t);
      print("setState called");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Schedule your day"),
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.blueGrey,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, i) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Slidable(
                    actionPane: SlidableDrawerActionPane(),
                    actionExtentRatio: 0.25,
                    child: Container(
                      color: Colors.lightBlueAccent,
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.blueGrey,
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: CircleAvatar(
                              backgroundColor: Colors.white,
                            ),
                          ),
                          foregroundColor: Colors.white,
                        ),
                        title: Text("${tasks[i].getTitle()}"),
                        subtitle: Text("${tasks[i].getDeadline()}"),
                      ),
                    ),
                    secondaryActions: [
                      IconSlideAction(
                        caption: 'Edit',
                        color: Colors.green,
                        icon: Icons.edit,
                        onTap: () async {
                          tasks[i] = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EditTask(
                                    title: tasks[i].getTitle(),
                                    description: tasks[i].getDescription(),
                                    DueTime: tasks[i].getDeadline()),
                              ));
                          setState(() {
                            print("called setState");
                          });
                        },
                      ),
                      IconSlideAction(
                        caption: 'Delete',
                        color: Colors.red,
                        icon: Icons.delete,
                        onTap: () {
                          setState(() {
                            tasks.removeAt(i);
                          });
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          FloatingActionButton(
            backgroundColor: Colors.blueGrey,
            onPressed: () async {
              final newTask = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddTask(),
                  ));
              print("results is $newTask");
              print("title: ${newTask.getTitle()}");
              updateTask(newTask);
            },
            child: Text(
              "+",
              style: TextStyle(fontSize: 25),
            ),
          ),
        ],
      ),
    );
  }
}
