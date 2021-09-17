import 'package:flutter/foundation.dart';
import 'package:todos/models/taskModel.dart';

class TasksProvider with ChangeNotifier {
  late List<HiveTaskModel> _tasks;

  TasksProvider() {
    this._tasks = [];
  }

  void set addMultiple(List<HiveTaskModel> tasks) {
    this._tasks = [...this._tasks, ...tasks];
    notifyListeners();
  }

  List<HiveTaskModel> get getTask => this._tasks;

  void set addTask(HiveTaskModel data) {
    this._tasks = [...this._tasks, data];
    notifyListeners();
  }
}
