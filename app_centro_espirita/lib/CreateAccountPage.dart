import 'package:app_centro_espirita/Services/firebase_auth_methods.dart';
import 'package:app_centro_espirita/Widgets/CustomTextField.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';





class CreateAccountScreen extends StatefulWidget {
  const CreateAccountScreen({super.key});

  @override
  State<CreateAccountScreen> createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmpasswordController = TextEditingController();

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
      appBar: AppBar(backgroundColor: Colors.white, title: Text('CEPAC', style: TextStyle(color: Colors.black, ),),),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(transform: GradientRotation(1.5),colors: [
                                      Colors.green,
                                      Colors.lightGreen
                                    ])
        ),
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
                const Text('Bem-vindo ao CEPAC! Preencha o formulário abaixo para criar a sua conta!', style: TextStyle(color: Colors.black54),),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  child: Divider(),
                ),
                Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: 50),
                  child: CustomTextField(
                    controller: firstNameController,
                    hintText: 'Primeiro Nome',
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: 50),
                  child: CustomTextField(
                    controller: lastNameController,
                    hintText: 'Sobrenome',
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: 50),
                  child: CustomTextField(
                    controller: emailController,
                    hintText: 'Email',
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: 50),
                  child: CustomTextField(
                    controller: passwordController,
                    hintText: 'Senha',
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: 50),
                  child: CustomTextField(
                    controller: confirmpasswordController,
                    hintText: 'Confirmar Senha',
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: signUpUser,
                      child: const Text('Criar Conta',style: TextStyle(fontSize: 20),),
                    ),
                    const Padding(padding: EdgeInsets.symmetric(horizontal: 20),child: Text('ou', style: TextStyle(fontSize: 16),),),
                     ElevatedButton(
                      onPressed: () {
                        Modular.to.navigate('/');
                      },
                      child: const Text('Iniciar Sessão',style: TextStyle(fontSize: 20),),
                    ),
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
