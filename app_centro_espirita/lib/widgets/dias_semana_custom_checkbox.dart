import 'package:app_centro_espirita/global.dart';
import 'package:flutter/material.dart';

class WeekdaysCustomCheckbox extends StatefulWidget {
  const WeekdaysCustomCheckbox({super.key, required this.title});

  final String title;
  @override
  State<WeekdaysCustomCheckbox> createState() => _WeekdaysCustomCheckboxState();
}

class _WeekdaysCustomCheckboxState extends State<WeekdaysCustomCheckbox> {
  @override
  Widget build(BuildContext context) {

    

    return StatefulBuilder(builder: (context, setState) {
      return Column(
        children: [
          Container(
            padding: const EdgeInsets.all(4),
            child: Text(
              widget.title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          CheckboxListTile(
              title: const Text('Domingo'),
              controlAffinity: ListTileControlAffinity.leading,
              value: weekdaysGlobal['Domingo'],
              onChanged: (bool? value) {
                setState(() {
                  weekdaysGlobal['Domingo'] = value!;
                });
              }),
          CheckboxListTile(
              title: const Text('Segunda-Feira'),
              controlAffinity: ListTileControlAffinity.leading,
              value: weekdaysGlobal['Segunda-Feira'],
              onChanged: (value) {
                setState(() {
                  weekdaysGlobal['Segunda-Feira'] = value!;
                });
              }),
          CheckboxListTile(
              title: const Text('Terça-Feira'),
              controlAffinity: ListTileControlAffinity.leading,
              value: weekdaysGlobal['Terça-Feira'],
              onChanged: (value) {
                setState(() {
                  weekdaysGlobal['Terça-Feira'] = value!;
                });
              }),
          CheckboxListTile(
              title: const Text('Quarta-Feira'),
              controlAffinity: ListTileControlAffinity.leading,
              value: weekdaysGlobal['Quarta-Feira'],
              onChanged: (value) {
                setState(() {
                  weekdaysGlobal['Quarta-Feira'] = value!;
                });
              }),
          CheckboxListTile(
              title: const Text('Quinta-Feira'),
              controlAffinity: ListTileControlAffinity.leading,
              value: weekdaysGlobal['Quinta-Feira'],
              onChanged: (value) {
                setState(() {
                  weekdaysGlobal['Quinta-Feira'] = value!;
                });
              }),
          CheckboxListTile(
              title: const Text('Sexta-Feira'),
              controlAffinity: ListTileControlAffinity.leading,
              value: weekdaysGlobal['Sexta-Feira'],
              onChanged: (value) {
                setState(() {
                  weekdaysGlobal['Sexta-Feira'] = value!;
                });
              }),
          CheckboxListTile(
              title: const Text('Sábado'),
              controlAffinity: ListTileControlAffinity.leading,
              value: weekdaysGlobal['Sábado'],
              onChanged: (value) {
                setState(() {
                  weekdaysGlobal['Sábado'] = value!;
                });
              }),
        ],
      );
    });
  }
}
