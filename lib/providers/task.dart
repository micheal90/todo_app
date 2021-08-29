import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum Status { InProgress, Completed }

class Task with ChangeNotifier {
  int id;
  String title;
  DateTime date;
  TimeOfDay time;
  Status? status;
  Task({
    required this.id,
    required this.title,
    required this.date,
    required this.time,
    this.status,
  });
}

class Tasks with ChangeNotifier {
  List<Task> _task = [
    Task(
      id: 1,
      title: 'title1',
      date: DateTime.now(),
      time: TimeOfDay.now(),
    ),
    Task(
        id: 2,
        title: 'title2',
        date: DateTime.now(),
        time: TimeOfDay.now(),
        status: Status.InProgress),
    Task(
        id: 3,
        title: 'title3',
        date: DateTime.now(),
        time: TimeOfDay.now(),
        status: Status.Completed),
         Task(
        id: 4,
        title: 'title4',
        date: DateTime.now(),
        time: TimeOfDay.now(),
        ),
  ];
  List<Task> task({Status? status}) =>
      _task.where((element) => element.status == status).toList();

  void addTask(String title, DateTime date, TimeOfDay time) {
    _task.add(Task(
      id: _task.length+1,
      title: title,
      date: date,
      time: time,
    ));
    notifyListeners();
  }

  void updateTask(int id, String title, DateTime date, TimeOfDay time) {
    var task = _task.firstWhere((element) => element.id == id);
    task.title = title;
    task.date = date;
    task.time = time;

    notifyListeners();
  }

  void deleteTesk(int id) {
    _task.removeWhere((element) => element.id == id);
    notifyListeners();
  }

  void changeStatus(int id, Status newStatus) {
    _task.firstWhere((element) => element.id == id).status = newStatus;
    notifyListeners();
  }

  Task findTaskById(int id) {
    return _task.firstWhere((element) => element.id == id);
  }
}
