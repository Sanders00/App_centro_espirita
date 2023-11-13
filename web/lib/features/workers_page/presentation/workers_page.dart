// ignore_for_file: use_build_context_synchronously

import 'dart:math';

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
  TextEditingController searchController = TextEditingController();

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
        currentIndex: 0,
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
                  child: const Text('Trabalhadores',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      )),
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
                            labelText: 'Procurar Trabalhador',
                            suffixIcon: Icon(Icons.search),
                          )),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      width: 200,
                      height: 50,
                      child: CustomButton(
                          function: _postWorkerDialog,
                          text: 'Adicionar Trabalhador'),
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
                                    'Nome',
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
                                    'Email',
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
                                    'Telefone',
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
                                  final worker = workers[index];
                                  if (worker.name.toLowerCase().contains(
                                      searchController.text.toLowerCase())) {
                                    return CustomWorkerTile(
                                      worker: workers[index],
                                      context: context,
                                    );
                                  }
                                  return Container();
                                },
                              );
                            } else {
                              return SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.25,
                                  child: const CircularProgressIndicator());
                            }
                          }),
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
              flex: 2,
              child: Column(
                children: [
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        onPressed: () {
                          _updateWorkerDialog(widget.worker);
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
