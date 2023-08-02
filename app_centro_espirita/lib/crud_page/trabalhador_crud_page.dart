import 'package:app_centro_espirita/Utils/side_menu.dart';
import 'package:app_centro_espirita/Widgets/custom_appbar.dart';
import 'package:app_centro_espirita/services/firebase_database_methods.dart';
import 'package:app_centro_espirita/widgets/custom_button.dart';
import 'package:app_centro_espirita/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class WorkerCrudPage extends StatefulWidget {
  const WorkerCrudPage({super.key});

  @override
  State<WorkerCrudPage> createState() => _WorkerCrudPageState();
}

class _WorkerCrudPageState extends State<WorkerCrudPage> {
  TextEditingController nomeController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController telefoneController = TextEditingController();

  void _addWorkerDB() {
    context.read<FirebaseDBMethods>().createWorker(
        name: nomeController.text,
        email: emailController.text,
        telefone: telefoneController.text,
        context: context);
  }

  _addWorkerDialog() {
    return showDialog<void>(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Adicionar Trabalhador'),
            content: SizedBox(
              height: MediaQuery.of(context).size.height * 0.3,
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
                      controller: telefoneController,
                      hintText: 'telefone',
                      isPassowrd: false),
                  CustomButton(
                      function: () {
                        setState(() {
                          _addWorkerDB();
                          nomeController.clear();
                          emailController.clear();
                          telefoneController.clear();
                          Navigator.pop(context);
                        });
                      },
                      text: 'Adicionar'),
                  CustomButton(
                      function: () {
                        nomeController.clear();
                        emailController.clear();
                        telefoneController.clear();
                        Navigator.pop(context);
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
        currentIndex: 2,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(8),
              width: 200,
              height: 50,
              child: CustomButton(function: _addWorkerDialog, text: 'Add+'),
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
                          Text('')
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 9,
                    child: StreamBuilder<List<Worker>>(
                        stream: context.read<FirebaseDBMethods>().readWorkers(),
                        builder: (context, snapshot) {
                          if (snapshot.hasError) {
                            return const Text("Erro");
                          } else if (snapshot.hasData) {
                            final workers = snapshot.data!;
                            return ListView.builder(
                              padding: const EdgeInsets.all(5),
                              itemCount: workers.length,
                              itemBuilder: (context, index) {
                                return CustomTile(
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

class CustomTile extends StatefulWidget {
  const CustomTile({super.key, required this.worker, required this.context});
  final Worker worker;
  final BuildContext context;

  @override
  State<CustomTile> createState() => _CustomTileState();
}

class _CustomTileState extends State<CustomTile> {
  final TextEditingController nomeController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController telefoneController = TextEditingController();

  @override
  void dispose() {
    nomeController.dispose();
    emailController.dispose();
    telefoneController.dispose();
    super.dispose();
  }

  _updateWorker() {
    context.read<FirebaseDBMethods>().updateWorker(
        id: widget.worker.id,
        name: nomeController.text,
        email: emailController.text,
        telefone: telefoneController.text,
        context: context);
  }

  _updateWorkerDialog() {
    getSingleWorker();
    return showDialog<void>(
        barrierDismissible: false,
        context: widget.context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Editar Trabalhador'),
            content: SizedBox(
              height: MediaQuery.of(context).size.height * 0.3,
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
                      controller: telefoneController,
                      hintText: 'telefone',
                      isPassowrd: false),
                  CustomButton(
                      function: () {
                        _updateWorker();
                        Navigator.pop(context);
                      },
                      text: 'Confirmar'),
                  CustomButton(
                      function: () {
                        Navigator.pop(context);
                      },
                      text: 'Cancelar')
                ],
              ),
            ),
          );
        });
  }

  _deleteworkerDialog() {
    return showDialog<void>(
        barrierDismissible: false,
        context: widget.context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
                'Deseja mesmo excluir ${widget.worker.name} do banco de dados?'),
            content: SizedBox(
              height: MediaQuery.of(context).size.height * 0.2,
              width: MediaQuery.of(context).size.width * 0.2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CustomButton(
                      function: () {
                        context
                            .read<FirebaseDBMethods>()
                            .deleteWorker(id: widget.worker.id, context: context);
                        Navigator.pop(context);
                        
                      },
                      text: 'Excluir'),
                  CustomButton(
                      function: () {
                        Navigator.pop(context);
                      },
                      text: 'Cancelar')
                ],
              ),
            ),
          );
        });
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
            Text(widget.worker.telefone),
            Row(children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () {
                    _updateWorkerDialog();
                  },
                  child: const Icon(Icons.edit),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () {
                    _deleteworkerDialog();
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

  Future<void> getSingleWorker() async {
    final singleworker = await context
        .read<FirebaseDBMethods>()
        .readSingleWorker(widget.worker.id, context: context);
    nomeController.text = singleworker!.name;
    emailController.text = singleworker.email;
    telefoneController.text = singleworker.telefone;
  }
}
