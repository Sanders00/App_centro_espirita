import 'package:common/features/workers/data/api/list.dart';
import 'package:common/features/workers/data/model/worker.dart';
import 'package:flutter/material.dart';

import '../../utils/side_menu.dart';
import '../../widgets/custom_appbar.dart';
import '../../widgets/custom_button.dart';

class WorkerCrudPage extends StatefulWidget {
  const WorkerCrudPage({super.key});

  @override
  State<WorkerCrudPage> createState() => _WorkerCrudPageState();
}

class _WorkerCrudPageState extends State<WorkerCrudPage> {
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
              child: CustomButton(function: () {}, text: 'Add+'),
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
                        future: WorkerListRemoteAPIDataSource().getAll(),
                        builder: (context, snapshot) {
                          if (snapshot.hasError) {
                            return const Text("Erro");
                          } else if (snapshot.hasData) {
                            final workers = snapshot.data!;
                            print(workers);
                            return ListView.builder(
                              padding: const EdgeInsets.all(5),
                              itemCount: workers.length,
                              itemBuilder: (context, index) {
                                return CustomWorkerTile(
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
  const CustomWorkerTile({super.key, required, required this.context});
  final BuildContext context;

  @override
  State<CustomWorkerTile> createState() => _CustomWorkerTileState();
}

class _CustomWorkerTileState extends State<CustomWorkerTile> {
  final TextEditingController nomeController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController telefoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const CircleAvatar(),
            Text('name'),
            Text('email'),
            Text('telefone'),
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
                  onPressed: () {},
                  child: const Icon(Icons.edit),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () {},
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
