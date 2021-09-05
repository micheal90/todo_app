import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/providers/task.dart';
import 'package:todo_app/screens/add_task_screen.dart';
import 'package:todo_app/util/database_helper.dart';
import 'package:todo_app/widgets/waiting_screen.dart';
//screens
import './screens/tab_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DatabaseHelper.init();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider.value(value: Tasks()..getTasks()),
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home: FutureBuilder(
      //     future: Provider.of<Tasks>(context).getTasks(),
      //     builder: (context, snapshot) =>
      //         snapshot.connectionState == ConnectionState.waiting
      //             ? WaitingScreen()
      //             : TabScreen()),
      routes: {
        '/': (_) => TabScreen(),
        AddTaskScreen.routeName: (_) => AddTaskScreen()
      },
    );
  }
}
