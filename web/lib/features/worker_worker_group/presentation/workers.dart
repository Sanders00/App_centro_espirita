// ignore_for_file: use_build_context_synchronously

import 'package:app_centro_espirita/features/widgets/custom_button.dart';
import 'package:app_centro_espirita/features/work_group_page/model/model.dart';
import 'package:app_centro_espirita/features/worker_worker_group/widgets/dias_semana_custom_checkbox.dart';
import 'package:common/features/workers/data/api/list.dart';
import 'package:common/features/workers_x_work/data/api/list.dart';
import 'package:common/features/workers/data/model/worker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class WorkerWorkGroupCrudPage extends StatefulWidget {
  const WorkerWorkGroupCrudPage({super.key, required this.workGroupId});
  final int workGroupId;
  @override
  State<WorkerWorkGroupCrudPage> createState() =>
      _WorkerWorkGroupCrudPageState();
}

class _WorkerWorkGroupCrudPageState extends State<WorkerWorkGroupCrudPage> {
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
                                  workGroupId: widget.workGroupId,
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
                        future: WorkerXWorkGroupListRemoteAPIDataSource()
                            .getWorkersXWorkGroups(id: widget.workGroupId),
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
                                  workGroupId: widget.workGroupId,
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
      required this.workGroupId});
  final BuildContext context;
  final WorkerModel worker;
  final int workGroupId;
  @override
  State<CustomWorkerTile> createState() => _CustomWorkerTileState();
}

class _CustomWorkerTileState extends State<CustomWorkerTile> {
  _postWorkerToWorkGroupDialog() {
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
                    child: WorkerXWorkXWeekdaysCheckBoxes(
                        workGroupId: widget.workGroupId),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomButton(
                        function: () {
                          WorkerXWorkGroupListRemoteAPIDataSource()
                              .postWorkerWorkGroup(
                            workerId: widget.worker.id,
                            workGroupId: widget.workGroupId,
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
                    _postWorkerToWorkGroupDialog();
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
      required this.workGroupId});
  final BuildContext context;
  final WorkerModel worker;
  final int workGroupId;
  @override
  State<CustomInsertedWorkerTile> createState() =>
      _CustomInsertedWorkerTileState();
}

class _CustomInsertedWorkerTileState extends State<CustomInsertedWorkerTile> {
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
              width: 100,
              child: FutureBuilder<List<String>>(
                future: WorkerXWorkGroupListRemoteAPIDataSource()
                    .getWorkersAvailableWeekdays(
                        workGroupId: widget.workGroupId,
                        workerId: widget.worker.id),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return const Text("Erro");
                  } else if (snapshot.hasData) {
                    final days = snapshot.data!;
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
                  onPressed: () async {
                    WorkerXWorkGroupListRemoteAPIDataSource()
                        .deleteWorkerWorkGroup(id: widget.worker.id);
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
