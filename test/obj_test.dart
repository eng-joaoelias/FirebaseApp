import 'package:flutter_test/flutter_test.dart';

abstract class Pessoa {
  late int _id;
  String nome;

  Pessoa(this.nome);

  int get id => _id;

  set id(int id) {
    if (id > 0) {
      _id = id;
    } else {
      throw ArgumentError('Identificador deve ser não negativo.');
    }
  }
}

mixin Ano {
  late int _ano;

  int get ano => _ano;

  set ano(int ano) {
    if (ano > 0) {
      _ano = ano;
    } else {
      throw ArgumentError('Ano deve ser não negativo.');
    }
  }
}

class Aluno extends Pessoa with Ano {
  Aluno(super.nome, int ano) {
    this.ano = ano;
  }
}

class Disciplina {
  String nome;
  Disciplina(this.nome);
}

class Professor extends Pessoa {
  Professor(super.nome);
}

class Turma with Ano {
  Disciplina disciplina;
  Professor docenteResponsavel;
  final List<Aluno> _alunos = [];

  Turma(this.disciplina, int ano, this.docenteResponsavel) {
    this.ano = ano;
    docenteResponsavel = docenteResponsavel;
  }

  void matricular(Aluno aluno) {
    if (aluno.ano == ano) {
      _alunos.add(aluno);
    } else {
      throw ArgumentError('Ano deve ser mesmo.');
    }
  }
}

class Historico extends Turma {
  Map<Aluno, List<double>> notas = {};

  Historico(super.disciplina, super.ano, super.docenteResponsavel);

  @override
  void matricular(Aluno aluno) {
    super.matricular(aluno);
    notas[aluno] = [];
  }

  double media(Aluno aluno) {
    List<double>? listaNotas = notas[aluno];

    // evita divisão por zero quando o aluno não tem notas
    if (listaNotas == null || listaNotas.isEmpty) {
      return 0.0;
    }

    double soma = 0;

    for (double nota in listaNotas) {
      soma = soma + nota;
    }
    return soma / listaNotas.length;
  }

  bool isAprovado(Aluno aluno) {
    return media(aluno) > 6.0;
  }

  void main() {
    test('Testar matrícula de alunos', () {
      Professor docente = Professor("Edilson Luiz Nascimento");
      Disciplina disciplina1 = Disciplina('Flutter');
      Historico historico1 = Historico(disciplina1, 2023, docente);
      // Cadastrar primeiro aluno sem erros
      Aluno aluno1 = Aluno('Maria', 2023);
      aluno1.id = 1;
      historico1.matricular(aluno1);

      expect(historico1.media(aluno1), 0.0);
      expect(historico1.isAprovado(aluno1), false);
      // Cadastrar segundo aluno com erros
      Aluno aluno2 = Aluno('Paula', 2022);
      try {
        aluno2.id = 0;
      } catch (error) {
        expect(error, isA<ArgumentError>());
      }
      try {
        historico1.matricular(aluno2);
      } catch (error) {
        expect(error, isA<ArgumentError>());
      }

      expect(() => aluno2.id = 0, throwsA(isA<ArgumentError>()));
      expect(
        () => historico1.matricular(aluno2),
        throwsA(isA<ArgumentError>()),
      );
    });
  }
}
