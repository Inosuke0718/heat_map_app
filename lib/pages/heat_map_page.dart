import 'package:flutter/material.dart';
import 'package:heat_map_app/components/habit_tile.dart';
import 'package:hive/hive.dart';

import '../components/month_summary.dart';
import '../components/my_fad.dart';
import '../components/my_alert_box.dart';
import '../data/habit_database.dart';

import 'heat_map_page.dart';
import 'setting_page.dart';

class HeatMapPage extends StatefulWidget {
  const HeatMapPage({super.key});

  @override
  State<HeatMapPage> createState() => _HomePageState();
}

class _HomePageState extends State<HeatMapPage> {
  HabitDatabase db = HabitDatabase();
  final _myBox = Hive.box("Habit_Database");
  final _durationController = TextEditingController();
  // int get duration => int.tryParse(_durationController.text) ?? 30;
  late int duration;
  int _selectedIndex = 0;

  @override
  void initState() {
    duration = _myBox.get("DURATION") == null ? 30 : _myBox.get('DURATION');
    //  if there is no current habit list, then it is the 1st time ever opening the app
    // then create default data
    if (_myBox.get("CURRENT_HABIT_LIST") == null) {
      db.createDefaultData();

      // there already exists data, this is not the first time
    } else {
      db.loadData();
    }

    // update the database
    db.updateDatabase();

    super.initState();
  }

  // これは関数setStateメソッドで状態を更新している
  void checkBoxTapped(bool? value, index) {
    setState(() {
      db.todaysHabitList[index][1] = value;
    });
    db.updateDatabase();
  }

  // create a new habit(task)
  // テキスト入力ウィジェット（例えばTextFieldやTextFormField）で使用される、テキスト入力を管理するためのクラスです。
  final _newHabitNameController = TextEditingController();
  void creatNewHabit() {
    showDialog(
      context: context,
      builder: (context) {
        return MyAlertBox(
          controller: _newHabitNameController,
          hintText: 'Enter Habit Name',
          onSave: saveNewHabit,
          onCancel: cancelDialogBox,
        );
      },
    );
  }

  // save new habit
  void saveNewHabit() {
    // add new habit to todays habit list
    setState(() {
      db.todaysHabitList.add([_newHabitNameController.text, false]);
    });
    _newHabitNameController.clear();
    // 前の画面に戻る
    Navigator.of(context).pop();

    db.updateDatabase();
  }

  void cancelDialogBox() {
    // もしこの記述がないとCancelを押しても残ってしまう
    _newHabitNameController.clear();
    // 前の画面に戻る
    Navigator.of(context).pop();
  }

  // open habit settings to edit
  void openHabitSettings(int index) {
    showDialog(
      context: context,
      builder: (context) {
        return MyAlertBox(
          controller: _newHabitNameController,
          // 引数に選択したリストの内容を入れてあげる
          hintText: db.todaysHabitList[index][0],
          onSave: () => saveExistingHabit(index),
          onCancel: cancelDialogBox,
        );
      },
    );
  }

  // save existing habit with a new name
  void saveExistingHabit(int index) {
    setState(() {
      db.todaysHabitList[index][0] = _newHabitNameController.text;
    });
    _newHabitNameController.clear();
    Navigator.of(context).pop();

    db.updateDatabase();
  }

  // save existing habit with a new name
  void deleteHabit(int index) {
    setState(() {
      db.todaysHabitList.removeAt(index);
    });
    db.updateDatabase();
  }

  @override
  Widget build(BuildContext context) {
    // 主要なコンテンツを表示
    return Scaffold(
      backgroundColor: Colors.black,
      floatingActionButton: MyFloatingActionButton(onPressed: creatNewHabit),
      body: ListView(children: [
        Column(
          children: [
            TextField(
              controller: _durationController,
              decoration: InputDecoration(
                labelText: 'Duration',
                hintText: 'Enter some text',
              ),
              onChanged: (value) {
                setState(() {
                  // 文字列"value"を整数値に変換
                  duration = int.tryParse(value) ?? 10;
                  _myBox.put('DURATION', duration);
                });
              },
            ),
          ],
        ),
        MonthlySummary(
          datasets: db.heatMapDataSet,
          startDate: _myBox.get("START_DATE"),
          duration: duration,
        ),

        // list of habits
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: db.todaysHabitList.length,
          itemBuilder: (context, index) {
            return HabitTile(
              habitName: db.todaysHabitList[index][0],
              habitCompleted: db.todaysHabitList[index][1],
              onChanged: (value) => checkBoxTapped(value, index),
              settingsTapped: (context) => openHabitSettings(index),
              deleteTapped: (context) => deleteHabit(index),
            );
          },
        )
      ]),
    );
  }
}
