// ignore_for_file: use_build_context_synchronously

import 'package:app_centro_espirita/features/widgets/custom_button.dart';
import 'package:app_centro_espirita/features/work_group_page/model/model.dart';
import 'package:app_centro_espirita/features/worker_activities_page/widgets/dias_semana_custom_checkbox.dart';
import 'package:app_centro_espirita/global.dart';
import 'package:common/features/workers/data/api/list.dart';
import 'package:common/features/workers_x_activities/data/api/list.dart';
import 'package:common/features/workers/data/model/worker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class WorkerActivitiesCrudPage extends StatefulWidget {
  const WorkerActivitiesCrudPage({super.key, required this.activityId});
  final int activityId;
  @override
  State<WorkerActivitiesCrudPage> createState() =>
      _WorkerActivitiesCrudPageState();
}

class _WorkerActivitiesCrudPageState extends State<WorkerActivitiesCrudPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gerenciamento de Trabalhadores'),
        backgroundColor: Colors.green,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Inserir Trabalhadores',
              style: TextStyle(fontSize: 30),
            ),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(width: 2)),
              width: MediaQuery.of(context).size.width * 0.7,
              height: MediaQuery.of(context).size.height * 0.35,
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
                          Text('Nome'),
                          Text('Email'),
                          Text('Telefone'),
                          Text(''),
                          Text('')
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 9,
                    child: FutureBuilder<List<WorkerModel>>(
                        future: WorkerListRemoteAPIDataSource().getWorkers(),
                        builder: (context, snapshot) {
                          if (snapshot.hasError) {
                            return const Text("Erro");
                          } else if (snapshot.hasData) {
                            final workers = snapshot.data!;
                            return ListView.builder(
                              padding: const EdgeInsets.all(5),
                              itemCount: workers.length,
                              itemBuilder: (context, index) {
                                return CustomWorkerTile(
                                  activityId: widget.activityId,
                                  worker: workers[index],
                                  context: context,
                                );
                              },
                            );
                          } else {
                            return const CircularProgressIndicator();
                          }
                        }),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'Gerenciar Trabalhadores',
              style: TextStyle(fontSize: 30),
            ),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(width: 2)),
              width: MediaQuery.of(context).size.width * 0.7,
              height: MediaQuery.of(context).size.height * 0.35,
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
                          Text('Nome'),
                          Text('Email'),
                          Text('Telefone'),
                          Text(''),
                          Text('')
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 9,
                    child: FutureBuilder<List<WorkerModel>>(
                        future: WorkerXActivitiesListRemoteAPIDataSource()
                            .getWorkersXActivities(id: widget.activityId),
                        builder: (context, snapshot) {
                          if (snapshot.hasError) {
                            return const Text("Erro");
                          } else if (snapshot.hasData) {
                            final workers = snapshot.data!;
                            return ListView.builder(
                              padding: const EdgeInsets.all(5),
                              itemCount: workers.length,
                              itemBuilder: (context, index) {
                                return CustomInsertedWorkerTile(
                                  activityId: widget.activityId,
                                  worker: workers[index],
                                  context: context,
                                );
                              },
                            );
                          } else {
                            return const CircularProgressIndicator();
                          }
                        }),
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

class CustomWorkerTile extends StatefulWidget {
  const CustomWorkerTile(
      {super.key,
      required,
      required this.context,
      required this.worker,
      required this.activityId});
  final BuildContext context;
  final WorkerModel worker;
  final int activityId;
  @override
  State<CustomWorkerTile> createState() => _CustomWorkerTileState();
}

class _CustomWorkerTileState extends State<CustomWorkerTile> {
  _postWorkerToActivityDialog() {
    return showDialog<void>(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          scrollable: true,
          title: const Text('Dias Disponíveis'),
          content: SingleChildScrollView(
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: WorkerXActivitiesXWeekdaysCheckBoxes(
                        activityId: widget.activityId),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomButton(
                        function: () {
                          WorkerXActivitiesListRemoteAPIDataSource()
                              .postWorkerActivities(
                                  activityId: widget.activityId,
                                  workerId: widget.worker.id,
                                  availableWeekdays:
                                      Modular.get<SelectedWeekdays>()
                                          .selectedWorkXWeekdaysString);
                          setState(() {
                            Modular.get<SelectedWeekdays>()
                                .selectedWorkXWeekdays
                                .clear();
                            Modular.get<SelectedWeekdays>()
                                .selectedWorkXWeekdaysString
                                .clear();
                            Navigator.pop(context, setState);
                          });
                        },
                        text: 'Adicionar'),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomButton(
                        function: () {
                          Modular.get<SelectedWeekdays>()
                              .selectedWorkXWeekdays
                              .clear();
                          Modular.get<SelectedWeekdays>()
                              .selectedWorkXWeekdaysString
                              .clear();
                          Navigator.pop(context, setState);
                        },
                        text: 'Voltar'),
                  ),
                ],
              ),
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
            Text(widget.worker.name),
            Text(widget.worker.email),
            Text(widget.worker.phone),
            Row(children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () {
                    _postWorkerToActivityDialog();
                  },
                  style: const ButtonStyle(
                      backgroundColor:
                          MaterialStatePropertyAll<Color>(Colors.green)),
                  child: const Icon(Icons.add),
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

class CustomInsertedWorkerTile extends StatefulWidget {
  const CustomInsertedWorkerTile(
      {super.key,
      required,
      required this.context,
      required this.worker,
      required this.activityId});
  final BuildContext context;
  final WorkerModel worker;
  final int activityId;
  @override
  State<CustomInsertedWorkerTile> createState() =>
      _CustomInsertedWorkerTileState();
}

class _CustomInsertedWorkerTileState extends State<CustomInsertedWorkerTile> {
  _updateWorkerToActivityDialog() {
    return showDialog<void>(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          scrollable: true,
          title: const Text('Dias Disponíveis'),
          content: SingleChildScrollView(
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: WorkerXActivitiesXWeekdaysCheckBoxes(
                        activityId: widget.activityId),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomButton(
                        function: () {
                          WorkerXActivitiesListRemoteAPIDataSource()
                              .updateWorkerActivities(
                            activityId: widget.activityId,
                            workerId: widget.worker.id,
                            availableWeekdays: Modular.get<SelectedWeekdays>()
                                .selectedWorkXWeekdaysString,
                          );
                          setState(() {
                            Modular.get<SelectedWeekdays>()
                                .selectedWorkXWeekdays
                                .clear();
                            Modular.get<SelectedWeekdays>()
                                .selectedWorkXWeekdaysString
                                .clear();
                            Navigator.pop(context, setState);
                          });
                        },
                        text: 'Atualizar'),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomButton(
                        function: () {
                          Modular.get<SelectedWeekdays>()
                              .selectedWorkXWeekdays
                              .clear();
                          Modular.get<SelectedWeekdays>()
                              .selectedWorkXWeekdaysString
                              .clear();
                          Navigator.pop(context, setState);
                        },
                        text: 'Voltar'),
                  ),
                ],
              ),
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
            Text(widget.worker.name),
            Text(widget.worker.email),
            Text(widget.worker.phone),
            SizedBox(
              height: 50,
              width: 120,
              child: FutureBuilder<List<String>>(
                future: WorkerXActivitiesListRemoteAPIDataSource()
                    .getWorkersAvailableWeekdays(
                        activityId: widget.activityId,
                        workerId: widget.worker.id),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return const Text("Erro");
                  } else if (snapshot.hasData) {
                    final days = snapshot.data!;
                    days.sort((first, second) {
                      final firstIndex = positionsOfWeekDaysGlobal[first] ?? 8;
                      final secondIndex =
                          positionsOfWeekDaysGlobal[second] ?? 8;
                      return firstIndex.compareTo(secondIndex);
                    });
                    return ListView.builder(
                      padding: const EdgeInsets.all(5),
                      itemCount: days.length,
                      itemBuilder: (context, index) {
                        return Row(
                          children: [
                            const Icon(
                              Icons.circle,
                              size: 10,
                            ),
                            Text(days[index])
                          ],
                        );
                      },
                    );
                  } else {
                    return const CircularProgressIndicator();
                  }
                },
              ),
            ),
            Row(children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () {
                    _updateWorkerToActivityDialog();
                  },
                  child: const Icon(Icons.edit),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () async {
                    WorkerXActivitiesListRemoteAPIDataSource()
                        .deleteWorkerActivities(id: widget.worker.id);
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
