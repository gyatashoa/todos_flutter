import 'package:flutter/material.dart';
import 'package:todos/Task.dart';
import 'package:intl/intl.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class AddTask extends StatefulWidget {
  const AddTask({Key? key}) : super(key: key);

  @override
  _AddTaskState createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  DateTime _date = DateTime.now();
  DateFormat _dateFormatter = DateFormat('MMM dd, yyy');
  TextEditingController _dateController = TextEditingController();
  _handleDatePicker() async {
    final DateTime? date = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime(2000),
      lastDate: DateTime(2050),
    );
    if (date != null && date != _date) {
      setState(() {
        _date = date;
        //print("date: $_date");
      });
    }
    _dateController.text = _dateFormatter.format(date!);
  }

  var title;
  var description;
  var DueTime;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blue,
        elevation: 0,
        title: Text("New Task"),
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
            Container(
              padding: EdgeInsets.all(16),
              child: TextField(
                obscureText: false,
                onSubmitted: (String value) {
                  title = value;
                  print("title: $title");
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'title',
                ),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Container(
              padding: EdgeInsets.all(15),
              child: TextField(
                obscureText: false,
                onSubmitted: (String value) {
                  description = value;
                  print("description: $description");
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'description',
                ),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Container(
              padding: EdgeInsets.all(15),
              child: TextField(
                obscureText: false,
                onSubmitted: (String value) {
                  DueTime = value;
                  print("Due Time: $DueTime");
                },
                controller: _dateController,
                onTap: _handleDatePicker,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Due Time',
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(15),
              child: TextField(
                obscureText: false,
                onSubmitted: (String value) {
                  DueTime = value;
                  print("Due Time: $DueTime");
                },
                controller: _dateController,
                onTap: _handleDatePicker,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Due Time',
                ),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            ElevatedButton(
                onPressed: () {
                  /*DatePicker.showTime12hPicker(context,
                  showTitleActions: true,
                  minTime: DateTime(2018, 3, 5),
                  maxTime: DateTime(2019, 6, 7), onChanged: (date) {
                    print('change $date');
                  }, onConfirm: (date) {
                    print('confirm $date');
                  }, currentTime: DateTime.now(), locale: LocaleType.en);*/
                  DatePicker.showTime12hPicker(context);
                },
                child: Text("select time")),
            SizedBox(
              height: 10.0,
            ),
            ElevatedButton(
                onPressed: () {
                  Task newTask = Task(
                    title,
                    DueTime,
                    description,
                  );
                  print("task in add task: $newTask");
                  print("newTask title: ${newTask.getTitle()}");
                  Navigator.pop(context, newTask);
                },
                child: Text("Add Task")),
          ],
        ),
      ),
    );
  }
}
