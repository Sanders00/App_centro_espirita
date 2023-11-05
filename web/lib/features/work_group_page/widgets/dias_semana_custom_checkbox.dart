import 'package:app_centro_espirita/features/work_group_page/model/model.dart';
import 'package:common/features/schedule/data/api/list.dart';
import 'package:common/features/schedule/data/model/schedule.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class WorkXWeekdaysCheckBoxes extends StatefulWidget {
  const WorkXWeekdaysCheckBoxes({super.key});

  @override
  _WorkXWeekdaysCheckBoxesState createState() =>
      _WorkXWeekdaysCheckBoxesState();
}

class _WorkXWeekdaysCheckBoxesState extends State<WorkXWeekdaysCheckBoxes> {
  List<dynamic> selectedWorkXWeekdays =
      Modular.get<SelectedWeekdays>().selectedWorkXWeekdays;

  final Future<List<ScheduleModel>> weekdaysFuture =
      ScheduleListRemoteAPIDataSource().getWeekdays();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ScheduleModel>>(
      future: weekdaysFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Erro: ${snapshot.error}');
        } else if (snapshot.hasData) {
          List<ScheduleModel> weekdays = snapshot.data!;
          return Column(
            children: weekdays.map((day) {
              return SizedBox(
                height: MediaQuery.of(context).size.height * 0.06,
                child: CheckboxListTile(
                  title: Text(day.weekday),
                  value: selectedWorkXWeekdays.contains(day.id),
                  onChanged: (bool? value) {
                    setState(() {
                      if (value != null && value) {
                        selectedWorkXWeekdays.add(day.id);
                      } else {
                        selectedWorkXWeekdays.remove(day.id);
                      }
                    });
                  },
                ),
              );
            }).toList(),
          );
        } else {
          return const Text('Nenhum dado disponível');
        }
      },
    );
  }
}