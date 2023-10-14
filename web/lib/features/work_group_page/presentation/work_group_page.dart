// ignore_for_file: use_build_context_synchronously

import 'package:common/features/work_group/data/api/list.dart';
import 'package:common/features/work_group/data/model/work_group.dart';
import 'package:flutter/material.dart';

import '../../utils/side_menu.dart';
import '../../widgets/custom_appbar.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_field.dart';

class WorkGroupCrudPage extends StatefulWidget {
  const WorkGroupCrudPage({super.key});

  @override
  State<WorkGroupCrudPage> createState() => _WorkerCrudPageState();
}

class _WorkerCrudPageState extends State<WorkGroupCrudPage> {
  TextEditingController groupNameController = TextEditingController();
  TextEditingController descController = TextEditingController();

  _postWorkGroupDialog() {
    return showDialog<void>(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Adicionar Trabalhador'),
            content: SizedBox(
              height: MediaQuery.of(context).size.height * 0.5,
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
                  CustomButton(
                      function: () {
                        WorkGroupListRemoteAPIDataSource().postWorkGroups(
                          name: groupNameController.text,
                          desc: descController.text,
                        );
                        setState(() {
                          groupNameController.clear();
                          descController.clear();
                          Navigator.pop(context, setState);
                        });
                      },
                      text: 'Adicionar'),
                  CustomButton(
                      function: () {
                        groupNameController.clear();
                        descController.clear();
                        Navigator.pop(context, setState);
                      },
                      text: 'Voltar')
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(context: context),
      drawer: const DrawerScreen(
        currentIndex: 1,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              width: 200,
              height: 50,
              child: CustomButton(function: _postWorkGroupDialog, text: 'Add+'),
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
                          Text('Nome do Grupo'),
                          Text('Descrição'),
                          Text(''),
                          Text('')
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
                              return CustomWorkGroupTile(
                                workGroupModel: groups[index],
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
            height: MediaQuery.of(context).size.height * 0.5,
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
                CustomButton(
                    function: () {
                      WorkGroupListRemoteAPIDataSource().updateWorkGroups(
                        id: workGroupModel.id,
                        name: groupNameController.text,
                        desc: descController.text,
                      );
                      setState(
                        () {
                          groupNameController.clear();
                          descController.clear();
                          Navigator.pop(context, setState);
                        },
                      );
                    },
                    text: 'Atualizar'),
                CustomButton(
                    function: () {
                      groupNameController.clear();
                      descController.clear();
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
            Text(widget.workGroupModel.name),
            Text(widget.workGroupModel.desc),
            Row(children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () {},
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
                    _updateWorkGroupDialog(widget.workGroupModel);
                  },
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
        const Divider(
          thickness: 0,
        )
      ],
    );
  }
}
