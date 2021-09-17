import 'package:flutter/material.dart';
import 'package:todos/Task.dart';

// ignore: must_be_immutable
class EditTask extends StatelessWidget {
  var title;
  var description;
  var DueTime;
  EditTask(
      {Key? key,
      required this.title,
      required this.description,
      required this.DueTime})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.green,
        elevation: 0,
        title: Text("Edit Task"),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
          ),
          iconSize: 20,
          color: Colors.white,
          splashColor: Colors.white,
          onPressed: () {
            Navigator.pop(context);
          }, // Navigator.push(context, MaterialPageRoute(builder: (context)=>Loading()));
        ),
      ),
      body: Container(
        margin: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 0.0),
        child: Column(
          children: [
            TextField(
              obscureText: false,
              onSubmitted: (String value) {
                title = value;
                print("title: $title");
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: '$title',
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            TextField(
              obscureText: false,
              onSubmitted: (String value) {
                description = value;
                print("description: $description");
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: '$description',
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            TextField(
              obscureText: false,
              onSubmitted: (String value) {
                DueTime = value;
                print("DueTime: $DueTime");
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: '$DueTime',
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            ElevatedButton(
                onPressed: () {
                  Task newTask = Task(title, DueTime, description);
                  print("task in add task: $newTask");
                  print("newTask title: ${newTask.getTitle()}");
                  Navigator.pop(context, newTask);
                },
                child: Text("Save Changes")),
          ],
        ),
      ),
    );
  }
}
