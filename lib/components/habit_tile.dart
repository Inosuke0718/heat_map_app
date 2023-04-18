import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class HabitTile extends StatelessWidget {
  // プロパティを宣言
  // クラスのフィールド（クラスのインスタンスが持つ変数）
  final String habitName;
  final bool habitCompleted;
  final Function(bool?)? onChanged;
  // 関数の引数としてBuildContext（ウィジェットの位置や状態を管理するクラス）
  // ?がつくことでNullを許容する
  final Function(BuildContext)? settingsTapped;
  final Function(BuildContext)? deleteTapped;
  // これはコンストラクター
  // HabitTitleクラスのインスタンスを生成するために必要
  const HabitTile({
    super.key,
    required this.habitName,
    required this.habitCompleted,
    required this.onChanged,
    required this.settingsTapped,
    required this.deleteTapped,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(16.0),
        // child: Container(
        // ここをslidebleにすることでスライドでの操作が可能に
        child: Slidable(
            endActionPane: ActionPane(
              motion: StretchMotion(),
              children: [
                // setting option
                SlidableAction(
                  onPressed: settingsTapped,
                  backgroundColor: Colors.grey.shade800,
                  icon: Icons.settings,
                  borderRadius: BorderRadius.circular(12),
                ),

                // delete option
                SlidableAction(
                  onPressed: deleteTapped,
                  backgroundColor: Colors.red.shade400,
                  icon: Icons.delete,
                  borderRadius: BorderRadius.circular(12),
                )
              ],
            ),
            child: Container(
                padding: EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(children: [
                  Checkbox(value: habitCompleted, onChanged: onChanged),
                  Text(habitName),
                ]))));
  }
}
