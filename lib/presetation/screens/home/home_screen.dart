import 'package:flutter/material.dart';
import 'package:todo_app_c12_online_sun/presetation/screens/home/tabs/settings_tab/tasks_tab.dart';
import 'package:todo_app_c12_online_sun/presetation/screens/home/tabs/tasks_tab/tasks_tab.dart';
import 'package:todo_app_c12_online_sun/presetation/screens/home/task_bottom_sheet/task_bottom_sheet.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;
  GlobalKey<TasksTabState> tasksTabKey = GlobalKey();
  List<Widget> tabs = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabs = [
      TasksTab(
        key: tasksTabKey,
      ),
      SettingsTab(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        title: const Text('ToDo List'),
      ),
      floatingActionButton: buildFab(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: buildBottomNavBar(),
      body: tabs[currentIndex],
    );
  }

  buildBottomNavBar() => BottomAppBar(
        notchMargin: 8,
        child: BottomNavigationBar(
            currentIndex: currentIndex,
            onTap: onTapped,
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Tasks'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.settings), label: 'Settings'),
            ]),
      );

  void onTapped(int index) {
    currentIndex = index;
    setState(() {});
  }

  Widget buildFab() => FloatingActionButton(
        onPressed: () async {
          await TaskBottomSheet.show(context); // stop
          tasksTabKey.currentState?.readTodosFromFireStore();
        },
        child: const Icon(
          Icons.add,
        ),
      );
}
