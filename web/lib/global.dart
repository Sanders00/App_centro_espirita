Map<String, bool> weekdaysGlobal = {
      'Domingo': false,
      'Segunda-Feira': false,
      'Terça-Feira': false,
      'Quarta-Feira': false,
      'Quinta-Feira': false,
      'Sexta-Feira': false,
      'Sábado': false,
    };

Map<String, bool> weekdaysavailableGlobal = {
      'Domingo': true,
      'Segunda-Feira': true,
      'Terça-Feira': true,
      'Quarta-Feira': true,
      'Quinta-Feira': true,
      'Sexta-Feira': true,
      'Sábado': true,
    };
resetWeekdaysGlobal(){
  weekdaysGlobal.forEach((key, value) {
    weekdaysGlobal[key] = false;
  });
}
resetweekdaysavailableGlobal(){
  weekdaysavailableGlobal.forEach((key, value) {
    weekdaysavailableGlobal[key] = true;
  });
}