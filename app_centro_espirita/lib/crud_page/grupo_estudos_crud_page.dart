import 'package:app_centro_espirita/global.dart';
import 'package:app_centro_espirita/services/firebase_database_methods.dart';
import 'package:app_centro_espirita/utils/side_menu.dart';
import 'package:app_centro_espirita/widgets/custom_appbar.dart';
import 'package:app_centro_espirita/widgets/custom_button.dart';
import 'package:app_centro_espirita/widgets/custom_text_field.dart';
import 'package:app_centro_espirita/widgets/dias_semana_custom_checkbox.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class GrupoEstudosCrudPage extends StatefulWidget {
  const GrupoEstudosCrudPage({super.key});

  @override
  State<GrupoEstudosCrudPage> createState() => _GrupoEstudosCrudPageState();
}

class _GrupoEstudosCrudPageState extends State<GrupoEstudosCrudPage> {
  @override
  Widget build(BuildContext context) {
    TextEditingController nomeGrupoContoller = TextEditingController();

    void _addGrupoDB() {
      context.read<FirebaseDBMethods>().createGrupoEstudos(
          nameGrupo: nomeGrupoContoller.text, context: context);
    }

    _addGrupoDialog() {
      return showDialog<void>(
          barrierDismissible: false,
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Adicionar Grupo de estudos'),
              content: SizedBox(
                height: MediaQuery.of(context).size.height * 0.55,
                width: MediaQuery.of(context).size.width * 0.2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomTextField(
                        controller: nomeGrupoContoller,
                        hintText: 'Nome do Grupo',
                        isPassowrd: false),
                    const WeekdaysCustomCheckbox(
                        title: 'Escolha os dias da semana:'),
                    CustomButton(
                        function: () {
                          setState(() {
                            _addGrupoDB();
                            nomeGrupoContoller.clear();
                            Navigator.pop(context);
                          });
                        },
                        text: 'Adicionar'),
                    CustomButton(
                        function: () {
                          nomeGrupoContoller.clear();
                          Navigator.pop(context);
                        },
                        text: 'Voltar')
                  ],
                ),
              ),
            );
          });
    }

    return Scaffold(
      appBar: CustomAppBar(
        context: context,
      ),
      drawer: const DrawerScreen(currentIndex: 1),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(8),
              width: 200,
              height: 50,
              child: CustomButton(function: _addGrupoDialog, text: 'Add+'),
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
                          Text('Nome do Grupo'),
                          Text('Dias da semana'),
                          Text('')
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 9,
                    child: StreamBuilder<List<GrupoEsutdoDB>>(
                        stream: context
                            .read<FirebaseDBMethods>()
                            .readGruposEstudos(),
                        builder: (context, snapshot) {
                          if (snapshot.hasError) {
                            return const Text("Erro");
                          } else if (snapshot.hasData) {
                            final grupo = snapshot.data!;
                            return ListView.builder(
                              padding: const EdgeInsets.all(5),
                              itemCount: grupo.length,
                              itemBuilder: (context, index) {
                                return CustomGrupoTile(
                                  grupo: grupo[index],
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

class CustomGrupoTile extends StatefulWidget {
  const CustomGrupoTile(
      {super.key, required this.context, required this.grupo});
  final GrupoEsutdoDB grupo;
  final BuildContext context;
  @override
  State<CustomGrupoTile> createState() => _CustomGrupoTileState();
}

class _CustomGrupoTileState extends State<CustomGrupoTile> {
  TextEditingController nomeGrupoContoller = TextEditingController();

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

  _deleteGrupoDialog() {
    return showDialog<void>(
        barrierDismissible: false,
        context: widget.context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
                'Deseja mesmo excluir ${widget.grupo.nameGrupo} do banco de dados?'),
            content: SizedBox(
              height: MediaQuery.of(context).size.height * 0.2,
              width: MediaQuery.of(context).size.width * 0.2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CustomButton(
                      function: () {
                        context.read<FirebaseDBMethods>().deleteGrupoEstudo(
                            id: widget.grupo.id, context: context);
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

  Future<void> getSingleGrupo() async {
    final singleGrupo = await context
        .read<FirebaseDBMethods>()
        .readSingleGrupoEstudo(widget.grupo.id, context: context);
    nomeGrupoContoller.text = singleGrupo!.nameGrupo;
    await context
        .read<FirebaseDBMethods>()
        .readWeekdaysById(grupoId: widget.grupo.id);
  }

  _updateGrupoDialog() async{
    getSingleGrupo();
    return showDialog<void>(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Adicionar Grupo de estudos'),
            content: SizedBox(
              height: MediaQuery.of(context).size.height * 0.55,
              width: MediaQuery.of(context).size.width * 0.2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomTextField(
                      controller: nomeGrupoContoller,
                      hintText: 'Nome do Grupo',
                      isPassowrd: false),
                  const WeekdaysCustomCheckbox(
                      title: 'Escolha os dias da semana:'),
                  CustomButton(
                      function: () {
                        setState(() {
                          resetWeekdaysGlobal();
                          Navigator.pop(context);
                        });
                      },
                      text: 'Confirmar'),
                  CustomButton(
                      function: () {
                        resetWeekdaysGlobal();
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
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () {
                      _updateGrupoDialog();
                    },
                    child: const Icon(Icons.edit),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () {
                      _deleteGrupoDialog();
                    },
                    style: const ButtonStyle(
                        backgroundColor:
                            MaterialStatePropertyAll<Color>(Colors.red)),
                    child: const Icon(Icons.delete),
                  ),
                ),
              ],
            )
          ],
        ),
        const Divider(
          thickness: 0,
        ),
      ],
    );
  }
}
