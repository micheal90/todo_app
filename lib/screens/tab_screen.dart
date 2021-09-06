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
  var _pageController = PageController(initialPage: 0);
  void _changIndex(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  late List<String> _pages;
  @override
  void initState() {
    _pages = [
      'Tasks',
      'InProgress Tasks',
      'Completed Tasks',
    ];

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_pages[_currentIndex]),
      ),
      body: PageView(
        controller: _pageController,
        children: [
          TasksScreen(),
          InprogressScreen(),
          CompletedScreen(),
        ],
        onPageChanged: _changIndex,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          _pageController.animateToPage(
            index,
            duration: Duration(milliseconds: 500),
            curve: Curves.linear,
          );
        },
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
                context,
                AddTaskScreen.routeName,
              ),
              child: Icon(Icons.add),
            )
          : null,
    );
  }
}
