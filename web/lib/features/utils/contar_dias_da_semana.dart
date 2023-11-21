class ContadorDiasDaSemana {
  int contarDiasDaSemana(int ano, int mes, int diaDaSemana) {
    DateTime primeiroDia = DateTime(ano, mes, 1);

    int deslocamento = (diaDaSemana - primeiroDia.weekday + 7) % 7;

    int contador = 0;
    DateTime data = primeiroDia.add(Duration(days: deslocamento));
    while (data.month == mes) {
      contador++;
      data = data.add(const Duration(days: 7));
    }

    return contador;
  }
}