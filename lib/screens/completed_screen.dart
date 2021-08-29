import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//providers
import '../providers/task.dart';
//widgets
import '../widgets/task_widget.dart';

class CompletedScreen extends StatelessWidget {
  const CompletedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _tasks = Provider.of<Tasks>(context).task(status: Status.Completed);
    return ListView.separated(
        itemBuilder: (context, index) => ChangeNotifierProvider.value(
            value: _tasks[index], child: TaskWidget()),
        separatorBuilder: (context, index) => Divider(),
        itemCount: _tasks.length);
  }
}