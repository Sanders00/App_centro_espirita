import 'package:app_centro_espirita/Widgets/CustomTextField.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.white, title: Text('CEPAC', style: TextStyle(color: Colors.black, ),),),
      body: Container(
        decoration:  const BoxDecoration(
          gradient: LinearGradient(transform: GradientRotation(1.5),colors: [
                                      Colors.green,
                                      Colors.lightGreen
                                    ])
        ),
        child: Align(
          alignment: Alignment.center,
          child: Container(
            width: MediaQuery.of(context).size.width * 0.5,
            height: MediaQuery.of(context).size.height * 0.5,
            decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Text(
                  'Login',
                  style: TextStyle(fontSize: 60),
                ),
                const Text('Bem-vindo ao CEPAC! Preencha o formulário abaixo para entrar na sua conta!', style: TextStyle(color: Colors.black54),),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  child: Divider(),
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Modular.to.navigate('/Dashboard');
                      },
                      child: const Text('Iniciar Sessão',style: TextStyle(fontSize: 20),),
                    ),
                    const Padding(padding: EdgeInsets.symmetric(horizontal: 20),child: Text('ou', style: TextStyle(fontSize: 16),),),
                    ElevatedButton(
                      onPressed: () {
                        Modular.to.navigate('/Create-Account');
                      },
                      child: const Text('Criar Conta',style: TextStyle(fontSize: 20),),
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
