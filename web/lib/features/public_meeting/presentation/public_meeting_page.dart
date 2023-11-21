import 'package:app_centro_espirita/features/public_meeting/presentation/create_meeting.dart';
import 'package:app_centro_espirita/features/utils/side_menu.dart';
import 'package:app_centro_espirita/features/widgets/custom_appbar.dart';
import 'package:app_centro_espirita/features/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:mat_month_picker_dialog/mat_month_picker_dialog.dart';

class PublicMeetingCrudPage extends StatefulWidget {
  const PublicMeetingCrudPage({super.key});

  @override
  State<PublicMeetingCrudPage> createState() => _PublicMeetingCrudPageState();
}

class _PublicMeetingCrudPageState extends State<PublicMeetingCrudPage> {
  DateTime? _selected;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(context: context),
      drawer: const DrawerScreen(
        currentIndex: 1,
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
                  child: const Text(
                    'Reuniões Públicas',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
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
                      width: 150,
                      height: 50,
                      child: CustomButton(
                        text:
                            '${_selected?.month ?? 'Filtrar'}/${_selected?.year ?? 'Data'}',
                        function: () async {
                          final selected = await showMonthPicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1970),
                            lastDate: DateTime(2100),
                          );
                          setState(() => _selected = selected);
                        },
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      width: 200,
                      height: 50,
                      child: CustomButton(
                          function: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>
                                    const CreateMeetingPage()));
                          },
                          text: 'Adicionar Reunião'),
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
                                    'Mês',
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
                                    'Ano',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 3,
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
                      child: Container(),
                    ),
                    // Expanded(
                    //   flex: 9,
                    //   child: FutureBuilder<List<>>(
                    //     future: ,
                    //     builder: (context, snapshot) {
                    //       if (snapshot.hasError) {
                    //         return const Text("Erro");
                    //       } else if (snapshot.hasData) {
                    //         final groups = snapshot.data!;
                    //         return ListView.builder(
                    //             padding: const EdgeInsets.all(5),
                    //             itemCount: groups.length,
                    //             itemBuilder: (context, index) {
                    //               return Container();
                    //             });
                    //       } else {
                    //         return SizedBox(
                    //             width: MediaQuery.of(context).size.width * 0.25,
                    //             child: const CircularProgressIndicator());
                    //       }
                    //     },
                    //   ),
                    // ),
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
