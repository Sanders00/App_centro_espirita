Map<String, bool> weekdaysGlobal = {
      'Domingo': false,
      'Segunda-Feira': false,
      'Terça-Feira': false,
      'Quarta-Feira': false,
      'Quinta-Feira': false,
      'Sexta-Feira': false,
      'Sábado': false,
    };

resetWeekdaysGlobal(){
  weekdaysGlobal.forEach((key, value) {
    weekdaysGlobal[key] = false;
  });
}