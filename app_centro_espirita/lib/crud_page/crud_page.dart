import 'package:app_centro_espirita/Utils/side_menu.dart';
import 'package:app_centro_espirita/Widgets/custom_appbar.dart';
import 'package:app_centro_espirita/widgets/custom_button.dart';
import 'package:app_centro_espirita/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';

class CrudPage extends StatefulWidget {
  const CrudPage({super.key});

  @override
  State<CrudPage> createState() => _CrudPageState();
}

class _CrudPageState extends State<CrudPage> {
  TextEditingController primeironomeController = TextEditingController();
  TextEditingController sobrenomeController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController telefoneController = TextEditingController();

  _addPersonDialog() {
    return showDialog<void>(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Adicionar pessoa'),
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomTextField(
                    controller: primeironomeController,
                    hintText: 'primeiro nome',
                    isPassowrd: false),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomTextField(
                    controller: sobrenomeController,
                    hintText: 'sobrenome',
                    isPassowrd: false),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomTextField(
                    controller: emailController,
                    hintText: 'email',
                    isPassowrd: false),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomTextField(
                    controller: telefoneController,
                    hintText: 'telefone',
                    isPassowrd: false),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomButton(function: () {}, text: 'Adicionar'),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomButton(
                    function: () {
                      Navigator.pop(context);
                    },
                    text: 'Voltar'),
              )
            ],
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
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                margin: EdgeInsets.symmetric(horizontal: 800),
                child: CustomButton(function: _addPersonDialog, text: 'Add+'))
          ],
        ),
      ),
    );
  }
}
