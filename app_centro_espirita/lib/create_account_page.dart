import 'package:app_centro_espirita/services/firebase_auth_methods.dart';
import 'package:app_centro_espirita/utils/show_snackbar.dart';
import 'package:app_centro_espirita/widgets/custom_button.dart';
import 'package:app_centro_espirita/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class CreateAccountScreen extends StatefulWidget {
  const CreateAccountScreen({super.key});

  @override
  State<CreateAccountScreen> createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmpasswordController = TextEditingController();

  @override
  void dispose() {
    firstNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmpasswordController.dispose();
    super.dispose();
  }

  void signUpUser() async {
    context.read<FirebaseAuthMethods>().signUpWithEmail(
          email: emailController.text,
          password: passwordController.text,
          context: context,
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'CEPAC',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                transform: GradientRotation(1.5),
                colors: [Colors.green, Colors.lightGreen])),
        child: Align(
          alignment: Alignment.center,
          child: Container(
            width: MediaQuery.of(context).size.width * 0.5,
            height: MediaQuery.of(context).size.height * 0.7,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Text(
                  'Criar Conta',
                  style: TextStyle(fontSize: 60),
                ),
                const Text(
                  'Bem-vindo ao CEPAC! Preencha o formulário abaixo para criar a sua conta!',
                  style: TextStyle(color: Colors.black54),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 50),
                  child: Divider(),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 50),
                  child: CustomTextField(
                    isPassowrd: false,
                    controller: firstNameController,
                    hintText: 'Primeiro Nome',
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 50),
                  child: CustomTextField(
                    isPassowrd: false,
                    controller: emailController,
                    hintText: 'Email',
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 50),
                  child: CustomTextField(
                    isPassowrd: true,
                    controller: passwordController,
                    hintText: 'Senha',
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 50),
                  child: CustomTextField(
                    controller: confirmpasswordController,
                    isPassowrd: true,
                    hintText: 'Confirmar Senha',
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CustomButton(
                      function: () {
                        if (passwordController.text !=
                            confirmpasswordController.text) {
                          showSnackBar(context, 'Senhas diferentes');
                        } else if (firstNameController.text.isEmpty) {
                          showSnackBar(
                              context, 'O campo do primeiro nome está vazio');
                        } else {
                          signUpUser();
                        }
                      },
                      text: 'Criar Conta',
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        'ou',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    CustomButton(
                        function: () {
                          Modular.to.navigate('/');
                        },
                        text: 'Iniciar Sessão')
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
