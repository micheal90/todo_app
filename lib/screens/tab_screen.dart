import 'package:flutter/material.dart';
import 'package:todo_app/screens/add_task_screen.dart';
//screens
import '../screens/tasks_screen.dart';
import '../screens/completed_screen.dart';
import '../screens/inprogress_screen.dart';

class TabScreen extends StatefulWidget {
  const TabScreen({Key? key}) : super(key: key);

  @override
  _TabScreenState createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  int _currentIndex = 0;
  void _changIndex(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  late List<Map<String, dynamic>> _pages;
  @override
  void initState() {
    _pages = [
      {
        'title': 'Tasks',
        'body': TasksScreen(),
      },
      {
        'title': 'InProgress Tasks',
        'body': InprogressScreen(),
      },
      {
        'title': 'Completed Tasks',
        'body': CompletedScreen(),
      },
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_pages[_currentIndex]['title'])),
      body: _pages[_currentIndex]['body'],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _changIndex,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.task_alt), label: 'Tasks'),
          BottomNavigationBarItem(
              icon: Icon(Icons.archive), label: 'In Progress'),
          BottomNavigationBarItem(icon: Icon(Icons.done), label: 'Completed'),
        ],
      ),
      floatingActionButton: _currentIndex == 0
          ? FloatingActionButton(
              onPressed: () => Navigator.pushNamed(
                  context, AddTaskScreen.routeName,arguments: {}
                  ),
              child: Icon(Icons.add),
            )
          : null,
    );
  }
}
