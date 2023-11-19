import 'package:app_centro_espirita/features/work_group_page/model/model.dart';
import 'package:common/features/schedule/data/api/list.dart';
import 'package:common/features/activities_x_weekdays/data/api/list.dart';
import 'package:common/features/schedule/data/model/schedule.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class WorkerXActivitiesXWeekdaysCheckBoxes extends StatefulWidget {
  const WorkerXActivitiesXWeekdaysCheckBoxes(
      {super.key, required this.activityId});
  final int activityId;
  @override
  _WorkerXActivitiesXWeekdaysCheckBoxesState createState() =>
      _WorkerXActivitiesXWeekdaysCheckBoxesState();
}

class _WorkerXActivitiesXWeekdaysCheckBoxesState
    extends State<WorkerXActivitiesXWeekdaysCheckBoxes> {
  late Future<List<ScheduleModel>> availableweekdaysFuture;

  List<dynamic> selectedWorkXWeekdays =
      Modular.get<SelectedWeekdays>().selectedWorkXWeekdays;

  List<dynamic> selectedWorkXActivity =
      Modular.get<SelectedWeekdays>().selectedWorkXActivity;

  final Future<List<ScheduleModel>> weekdaysFuture =
      ScheduleListRemoteAPIDataSource().getWeekdays();

  @override
  void initState() {
    super.initState();
    availableweekdaysFuture = ActivitiesXScheduleListRemoteAPIDataSource()
        .getActivitiesXWeekdays(id: widget.activityId);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ScheduleModel>>(
      future: availableweekdaysFuture,
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
                        selectedWorkXActivity.add(day.activityXweekId);
                        print(day.activityXweekId);
                      } else {
                        selectedWorkXWeekdays.remove(day.id);
                        selectedWorkXActivity.remove(day.activityXweekId);
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
