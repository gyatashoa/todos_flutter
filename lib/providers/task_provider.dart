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

  set addTask(HiveTaskModel data) {
    this._tasks = [...this._tasks, data];
    notifyListeners();
  }

  void editTask(int index, HiveTaskModel payload) {
    this._tasks[index] = payload;
    notifyListeners();
  }

  void deleteTask(int index) {
    this._tasks.removeAt(index);
    notifyListeners();
  }
}
