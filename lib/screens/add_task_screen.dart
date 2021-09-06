import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/providers/task.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({Key? key}) : super(key: key);
  static const routeName = '/add_task_screen';

  @override
  _AddTaskScreenState createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  var _titleController = TextEditingController();
  var _timeController = TextEditingController();
  var _dateController = TextEditingController();
  var _formKey = GlobalKey<FormState>();
  bool _isEdit = false;
  bool _isFirst = true;
  var args;
  Task? _task;
  TimeOfDay? _selectedTime = TimeOfDay.now();

  void _showDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime.now(),
            lastDate: DateTime.now().add(
              Duration(days: 15),
            ))
        .then((value) => setState(() => _dateController.text =
            DateFormat().add_yMMMd().format(value ?? DateTime.now())));
  }

  void _showTimePicker() {
    showTimePicker(context: context, initialTime: TimeOfDay.now())
        .then((value) => setState(() {
              _selectedTime = value ?? TimeOfDay.now();
              _timeController.text =
                  value?.format(context) ?? TimeOfDay.now().format(context);
            }));
  }

  TimeOfDay stringToTimeOfDay(String tod) {
    final format = DateFormat.jm(); //"6:00 AM"
    return TimeOfDay.fromDateTime(format.parse(tod));
  }

  void _submit() {
    FocusScope.of(context).unfocus();
    if (!_formKey.currentState!.validate()) return;
    if (_task != null) {
      Provider.of<Tasks>(context, listen: false).updateTask(
        _task!.id,
        _titleController.text,
        DateFormat().add_yMMMd().parse(_dateController.text),
        _selectedTime!,
      );
    } else {
      Provider.of<Tasks>(context, listen: false).addTask(
        _titleController.text,
        DateFormat().add_yMMMd().parse(_dateController.text),
        _selectedTime!,
      );
    }
    Navigator.pop(context);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_isFirst) {
      args = ModalRoute.of(context)!.settings.arguments;
      if (args != null) {
        _task = Provider.of<Tasks>(context).findTaskById(args['id']);
        _titleController.text = _task!.title;
        _dateController.text =
            _dateController.text = DateFormat().add_yMMMd().format(_task!.date);
        _timeController.text = _task!.time.format(context);
      }
      _isFirst = false;
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _timeController.dispose();
    _dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: _isEdit ? Text('Edit Task') : Text('Add Task'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                TextFormField(
                  controller: _titleController,
                  decoration: InputDecoration(
                    labelText: 'Title',
                    prefixIcon: Icon(Icons.title),
                    border: OutlineInputBorder(),
                  ),
                  validator: (String? val) {
                    if (val!.isEmpty)
                      return 'Enter the Title';
                    else
                      return null;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: _dateController,
                  readOnly: true,
                  decoration: InputDecoration(
                    labelText: 'Date',
                    prefixIcon: Icon(Icons.date_range),
                    border: OutlineInputBorder(),
                  ),
                  validator: (String? val) {
                    if (val!.isEmpty)
                      return 'Enter the Date';
                    else
                      return null;
                  },
                  onTap: _showDatePicker,
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: _timeController,
                  readOnly: true,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Time',
                      prefixIcon: Icon(Icons.schedule_sharp)),
                  validator: (String? val) {
                    if (val!.isEmpty)
                      return 'Enter the Time';
                    else
                      return null;
                  },
                  onTap: _showTimePicker,
                ),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  onPressed: _submit,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      _isEdit ? 'Update Task' : 'Add Task',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
