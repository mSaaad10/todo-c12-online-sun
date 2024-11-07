import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app_c12_online_sun/core/utils/app_styles.dart';
import 'package:todo_app_c12_online_sun/core/utils/colors_manager.dart';
import 'package:todo_app_c12_online_sun/core/utils/date_utils.dart';
import 'package:todo_app_c12_online_sun/database/model/todo_dm.dart';
import 'package:todo_app_c12_online_sun/database/model/user_DM.dart';
import 'package:todo_app_c12_online_sun/presetation/screens/home/tabs/tasks_tab/widgets/task_item.dart';

class TasksTab extends StatefulWidget {
  TasksTab({super.key});

  @override
  State<TasksTab> createState() => TasksTabState();
}

class TasksTabState extends State<TasksTab> {
  DateTime calenderSelectedDate = DateTime.now(); // 4/11/2024
  List<TodoDM> todosList = []; // empty

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    readTodosFromFireStore();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            Container(
              height: 115.h,
              color: ColorsManager.blue,
            ),
            buildCalenderTimeLine(),
          ],
        ),
        Expanded(
          child: ListView.builder(
            itemBuilder: (context, index) {
              return TaskItem(
                todo: todosList[index],
                onDeletedTask: () {
                  readTodosFromFireStore();
                },
              );
            },
            itemCount: todosList.length,
          ),
        )
      ],
    ); // rendering ui
  }

  void readTodosFromFireStore() async {
    var db = FirebaseFirestore.instance; //todo
    CollectionReference todoCollection = db
        .collection(UserDM.collectionName)
        .doc(UserDM.currentUser!.id)
        .collection(TodoDM.collectionName);
    QuerySnapshot collectionSnapShot = await todoCollection
        .where('dateTime',
            isEqualTo: calenderSelectedDate.copyWith(
              hour: 0,
              microsecond: 0,
              minute: 0,
              millisecond: 0,
              second: 0,
            ))
        .get();
    List<QueryDocumentSnapshot> documents = collectionSnapShot.docs;
    todosList = documents.map(
      (docSnapShot) {
        Map<String, dynamic> json = docSnapShot.data() as Map<String, dynamic>;
        TodoDM todo = TodoDM.fromFireStore(json);
        return todo;
      },
    ).toList();
    //
    // todosList = todosList
    //     .where(
    //       (todo) =>
    //   todo.dateTime.day == calenderSelectedDate.day &&
    //       todo.dateTime.month == calenderSelectedDate.month &&
    //       todo.dateTime.year == calenderSelectedDate.year,
    // )
    //     .toList();
    setState(() {}); // get todos based on calender selected date
  }

  // 3 / 11 /2024  h m s millS micro s

  Widget buildCalenderTimeLine() => EasyInfiniteDateTimeLine(
        firstDate: DateTime.now().subtract(const Duration(days: 365)),
        focusDate: calenderSelectedDate,
        lastDate: DateTime.now().add(const Duration(days: 365)),
        onDateChange: (selectedDate) {},
        itemBuilder: (context, date, isSelected, onTap) {
          return InkWell(
            onTap: () {
              calenderSelectedDate = date; // 3 11 2024
              readTodosFromFireStore();
            },
            child: Card(
              color: ColorsManager.white,
              elevation: 12,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '${date.day}',
                    style: isSelected
                        ? AppLightStyles.calenderSelectedItem
                        : AppLightStyles.calenderUnSelectedItem,
                  ),
                  Text(
                    date.getDayName,
                    style: isSelected
                        ? AppLightStyles.calenderSelectedItem
                        : AppLightStyles.calenderUnSelectedItem,
                  )
                ],
              ),
            ),
          );
        },
      );
}
