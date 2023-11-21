import 'package:app_centro_espirita/features/utils/contar_dias_da_semana.dart';
import 'package:app_centro_espirita/features/widgets/custom_button.dart';
import 'package:app_centro_espirita/global.dart';
import 'package:flutter/material.dart';
import 'package:mat_month_picker_dialog/mat_month_picker_dialog.dart';

class CreateMeetingPage extends StatefulWidget {
  const CreateMeetingPage({super.key});
  @override
  State<CreateMeetingPage> createState() => _CreateMeetingPageState();
}

class _CreateMeetingPageState extends State<CreateMeetingPage> {
  int numberOfDays = 0;
  int selectedWeekDay = 0;
  ContadorDiasDaSemana diasDaSemana = ContadorDiasDaSemana();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.9,
          height: MediaQuery.of(context).size.height * 0.9,
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
                  width: MediaQuery.of(context).size.width * 0.85,
                  child: const Divider()),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.85,
                child: Row(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.1,
                      height: MediaQuery.of(context).size.height * 0.06,
                      child: DropdownButton(
                        value: selectedWeekDay,
                        onChanged: (value) {
                          setState(() {
                            selectedWeekDay = value as int;
                          });
                        },
                        items: weekDaysGlobal
                            .asMap()
                            .entries
                            .map((e) => DropdownMenuItem(
                                  value: e.key,
                                  child: Text(e.value),
                                ))
                            .toList(),
                      ),
                    ),
                    CustomButton(
                      text: 'Data',
                      function: () async {
                        final selectedDate = await showMonthPicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1970),
                          lastDate: DateTime(2100),
                        );
                        setState(
                          () {
                            numberOfDays = diasDaSemana.contarDiasDaSemana(
                                selectedDate!.year,
                                selectedDate.month,
                                selectedWeekDay);
                          },
                        );
                      },
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
                      child: ListView.builder(
                        itemCount: numberOfDays,
                        itemBuilder: (context, index) {
                          return Text(index.toString());
                        },
                      ),
                    ),
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
