// ignore_for_file: use_build_context_synchronously

import 'package:common/features/workers/data/api/list.dart';
import 'package:common/features/workers/data/model/worker.dart';
import 'package:flutter/material.dart';

import '../../utils/side_menu.dart';
import '../../widgets/custom_appbar.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_field.dart';

class WorkerCrudPage extends StatefulWidget {
  const WorkerCrudPage({super.key});

  @override
  State<WorkerCrudPage> createState() => _WorkerCrudPageState();
}

class _WorkerCrudPageState extends State<WorkerCrudPage> {
  TextEditingController nomeController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController whatsController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  _postWorkerDialog() {
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
                      controller: nomeController,
                      hintText: 'nome',
                      isPassowrd: false),
                  CustomTextField(
                      controller: emailController,
                      hintText: 'email',
                      isPassowrd: false),
                  CustomTextField(
                      controller: phoneController,
                      hintText: 'telefone',
                      isPassowrd: false),
                  CustomTextField(
                      controller: whatsController,
                      hintText: 'whatsapp',
                      isPassowrd: false),
                  CustomButton(
                      function: () {
                        WorkerListRemoteAPIDataSource().postWorkers(
                          name: nomeController.text,
                          email: emailController.text,
                          phone: phoneController.text,
                          whatsapp: whatsController.text,
                        );
                        setState(() {
                          nomeController.clear();
                          emailController.clear();
                          phoneController.clear();
                          whatsController.clear();
                          Navigator.pop(context, setState);
                        });
                      },
                      text: 'Adicionar'),
                  CustomButton(
                      function: () {
                        nomeController.clear();
                        emailController.clear();
                        phoneController.clear();
                        whatsController.clear();
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
              child: CustomButton(function: _postWorkerDialog, text: 'Add+'),
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
      {super.key, required, required this.context, required this.worker});
  final BuildContext context;
  final WorkerModel worker;
  @override
  State<CustomWorkerTile> createState() => _CustomWorkerTileState();
}

class _CustomWorkerTileState extends State<CustomWorkerTile> {
  final TextEditingController nomeController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController whatsController = TextEditingController();

  _updateWorkerDialog(WorkerModel worker) {
    return showDialog<void>(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Atualizar Trabalhador'),
          content: SizedBox(
            height: MediaQuery.of(context).size.height * 0.5,
            width: MediaQuery.of(context).size.width * 0.2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomTextField(
                  controller: nomeController,
                  hintText: 'nome',
                  isPassowrd: false,
                ),
                CustomTextField(
                  controller: emailController,
                  hintText: 'email',
                  isPassowrd: false,
                ),
                CustomTextField(
                  controller: phoneController,
                  hintText: 'telefone',
                  isPassowrd: false,
                ),
                CustomTextField(
                  controller: whatsController,
                  hintText: 'whatsapp',
                  isPassowrd: false,
                ),
                CustomButton(
                    function: () {
                      WorkerListRemoteAPIDataSource().updateWorkers(
                        id: worker.id,
                        name: nomeController.text,
                        email: emailController.text,
                        phone: phoneController.text,
                        whatsapp: whatsController.text,
                      );
                      setState(
                        () {
                          nomeController.clear();
                          emailController.clear();
                          phoneController.clear();
                          whatsController.clear();
                          Navigator.pop(context, setState);
                        },
                      );
                    },
                    text: 'Atualizar'),
                CustomButton(
                    function: () {
                      nomeController.clear();
                      emailController.clear();
                      phoneController.clear();
                      whatsController.clear();
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
            Text(widget.worker.name),
            Text(widget.worker.email),
            Text(widget.worker.phone),
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
                    _updateWorkerDialog(widget.worker);
                  },
                  child: const Icon(Icons.edit),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () async {
                    WorkerListRemoteAPIDataSource().deleteWorkers(
                      id: widget.worker.id,
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
