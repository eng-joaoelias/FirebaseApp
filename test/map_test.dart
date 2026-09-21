import 'package:flutter_test/flutter_test.dart';

Map<String, List<double>> alunos = {
  'Maria': [8.0, 9.0],
  'Bruna': [7.0, 7.0],
  'Carla': [10.0, 9.0],
};

void main() {
  test('Adicionar elemento', () {
    alunos.putIfAbsent(
      'Elena',
      () => [9.0, 8.0],
    ); //insere em caso de ausencia. a chave e o nome de discente
    expect(alunos.containsKey('Elena'), isTrue); //verifica a presenca
    expect(alunos['Elena'], [9.0, 8.0]);
  });

  test('Adicinar outro dicionário', () {
    alunos.addAll({
      //isso aqui adiciona um novo dicionario dentro do dicionario atual
      'Elena': [9.0, 8.0],
      'Luiza': [8.0, 9.0],
    });
    expect(alunos.containsKey('Elena'), isTrue);
    expect(alunos.containsKey('Luiza'), isTrue);
  });

  test('Remover elemento', () {
    alunos.remove('Bruna'); //remove bruna e as notas
    expect(
      alunos.containsKey('Bruna'),
      isFalse,
    ); //verifica se realmente removeu
  });

  test('Atualizar elemento', () {
    alunos.update('Carla', (value) => [9.0, 8.0]); //atualiza as notas de carla
    expect(alunos['Carla'], [9.0, 8.0]); //verifica se atualizou
    alunos['Carla'] = [8.0, 9.0]; //outra forma menos verbosa de mudar as notas
    expect(alunos['Carla'], [8.0, 9.0]);
  });

  test('Testar percorrer dicionario', () {
    expect(alunos.keys, ['Maria', 'Carla', 'Elena', 'Luiza']);
    expect(alunos.values, [
      [8.0, 9.0],
      [8.0, 9.0],
      [9.0, 8.0],
      [8.0, 9.0],
    ]);
    double soma = 0;
    alunos.forEach((key, value) {
      for (double nota in value) {
        soma += nota;
      }
    });
    expect(soma, 68.0);
  });

  Map<String, double> medias = alunos.map((nome, notas) {
    double soma = notas.reduce((a, b) => a + b);
    return MapEntry(nome, soma / notas.length);
  });
  alunos.forEach((aluno, notas) {

  });
  test('Ver médias', () {
    expect(medias, {'Maria': 8.5, 'Carla': 8.5, 'Luiza': 8.5});
  });
}
