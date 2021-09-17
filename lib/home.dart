import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todos/add Task.dart';
import 'package:todos/models/taskModel.dart';
import 'package:todos/providers/task_provider.dart';
import 'package:todos/services/local_caching_services.dart';
import 'package:todos/services/notification_services.dart';
import 'package:todos/utils/dateTimeUtils.dart';
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

  @override
  void initState() {
    getTask();
  }

  void onDelete(int index) {
    LocalCachingSevices.instance.removecachedTaskModel(index);
    NotificationServices.instance.unsubscribe(index);
    context.read<TasksProvider>().deleteTask(index);
  }

  void getTask() async {
    final data = await LocalCachingSevices.instance.getcachedTaskModel();
    if (data != null) {
      context.read<TasksProvider>().addMultiple = data;
    }
  }

  void updateTask(Task t) {
    setState(() {
      // tasks.add(t);
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
            child: Consumer<TasksProvider>(builder: (context, model, widget) {
              return ListView.builder(
                itemCount: model.getTask.length,
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
                          title: Text("${model.getTask[i].title}"),
                          subtitle: Text(DateTimeUtils.formatDateTime(
                              model.getTask[i].dueTime!)),
                        ),
                      ),
                      secondaryActions: [
                        IconSlideAction(
                          caption: 'Edit',
                          color: Colors.green,
                          icon: Icons.edit,
                          onTap: () async {
                            await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => EditTask(
                                    task: model.getTask[i],
                                    index: i,
                                  ),
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
                          onTap: () => onDelete(i),
                        ),
                      ],
                    ),
                  );
                },
              );
            }),
          ),
          FloatingActionButton(
            backgroundColor: Colors.blueGrey,
            onPressed: () async {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddTask(),
                  ));
              // print("results is $newTask");
              // print("title: ${newTask.getTitle()}");
              // updateTask(newTask);
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
