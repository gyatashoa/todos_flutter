

class Task {
  final title;
  final DueTime;
  final description;
  Task(this.title, this.DueTime, this.description);

  String getTitle(){
    return title.toString();
  }

  String getDescription(){
    return description.toString();
  }

  String getDeadline(){
    return DueTime.toString();
  }
}