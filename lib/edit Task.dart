import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todos/Task.dart';
import 'package:todos/models/taskModel.dart';
import 'package:todos/providers/task_provider.dart';
import 'package:todos/services/local_caching_services.dart';
import 'package:todos/services/notification_services.dart';

import 'widgets/custom_date_field.dart';

// ignore: must_be_immutable
class EditTask extends StatefulWidget {
  final HiveTaskModel? task;
  final int? index;
  EditTask({Key? key, this.index, this.task}) : super(key: key);

  @override
  _EditTaskState createState() => _EditTaskState();
}

class _EditTaskState extends State<EditTask> {
  final TextEditingController dateController = TextEditingController();

  final TextEditingController timeController = TextEditingController();

  final TextEditingController titleController = TextEditingController();

  final TextEditingController descriptionController = TextEditingController();

  TimeOfDay? time;

  @override
  void initState() {
    final data = this.widget.task;
    titleController.text = data!.title!;
    descriptionController.text = data!.description!;
    dateController.text = data!.dueTime.toString();
    time = TimeOfDay(hour: data.dueTime!.hour, minute: data.dueTime!.minute);
    timeController.text = time.toString();
  }

  void onSave(TasksProvider provider) async {
    if (titleController.text == "" ||
        descriptionController.text == "" ||
        timeController.text == "" ||
        timeController.text == "null" ||
        dateController.text == "null" ||
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
    await LocalCachingSevices.instance
        .editCachedTaskModel(this.widget.index!, data);
    if (!data.dueTime!.isAtSameMomentAs(this.widget.task!.dueTime!)) {
      await NotificationServices.instance.unsubscribe(this.widget.index!);
      await NotificationServices.instance.subscribe(data, this.widget.index!);
    }
    provider.editTask(this.widget.index!, data);
    Navigator.pop(context);
  }

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
              controller: titleController,
              obscureText: false,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Title',
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            TextField(
              obscureText: false,
              controller: descriptionController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Description',
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Row(
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
                        context: context,
                        initialTime: TimeOfDay.fromDateTime(
                            DateTime.now().add(Duration(minutes: 2))));
                    timeController.text = data.toString();
                    time = data;
                  },
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
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
                        lastDate: DateTime(2050),
                        initialDate: DateTime.now());
                    // date = data;
                    dateController.text = data.toString();
                  },
                )
              ],
            ),
            SizedBox(
              height: 10.0,
            ),
            Consumer<TasksProvider>(builder: (context, provider, _) {
              return ElevatedButton(
                  onPressed: () => onSave(provider),
                  child: Text("Save Changes"));
            }),
          ],
        ),
      ),
    );
  }
}
