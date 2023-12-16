import 'dart:convert';

class Dependente {
  late String _nome;

  Dependente(String nome) {
    this._nome = nome;
  }

  String toJson() {
    return json.encode({"nome": _nome});
  }
}

class Funcionario {
  late String _nome;
  late List<Dependente> _dependentes;

  Funcionario(String nome, List<Dependente> dependentes) {
    this._nome = nome;
    this._dependentes = dependentes;
  }

  String toJson() {
    List<dynamic> ListarDependentes = [];
    _dependentes.forEach((dependentes) {
      ListarDependentes.add(jsonDecode(dependentes.toJson()));
    });
    return json.encode({"Funcionario": _nome, "Dependente": _dependentes});
  }
}

class EquipeProjeto {
  late String _nomeProjeto;
  late List<Funcionario> _funcionarios;

  EquipeProjeto(String nomeprojeto, List<Funcionario> funcionarios) {
    _nomeProjeto = nomeprojeto;
    _funcionarios = funcionarios;
  }

  String toJson() {
    List<dynamic> ListarFuncionarios = [];
    _funcionarios.forEach((funcionarios) {
      ListarFuncionarios.add(jsonDecode(funcionarios.toJson()));
    });
    return json.encode({"Projeto": _nomeProjeto, "Funcionario": _funcionarios});
  }

}

void main() {
  // 1. Criar varios objetos Dependentes
  final dependA = new Dependente("Alisson");
  final dependB = new Dependente("Bia");
  // 2. Criar varios objetos Funcionario
  final FuncionarioA = new Funcionario("A", [dependA]);
  final FuncionarioB = new Funcionario("B", [dependB]);
  // 3. Associar os Dependentes criados aos respectivos funcionarios
  // 4. Criar uma lista de Funcionarios
  List<Funcionario> Funcionarios = [FuncionarioA, FuncionarioB];
  // 5. criar um objeto Equipe Projeto chamando o metodo
  //    contrutor que da nome ao projeto e insere uma
  //    coleção de funcionario
  final equipeA = EquipeProjeto("nomeprojeto", Funcionarios);
  // 6. Printar no formato JSON o objeto Equipe Projeto.
  print(equipeA.toJson());
}
