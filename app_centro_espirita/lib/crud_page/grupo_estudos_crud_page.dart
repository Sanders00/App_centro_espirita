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
          ],
        ),
      ),
    );
  }
}
