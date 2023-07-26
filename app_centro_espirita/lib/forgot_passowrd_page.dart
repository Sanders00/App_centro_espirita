import 'package:app_centro_espirita/services/firebase_auth_methods.dart';
import 'package:app_centro_espirita/widgets/custom_button.dart';
import 'package:app_centro_espirita/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  TextEditingController emailController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  void sendPasswordReset() {
    context
        .read<FirebaseAuthMethods>()
        .sendPasswordReset(email: emailController.text, context: context);
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
                  'Esqueceu-se da senha?',
                  style: TextStyle(fontSize: 60),
                ),
                const Text(
                  'Nós o ajudaremos a recuperar a sua conta.',
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
                    controller: emailController,
                    hintText: 'Email',
                  ),
                ),
                Container(
                    margin: const EdgeInsets.symmetric(horizontal: 50),
                    child:
                        CustomButton(function: sendPasswordReset, text: 'Redefinir senha')),
                TextButton(
                    onPressed: () {
                      Modular.to.navigate('/');
                    },
                    child: const Text('Voltar'))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
