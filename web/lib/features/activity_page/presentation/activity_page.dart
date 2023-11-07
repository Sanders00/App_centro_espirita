// ignore_for_file: use_build_context_synchronously

import 'package:app_centro_espirita/features/work_group_page/model/model.dart';
import 'package:app_centro_espirita/features/work_group_page/widgets/dias_semana_custom_checkbox.dart';
import 'package:app_centro_espirita/features/worker_activities_page/presentation/workers.dart';
import 'package:common/features/activities/data/model/activities.dart';
import 'package:common/features/activities/data/api/list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../utils/side_menu.dart';
import '../../widgets/custom_appbar.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_field.dart';

class ActivityCrudPage extends StatefulWidget {
  const ActivityCrudPage({super.key});

  @override
  State<ActivityCrudPage> createState() => _ActivityCrudPageCrudPageState();
}

class _ActivityCrudPageCrudPageState extends State<ActivityCrudPage> {
  TextEditingController activityNameController = TextEditingController();
  TextEditingController descController = TextEditingController();

  _postActivityDialog() {
    return showDialog<void>(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Adicionar Atividade'),
          content: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width * 0.2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomTextField(
                    controller: activityNameController,
                    hintText: 'nome',
                    isPassowrd: false),
                CustomTextField(
                    controller: descController,
                    hintText: 'descrição',
                    isPassowrd: false),
                const WorkXWeekdaysCheckBoxes(),
                CustomButton(
                    function: () {
                      ActivitiesListRemoteAPIDataSource().postActivities(
                        name: activityNameController.text,
                        desc: descController.text,
                        actXWeekdays: Modular.get<SelectedWeekdays>()
                            .selectedWorkXWeekdays,
                      );
                      setState(() {
                        activityNameController.clear();
                        descController.clear();
                        Modular.get<SelectedWeekdays>()
                            .selectedWorkXWeekdays
                            .clear();
                        Navigator.pop(context, setState);
                      });
                    },
                    text: 'Adicionar'),
                CustomButton(
                    function: () {
                      activityNameController.clear();
                      descController.clear();
                      Modular.get<SelectedWeekdays>()
                          .selectedWorkXWeekdays
                          .clear();
                      Navigator.pop(context, setState);
                    },
                    text: 'Voltar')
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(context: context),
      drawer: const DrawerScreen(
        currentIndex: 2,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              width: 200,
              height: 50,
              child: CustomButton(function: _postActivityDialog, text: 'Add+'),
            ),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(width: 2)),
              width: MediaQuery.of(context).size.width * 0.7,
              height: MediaQuery.of(context).size.height * 0.7,
              child: Column(
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      decoration: const BoxDecoration(
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(20)),
                        color: Colors.green,
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text('Foto'),
                          Text('Nome da Atividade'),
                          Text('Descrição'),
                          Text(''),
                          Text('')
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 9,
                    child: FutureBuilder<List<ActivitiesModel>>(
                      future:
                          ActivitiesListRemoteAPIDataSource().getActivities(),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return const Text("Erro");
                        } else if (snapshot.hasData) {
                          final activities = snapshot.data!;
                          return ListView.builder(
                            padding: const EdgeInsets.all(5),
                            itemCount: activities.length,
                            itemBuilder: (context, index) {
                              return CustomActivityTile(
                                activitiesModel: activities[index],
                                context: context,
                              );
                            },
                          );
                        } else {
                          return const CircularProgressIndicator();
                        }
                      },
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class CustomActivityTile extends StatefulWidget {
  const CustomActivityTile(
      {super.key,
      required,
      required this.context,
      required this.activitiesModel});
  final BuildContext context;
  final ActivitiesModel activitiesModel;
  @override
  State<CustomActivityTile> createState() =>
      _CustomCustomActivityTileTileState();
}

class _CustomCustomActivityTileTileState extends State<CustomActivityTile> {
  final TextEditingController activityNameController = TextEditingController();
  final TextEditingController descController = TextEditingController();

  _updateActivityDialog(ActivitiesModel activitiesModel) {
    return showDialog<void>(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Atualizar Atividade'),
          content: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width * 0.2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomTextField(
                  controller: activityNameController,
                  hintText: 'nome',
                  isPassowrd: false,
                ),
                CustomTextField(
                  controller: descController,
                  hintText: 'descrição',
                  isPassowrd: false,
                ),
                const WorkXWeekdaysCheckBoxes(),
                CustomButton(
                    function: () {
                      ActivitiesListRemoteAPIDataSource().updateActivities(
                        name: activityNameController.text,
                        desc: descController.text,
                        id: activitiesModel.id,
                        actXWeekdays: Modular.get<SelectedWeekdays>()
                            .selectedWorkXWeekdays,
                      );
                      setState(
                        () {
                          activityNameController.clear();
                          descController.clear();
                          Modular.get<SelectedWeekdays>()
                              .selectedWorkXWeekdays
                              .clear();
                          Navigator.pop(context, setState);
                        },
                      );
                    },
                    text: 'Atualizar'),
                CustomButton(
                    function: () {
                      activityNameController.clear();
                      descController.clear();
                      Modular.get<SelectedWeekdays>()
                          .selectedWorkXWeekdays
                          .clear();
                      Navigator.pop(context, setState);
                    },
                    text: 'Voltar')
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const CircleAvatar(),
            Text(widget.activitiesModel.name),
            Text(widget.activitiesModel.desc),
            Row(children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => WorkerActivitiesCrudPage(
                          activityId: widget.activitiesModel.id,
                        ),
                      ),
                    );
                  },
                  style: const ButtonStyle(
                      backgroundColor:
                          MaterialStatePropertyAll<Color>(Colors.green)),
                  child: const Icon(Icons.add),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () {
                    _updateActivityDialog(widget.activitiesModel);
                  },
                  child: const Icon(Icons.edit),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () async {
                    ActivitiesListRemoteAPIDataSource().deleteActivities(
                      id: widget.activitiesModel.id,
                    );
                  },
                  style: const ButtonStyle(
                      backgroundColor:
                          MaterialStatePropertyAll<Color>(Colors.red)),
                  child: const Icon(Icons.delete),
                ),
              )
            ]),
          ],
        ),
        const Divider(
          thickness: 0,
        )
      ],
    );
  }
}
