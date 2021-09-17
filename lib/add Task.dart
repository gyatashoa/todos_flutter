import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todos/Task.dart';
import 'package:intl/intl.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:todos/models/taskModel.dart';
import 'package:todos/providers/task_provider.dart';
import 'package:todos/services/local_caching_services.dart';
import 'package:todos/services/notification_services.dart';

import 'widgets/custom_date_field.dart';

class AddTask extends StatefulWidget {
  const AddTask({Key? key}) : super(key: key);

  @override
  _AddTaskState createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  DateTime _date = DateTime.now();
  DateFormat _dateFormatter = DateFormat('MMM dd, yyy');
  TextEditingController dateController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TimeOfDay? time;
  // DateTime? date;
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
    // _dateController.text = _dateFormatter.format(date!);
  }

  var title;
  var description;
  var DueTime;

  void addTask(TasksProvider provider) async {
    if (titleController.text == "" ||
        descriptionController.text == "" ||
        timeController.text == "" ||
        dateController.text == "") {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Please fill all required fields")));
      return;
    }
    final date = DateTime.parse(dateController.text);
    final scheduled =
        DateTime.utc(date.year, date.month, date.day, time!.hour, time!.minute);

    final data = HiveTaskModel()
      ..title = this.titleController.text
      ..description = this.descriptionController.text
      ..dueTime = scheduled;
    await LocalCachingSevices.instance.addCacheTaskModel(data);
    provider.addTask = data;
    int index = provider.getTask.length - 1;
    await NotificationServices.instance.subscribe(data, index);
    Navigator.pop(context);
  }

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
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(16),
                child: TextField(
                  controller: titleController,
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
                  controller: descriptionController,
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

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Row(
                  children: [
                    Expanded(
                      child: CustomDateField(timeController, 'Due Time'),
                    ),
                    TextButton(
                      child: Icon(
                        Icons.timer,
                      ),
                      onPressed: () async {
                        final data = await showTimePicker(
                            context: context, initialTime: TimeOfDay.now());
                        timeController.text = data.toString();
                        time = data;
                      },
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Row(
                  children: [
                    Expanded(
                      child: CustomDateField(dateController, 'Date'),
                    ),
                    TextButton(
                      child: Icon(
                        Icons.calendar_today,
                      ),
                      onPressed: () async {
                        final data = await showDatePicker(
                            initialEntryMode: DatePickerEntryMode.calendar,
                            context: context,
                            firstDate: DateTime.now(),
                            lastDate: DateTime.now(),
                            initialDate: DateTime.now());
                        // date = data;
                        dateController.text = data.toString();
                      },
                    )
                  ],
                ),
              ),
              // Container(
              //   padding: EdgeInsets.all(15),
              //   child: TextField(
              //     obscureText: false,
              //     onSubmitted: (String value) {
              //       DueTime = value;
              //       print("Due Time: $DueTime");
              //     },
              //     controller: _dateController,
              //     onTap: _handleDatePicker,
              //     decoration: InputDecoration(
              //       border: OutlineInputBorder(),
              //       labelText: 'Due Time',
              //     ),
              //   ),
              // ),
              SizedBox(
                height: 10.0,
              ),
              // ElevatedButton(
              //     onPressed: () {
              //       /*DatePicker.showTime12hPicker(context,
              //       showTitleActions: true,
              //       minTime: DateTime(2018, 3, 5),
              //       maxTime: DateTime(2019, 6, 7), onChanged: (date) {
              //         print('change $date');
              //       }, onConfirm: (date) {
              //         print('confirm $date');
              //       }, currentTime: DateTime.now(), locale: LocaleType.en);*/
              //       DatePicker.showTime12hPicker(context);
              //     },
              //     child: Text("select time")),
              SizedBox(
                height: 10.0,
              ),
              Consumer<TasksProvider>(builder: (context, provider, _) {
                return ElevatedButton(
                    onPressed: () async {
                      addTask(provider);
                    },
                    child: Text("Add Task"));
              }),
            ],
          ),
        ),
      ),
    );
  }
}
