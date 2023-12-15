import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Color.fromARGB(255, 255, 187, 0), // Cor primária
        scaffoldBackgroundColor: Color.fromARGB(255, 255, 255, 255),
        secondaryHeaderColor:
            Color.fromARGB(255, 0, 0, 0), // Cor de fundo da tela
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(
                Color.fromARGB(255, 255, 187, 0)), // Cor de fundo dos botões
            foregroundColor: MaterialStateProperty.all(
                const Color.fromARGB(255, 0, 0, 0)), // Cor do texto dos botões
          ),
        ),
        textTheme: TextTheme(
          bodyText1: TextStyle(
              color: Colors.black), // Define a cor do texto padrão como preto
          bodyText2: TextStyle(color: Colors.black), // Outro estilo de texto
          // Você pode definir outros estilos de texto conforme necessário
        ),
      ),
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text('Login'),
        foregroundColor: Theme.of(context).secondaryHeaderColor,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Faça Login', // Cabeçalho "Faça Login"
              style: TextStyle(
                fontSize: 24, // Tamanho do texto
                fontWeight: FontWeight.bold, // Peso da fonte
              ),
            ),
            SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Senha'),
              obscureText: true,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Adicione a lógica de autenticação aqui
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => MenuPage()),
                );
              },
              child: Text('Entrar'),
            ),
          ],
        ),
      ),
    );
  }
}

class Cadastro {
  String id;
  String nome;
  String descricao;

  Cadastro({
    required this.id,
    required this.nome,
    required this.descricao,
  });
}

class MenuPage extends StatefulWidget {
  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  List<Cadastro> cadastros = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text('Menu'),
        foregroundColor: Theme.of(context).secondaryHeaderColor,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Seus Cadastros', // Cabeçalho "Faça Login"
              style: TextStyle(
                fontSize: 24, // Tamanho do texto
                fontWeight: FontWeight.bold, // Peso da fonte
              ),
            ),
            SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => CadastroPage(
                      onCadastroAdded: (cadastro) {
                        setState(() {
                          cadastros.add(cadastro);
                        });
                      },
                    ),
                  ),
                );
              },
              child: Text('Cadastro 1'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => CadastroPage(
                      onCadastroAdded: (cadastro) {
                        setState(() {
                          cadastros.add(cadastro);
                        });
                      },
                    ),
                  ),
                );
              },
              child: Text('Cadastro 2'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => CadastroPage(
                      onCadastroAdded: (cadastro) {
                        setState(() {
                          cadastros.add(cadastro);
                        });
                      },
                    ),
                  ),
                );
              },
              child: Text('Cadastro 3'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => CadastroPage(
                      onCadastroAdded: (cadastro) {
                        setState(() {
                          cadastros.add(cadastro);
                        });
                      },
                    ),
                  ),
                );
              },
              child: Text('Cadastro 4'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => CadastroListPage(
                      cadastros: cadastros,
                      onUpdate: (index, cadastro) {
                        setState(() {
                          cadastros[index] = cadastro;
                        });
                      },
                      onDelete: (index) {
                        setState(() {
                          cadastros.removeAt(index);
                        });
                      },
                    ),
                  ),
                );
              },
              child: Text('Lista de Cadastros'),
            ),
          ],
        ),
      ),
    );
  }
}

class CadastroPage extends StatelessWidget {
  final Function(Cadastro) onCadastroAdded;

  CadastroPage({required this.onCadastroAdded});

  final TextEditingController nomeController = TextEditingController();
  final TextEditingController descricaoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text('Novo Cadastro'),
        foregroundColor: Theme.of(context).secondaryHeaderColor,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: nomeController,
              decoration: InputDecoration(labelText: 'Nome'),
            ),
            TextField(
              controller: descricaoController,
              decoration: InputDecoration(labelText: 'Descrição'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final cadastro = Cadastro(
                  id: DateTime.now().toString(),
                  nome: nomeController.text,
                  descricao: descricaoController.text,
                );
                onCadastroAdded(cadastro);
                Navigator.of(context).pop();
              },
              child: Text('Adicionar Cadastro'),
            ),
          ],
        ),
      ),
    );
  }
}

class CadastroListPage extends StatelessWidget {
  final List<Cadastro> cadastros;
  final Function(int, Cadastro) onUpdate;
  final Function(int) onDelete;

  CadastroListPage({
    required this.cadastros,
    required this.onUpdate,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text('Lista de Cadastros'),
        foregroundColor: Theme.of(context).secondaryHeaderColor,
      ),
      body: ListView.builder(
        itemCount: cadastros.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(cadastros[index].nome),
            subtitle: Text(cadastros[index].descricao),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => EditCadastroPage(
                          cadastro: cadastros[index],
                          onUpdate: (cadastro) {
                            onUpdate(index, cadastro);
                          },
                        ),
                      ),
                    );
                  },
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    onDelete(index);
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class EditCadastroPage extends StatelessWidget {
  final Cadastro cadastro;
  final Function(Cadastro) onUpdate;

  EditCadastroPage({required this.cadastro, required this.onUpdate});

  final TextEditingController nomeController = TextEditingController();
  final TextEditingController descricaoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    nomeController.text = cadastro.nome;
    descricaoController.text = cadastro.descricao;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Theme.of(context).secondaryHeaderColor,
        title: Text('Editar Cadastro'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: nomeController,
              decoration: InputDecoration(labelText: 'Nome'),
            ),
            TextField(
              controller: descricaoController,
              decoration: InputDecoration(labelText: 'Descrição'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final updatedCadastro = Cadastro(
                  id: cadastro.id,
                  nome: nomeController.text,
                  descricao: descricaoController.text,
                );
                onUpdate(updatedCadastro);
                Navigator.of(context).pop();
              },
              child: Text('Salvar'),
            ),
          ],
        ),
      ),
    );
  }
}
