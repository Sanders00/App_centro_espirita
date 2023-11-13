// ignore_for_file: use_build_context_synchronously

import 'dart:math';

import 'package:app_centro_espirita/features/work_group_page/widgets/dias_semana_custom_checkbox.dart';
import 'package:app_centro_espirita/features/work_group_page/model/model.dart';
import 'package:app_centro_espirita/features/worker_worker_group/presentation/workers.dart';
import 'package:common/features/work_group/data/api/list.dart';
import 'package:common/features/work_group/data/model/work_group.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../utils/side_menu.dart';
import '../../widgets/custom_appbar.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_field.dart';

class WorkGroupCrudPage extends StatefulWidget {
  const WorkGroupCrudPage({super.key});

  @override
  State<WorkGroupCrudPage> createState() => _WorkGroupCrudPageState();
}

class _WorkGroupCrudPageState extends State<WorkGroupCrudPage> {
  TextEditingController groupNameController = TextEditingController();
  TextEditingController descController = TextEditingController();
  TextEditingController searchController = TextEditingController();

  _postWorkGroupDialog() {
    return showDialog<void>(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Adicionar Grupo'),
          content: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width * 0.2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomTextField(
                    controller: groupNameController,
                    hintText: 'nome',
                    isPassowrd: false),
                CustomTextField(
                    controller: descController,
                    hintText: 'descrição',
                    isPassowrd: false),
                const WorkXWeekdaysCheckBoxes(),
                CustomButton(
                    function: () {
                      WorkGroupListRemoteAPIDataSource().postWorkGroups(
                        name: groupNameController.text,
                        desc: descController.text,
                        workXWeekdays: Modular.get<SelectedWeekdays>()
                            .selectedWorkXWeekdays,
                      );
                      setState(() {
                        groupNameController.clear();
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
                      groupNameController.clear();
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
        currentIndex: 1,
      ),
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.8,
          height: MediaQuery.of(context).size.height * 0.8,
          decoration: BoxDecoration(color: Colors.white, boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3),
            )
          ]),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width * 0.025),
                  child: const Text(
                    'Grupos de estudo',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(
                  width: MediaQuery.of(context).size.width * 0.75,
                  child: const Divider()),
              SizedBox(
                //padding: const EdgeInsets.all(8),
                width: MediaQuery.of(context).size.width * 0.75,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      width: 200,
                      height: 50,
                      child: TextField(
                          onChanged: (value) => setState(() {}),
                          controller: searchController,
                          decoration: const InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.green, width: 2),
                            ),
                            border: OutlineInputBorder(),
                            labelText: 'Procurar Grupo',
                            suffixIcon: Icon(Icons.search),
                          )),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      width: 200,
                      height: 50,
                      child: CustomButton(
                          function: _postWorkGroupDialog,
                          text: 'Adicionar Grupo'),
                    ),
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                ),
                width: MediaQuery.of(context).size.width * 0.75,
                height: MediaQuery.of(context).size.height * 0.6,
                child: Column(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                        decoration: const BoxDecoration(
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(5)),
                          color: Colors.green,
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Foto',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Nome do Grupo',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Descrição',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Ações',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
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
                      child: FutureBuilder<List<WorkGroupModel>>(
                        future:
                            WorkGroupListRemoteAPIDataSource().getWorkGroups(),
                        builder: (context, snapshot) {
                          if (snapshot.hasError) {
                            return const Text("Erro");
                          } else if (snapshot.hasData) {
                            final groups = snapshot.data!;
                            return ListView.builder(
                              padding: const EdgeInsets.all(5),
                              itemCount: groups.length,
                              itemBuilder: (context, index) {
                                final group = groups[index];
                                if (group.name.toLowerCase().contains(
                                    searchController.text.toLowerCase())) {
                                  return CustomWorkGroupTile(
                                    workGroupModel: groups[index],
                                    context: context,
                                  );
                                }
                                return Container();
                              },
                            );
                          } else {
                            return SizedBox(
                                width: MediaQuery.of(context).size.width * 0.25,
                                child: const CircularProgressIndicator());
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
      ),
    );
  }
}

class CustomWorkGroupTile extends StatefulWidget {
  const CustomWorkGroupTile(
      {super.key,
      required,
      required this.context,
      required this.workGroupModel});
  final BuildContext context;
  final WorkGroupModel workGroupModel;
  @override
  State<CustomWorkGroupTile> createState() => _CustomWorkerTileState();
}

class _CustomWorkerTileState extends State<CustomWorkGroupTile> {
  final TextEditingController groupNameController = TextEditingController();
  final TextEditingController descController = TextEditingController();

  _updateWorkGroupDialog(WorkGroupModel workGroupModel) {
    return showDialog<void>(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Atualizar Grupo'),
          content: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width * 0.2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomTextField(
                  controller: groupNameController,
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
                      WorkGroupListRemoteAPIDataSource().updateWorkGroups(
                        id: workGroupModel.id,
                        name: groupNameController.text,
                        desc: descController.text,
                        workXWeekdays: Modular.get<SelectedWeekdays>()
                            .selectedWorkXWeekdays,
                      );
                      setState(
                        () {
                          groupNameController.clear();
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
                      groupNameController.clear();
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
                  Text(widget.workGroupModel.name),
                ],
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  Text(widget.workGroupModel.desc),
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: Column(
                children: [
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => WorkerWorkGroupCrudPage(
                                  workGroupId: widget.workGroupModel.id),
                            ),
                          );
                        },
                        child: const Icon(Icons.add),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        onPressed: () {
                          _updateWorkGroupDialog(widget.workGroupModel);
                        },
                        style: const ButtonStyle(
                            backgroundColor:
                                MaterialStatePropertyAll<Color>(Colors.blue)),
                        child: const Icon(Icons.edit),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        onPressed: () async {
                          WorkGroupListRemoteAPIDataSource().deleteWorkGroups(
                            id: widget.workGroupModel.id,
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
