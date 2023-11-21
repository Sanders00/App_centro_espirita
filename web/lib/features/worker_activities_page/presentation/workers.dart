// ignore_for_file: use_build_context_synchronously

import 'dart:math';

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
  TextEditingController searchWorkerController = TextEditingController();
  TextEditingController searchRegisteredController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gerenciamento de Trabalhadores'),
        backgroundColor: Colors.green,
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.46,
              height: MediaQuery.of(context).size.height * 0.85,
              decoration: BoxDecoration(color: Colors.white, boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0, 3),
                )
              ]),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width * 0.025),
                        child: const Text(
                          'Inserir Trabalhadores',
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                        width: MediaQuery.of(context).size.width * 0.42,
                        child: const Divider()),
                    SizedBox(
                      //padding: const EdgeInsets.all(8),
                      width: MediaQuery.of(context).size.width * 0.42,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            width: 200,
                            height: 50,
                            child: TextField(
                                onChanged: (value) => setState(() {}),
                                controller: searchWorkerController,
                                decoration: const InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.green, width: 2),
                                  ),
                                  border: OutlineInputBorder(),
                                  labelText: 'Procurar Trabalhador',
                                  suffixIcon: Icon(Icons.search),
                                )),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      width: MediaQuery.of(context).size.width * 0.42,
                      height: MediaQuery.of(context).size.height * 0.7,
                      child: Column(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Container(
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(5)),
                                color: Colors.green,
                              ),
                              child: const Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Foto',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Nome',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Email',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Telefone',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Ações',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 9,
                            child: FutureBuilder<List<WorkerModel>>(
                                future: WorkerListRemoteAPIDataSource()
                                    .getWorkersMinusActivity(),
                                builder: (context, snapshot) {
                                  if (snapshot.hasError) {
                                    return const Text("Erro");
                                  } else if (snapshot.hasData) {
                                    final workers = snapshot.data!;
                                    return ListView.builder(
                                      padding: const EdgeInsets.all(5),
                                      itemCount: workers.length,
                                      itemBuilder: (context, index) {
                                        var worker = workers[index];
                                        if (worker.name.toLowerCase().contains(
                                            searchWorkerController.text
                                                .toLowerCase())) {
                                          return CustomWorkerTile(
                                            activityId: widget.activityId,
                                            worker: workers[index],
                                            context: context,
                                          );
                                        } else {
                                          return Container();
                                        }
                                      },
                                    );
                                  } else {
                                    return SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.25,
                                        child:
                                            const CircularProgressIndicator());
                                  }
                                }),
                          ),
                        ],
                      ),
                    ),
                  ]),
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.46,
              height: MediaQuery.of(context).size.height * 0.85,
              decoration: BoxDecoration(color: Colors.white, boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0, 3),
                )
              ]),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width * 0.025),
                        child: const Text(
                          'Gerenciar Trabalhadores',
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                        width: MediaQuery.of(context).size.width * 0.42,
                        child: const Divider()),
                    SizedBox(
                      //padding: const EdgeInsets.all(8),
                      width: MediaQuery.of(context).size.width * 0.42,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            width: 200,
                            height: 50,
                            child: TextField(
                                onChanged: (value) => setState(() {}),
                                controller: searchRegisteredController,
                                decoration: const InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.green, width: 2),
                                  ),
                                  border: OutlineInputBorder(),
                                  labelText: 'Procurar Trabalhador',
                                  suffixIcon: Icon(Icons.search),
                                )),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      width: MediaQuery.of(context).size.width * 0.42,
                      height: MediaQuery.of(context).size.height * 0.7,
                      child: Column(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Container(
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(5)),
                                color: Colors.green,
                              ),
                              child: const Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Foto',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Nome',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Email',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Telefone',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Dias disponiveis',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Ações',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 9,
                            child: FutureBuilder<List<WorkerModel>>(
                                future:
                                    WorkerXActivitiesListRemoteAPIDataSource()
                                        .getWorkersXActivities(
                                            id: widget.activityId),
                                builder: (context, snapshot) {
                                  if (snapshot.hasError) {
                                    return const Text("Erro");
                                  } else if (snapshot.hasData) {
                                    final workers = snapshot.data!;
                                    return ListView.builder(
                                      padding: const EdgeInsets.all(5),
                                      itemCount: workers.length,
                                      itemBuilder: (context, index) {
                                        var worker = workers[index];
                                        if (worker.name.toLowerCase().contains(
                                            searchRegisteredController.text
                                                .toLowerCase())) {
                                          return CustomInsertedWorkerTile(
                                            activityId: widget.activityId,
                                            worker: workers[index],
                                            context: context,
                                          );
                                        } else {
                                          return Container();
                                        }
                                      },
                                    );
                                  } else {
                                    return SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.25,
                                        child:
                                            const CircularProgressIndicator());
                                  }
                                }),
                          ),
                        ],
                      ),
                    )
                  ]),
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
                                  workerId: widget.worker.id,
                                  activityXweekId:
                                      Modular.get<SelectedWeekdays>()
                                          .selectedWorkXActivity);
                          setState(() {
                            Modular.get<SelectedWeekdays>()
                                .selectedWorkXWeekdays
                                .clear();
                            Modular.get<SelectedWeekdays>()
                                .selectedWorkXActivity
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
                              .selectedWorkXActivity
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
            Expanded(
              child: Column(
                children: [
                  CircleAvatar(
                    backgroundColor: Color.fromARGB(
                      255,
                      Random().nextInt(255),
                      Random().nextInt(255),
                      Random().nextInt(255),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  Text(widget.worker.name),
                ],
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  Text(widget.worker.email),
                ],
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  Text(widget.worker.phone),
                ],
              ),
            ),
            Expanded(
              child: Column(children: [
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
            ),
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
                                  workerId: widget.worker.id,
                                  activityXweekId:
                                      Modular.get<SelectedWeekdays>()
                                          .selectedWorkXActivity);
                          setState(() {
                            Modular.get<SelectedWeekdays>()
                                .selectedWorkXWeekdays
                                .clear();
                            Modular.get<SelectedWeekdays>()
                                .selectedWorkXActivity
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
                              .selectedWorkXActivity
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
            Expanded(
              child: Column(
                children: [
                  CircleAvatar(
                    backgroundColor: Color.fromARGB(
                      255,
                      Random().nextInt(255),
                      Random().nextInt(255),
                      Random().nextInt(255),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  Text(widget.worker.name),
                ],
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  Text(widget.worker.email),
                ],
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  Text(widget.worker.phone),
                ],
              ),
            ),
            Expanded(
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.075,
                width: MediaQuery.of(context).size.width * 0.2,
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
                        final firstIndex =
                            positionsOfWeekDaysGlobal[first] ?? 8;
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
            ),
            Expanded(
              flex: 2,
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
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
            ),
          ],
        ),
        const Divider(
          thickness: 0,
        )
      ],
    );
  }
}
