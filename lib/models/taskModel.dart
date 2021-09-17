import 'package:hive/hive.dart';

part 'taskModel.g.dart';

@HiveType(typeId: 0)
class HiveTaskModel extends HiveObject {
  @HiveField(0)
  String? title;

  @HiveField(1)
  DateTime? dueTime;

  @HiveField(2)
  String? description;
}
