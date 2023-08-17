import 'package:app_centro_espirita/Services/firebase_database_methods.dart';
import 'package:app_centro_espirita/global.dart';
import 'package:app_centro_espirita/Widgets/custom_appbar.dart';
import 'package:app_centro_espirita/Widgets/custom_button.dart';
import 'package:app_centro_espirita/Widgets/dias_semana_custom_checkbox.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class EscolherGrupo extends StatefulWidget {
  const EscolherGrupo({super.key, required this.worker});
  final Worker worker;
  @override
  State<EscolherGrupo> createState() => _EscolherGrupoState();
}

class _EscolherGrupoState extends State<EscolherGrupo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(context: context),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            widget.worker.name,
            style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
          ),
          Text(
            widget.worker.email,
            style: const TextStyle(fontSize: 20),
          ),
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(width: 2)),
            width: MediaQuery.of(context).size.width * 0.7,
            height: MediaQuery.of(context).size.height * 0.4,
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
                        Text('Nome do Grupo'),
                        Text('Dias da semana'),
                        Text('')
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 7,
                  child: StreamBuilder<List<WorkerXGrupoEstudoDB>>(
                      stream: context
                          .read<FirebaseDBMethods>()
                          .readWorkerXGrupoEstudo(workerId: widget.worker.id),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          print(snapshot.data);
                          return const Text("Erro");
                        } else if (snapshot.hasData) {
                          final grupo = snapshot.data!;
                          return ListView.builder(
                            padding: const EdgeInsets.all(5),
                            itemCount: grupo.length,
                            itemBuilder: (context, index) {
                              return Text(grupo[index].weekdayId);
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
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(width: 2)),
            width: MediaQuery.of(context).size.width * 0.7,
            height: MediaQuery.of(context).size.height * 0.4,
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
                        Text('Nome do Grupo'),
                        Text('Dias da semana'),
                        Text('')
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 7,
                  child: StreamBuilder<List<GrupoEsutdoDB>>(
                      stream:
                          context.read<FirebaseDBMethods>().readGruposEstudos(),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return const Text("Erro");
                        } else if (snapshot.hasData) {
                          final grupo = snapshot.data!;
                          return ListView.builder(
                            padding: const EdgeInsets.all(5),
                            itemCount: grupo.length,
                            itemBuilder: (context, index) {
                              return CustomTileSubToGroup(
                                worker: widget.worker,
                                grupo: grupo[index],
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
      )),
    );
  }
}

class CustomTileSubToGroup extends StatefulWidget {
  const CustomTileSubToGroup(
      {super.key, required this.grupo, required this.worker});
  final GrupoEsutdoDB grupo;
  final Worker worker;

  @override
  State<CustomTileSubToGroup> createState() => _CustomTileSubToGroupState();
}

class _CustomTileSubToGroupState extends State<CustomTileSubToGroup> {
  int _quntidadeDias(List<WeekdayDB> weekday) {
    int total = 0;
    for (var element in weekday) {
      if (element.grupoID == widget.grupo.id) {
        total++;
      }
    }
    return total;
  }

  List<Text> _getweekdays(List<WeekdayDB> weekday) {
    List<Text> text = [];
    for (var element in weekday) {
      if (element.grupoID == widget.grupo.id) {
        text.add(Text(element.weekdayname));
      }
    }
    return text;
  }

  _addWorkerXGrupoDialog() async {
    await context
        .read<FirebaseDBMethods>()
        .readWeekdaysById(grupoId: widget.grupo.id);
    weekdaysGlobal.forEach(
      (key, value) {
        if (!value) {
          weekdaysavailableGlobal[key] = value;
        }
      },
    );
    // ignore: use_build_context_synchronously
    return showDialog<void>(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Titulo'),
            content: SizedBox(
              height: MediaQuery.of(context).size.height * 0.7,
              width: MediaQuery.of(context).size.width * 0.2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const WeekdaysCustomCheckbox(
                      title: 'Escolha os dias da semana:'),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      CustomButton(
                          function: () {
                            setState(() {
                              _addTrabalhadorXGrupo(
                                  grupoId: widget.grupo.id,
                                  workerId: widget.worker.id);
                              resetweekdaysavailableGlobal();
                              resetWeekdaysGlobal();
                              Navigator.pop(context);
                            });
                          },
                          text: 'Adicionar'),
                      CustomButton(
                          function: () {
                            resetweekdaysavailableGlobal();
                            resetWeekdaysGlobal();
                            Navigator.pop(context);
                          },
                          text: 'Voltar')
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }

  void _addTrabalhadorXGrupo(
      {required String grupoId, required String workerId}) {
    context.read<FirebaseDBMethods>().createWorkerXGrupoEstudo(
        grupoId: grupoId, workerId: workerId, context: context);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(widget.grupo.nameGrupo),
            StreamBuilder<List<WeekdayDB>>(
                stream: context.read<FirebaseDBMethods>().readWeekdays(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return const Text("Erro");
                  } else if (snapshot.hasData) {
                    final weekday = snapshot.data!;
                    return SizedBox(
                      width: 100,
                      height: 100,
                      child: ListView.builder(
                        itemCount: _quntidadeDias(weekday),
                        itemBuilder: (context, index) {
                          return _getweekdays(weekday)[index];
                        },
                      ),
                    );
                  } else {
                    return const CircularProgressIndicator();
                  }
                }),
            ElevatedButton(
              onPressed: () {
                _addWorkerXGrupoDialog();
              },
              style: const ButtonStyle(
                  backgroundColor:
                      MaterialStatePropertyAll<Color>(Colors.green)),
              child: const Icon(Icons.add),
            ),
          ],
        ),
        const Divider(
          thickness: 0,
        ),
      ],
    );
  }
}

/*class CustomTileMySubbedGroups extends StatefulWidget {
  const CustomTileMySubbedGroups({super.key});

  @override
  State<CustomTileMySubbedGroups> createState() =>
      _CustomTileMySubbedGroupsState();
}

class _CustomTileMySubbedGroupsState extends State<CustomTileMySubbedGroups> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(''),
            StreamBuilder<List<WeekdayDB>>(
                stream: context.read<FirebaseDBMethods>().re(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return const Text("Erro");
                  } else if (snapshot.hasData) {
                    final weekday = snapshot.data!;
                    return SizedBox(
                      width: 100,
                      height: 100,
                      child: ListView.builder(
                        itemCount: _quntidadeDias(weekday),
                        itemBuilder: (context, index) {
                          return _getweekdays(weekday)[index];
                        },
                      ),
                    );
                  } else {
                    return const CircularProgressIndicator();
                  }
                }),
            ElevatedButton(
              onPressed: () {},
              style: const ButtonStyle(
                  backgroundColor:
                      MaterialStatePropertyAll<Color>(Colors.green)),
              child: const Icon(Icons.add),
            ),
          ],
        ),
        const Divider(
          thickness: 0,
        ),
      ],
    );
  }
}
*/