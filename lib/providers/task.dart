import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/util/database_helper.dart';

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
  List<Task> _task = [];
  List<Task> tasks({Status? status}) =>
      _task.where((element) => element.status == status).toList();

  Future getTasks() async {
    List<Map<String, dynamic>> list = await DatabaseHelper.getTasks();
    _task.clear();
    list.forEach((element) {
      String time = element['time'].substring(10, 15);
      _task.add(Task(
        id: element['id'],
        title: element['title'],
        date: DateTime.parse(element['date']),
        time: TimeOfDay(
          hour: int.parse(time.split(':')[0]),
          minute: int.parse(time.split(':')[1]),
        ),
        status: convertStatusFromString(element['status']),
      ));
    });
  }

  void addTask(String title, DateTime date, TimeOfDay time) async {
    await DatabaseHelper.addTask(title, date, time);
    // _task.add(Task(
    //   id: _task.length + 1,
    //   title: title,
    //   date: date,
    //   time: time,
    // ));
    await getTasks();
    notifyListeners();
  }

  void updateTask(int id, String title, DateTime date, TimeOfDay time) async {
    await DatabaseHelper.updateTask(id, title, date, time);
    // var task = _task.firstWhere((element) => element.id == id);
    // task.title = title;
    // task.date = date;
    // task.time = time;
    await getTasks();
    notifyListeners();
  }

  void deleteTesk(int id) async {
    await DatabaseHelper.deleteTask(id);
    // _task.removeWhere((element) => element.id == id);
    await getTasks();
    notifyListeners();
  }

  void changeStatus(int id, Status newStatus) async {
    var status = convertStatusToString(newStatus);
    await DatabaseHelper.changeStatus(id, status);
    // _task.firstWhere((element) => element.id == id).status = newStatus;
    await getTasks();
    notifyListeners();
  }

  Task findTaskById(int id) {
    return _task.firstWhere((element) => element.id == id);
  }

  String convertStatusToString(Status status) {
    if (status == Status.InProgress) {
      return 'InProgress';
    } else {
      return 'Completed';
    }
  }

  Status? convertStatusFromString(String? status) {
    if (status == 'InProgress') {
      return Status.InProgress;
    } else if (status == 'Completed') {
      return Status.Completed;
    } else
      return null;
  }
}
