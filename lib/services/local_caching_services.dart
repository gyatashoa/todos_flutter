import 'package:hive/hive.dart';
import '../models/taskModel.dart';

class LocalCachingSevices {
  LocalCachingSevices._();
  static final instance = LocalCachingSevices._();

  String get boxName => "taskbox";

  Future addCacheTaskModel(HiveTaskModel details) async {
    var box = await Hive.openBox<HiveTaskModel>(this.boxName);
    box.add(details);
    box.close();
  }

  Future removecachedTaskModel(int index) async {
    var box = await Hive.openBox<HiveTaskModel>(this.boxName);
    box.deleteAt(index);
    box.close();
  }

  Future<List<HiveTaskModel>> getcachedTaskModel() async {
    var box = await Hive.openBox<HiveTaskModel>(this.boxName);
    var data = box.values.map((value) => value).toList();
    box.close();
    return data;
  }
}
