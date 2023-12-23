
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fernanda Holanda Rodrigues',
      theme: ThemeData(
        primarySwatch: Colors.purple, 
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fernanda Holanda Rodrigues'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(bottom: 16.0), // Adicionando espaçamento abaixo do botão
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AddItemPage()),
                  );
                },
                child: Text('Inserir Cadastro'),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 16.0), // Adicionando espaçamento abaixo do botão
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ListItemsPage()),
                  );
                },
                child: Text('Listar Cadastro'),
              ),
            ), 
            Container(
              margin: EdgeInsets.only(bottom: 16.0), // Adicionando espaçamento abaixo do botão
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => UpdateDeleteItemPage(item:{})),
                  );
                },
                child: Text('Atualizar/Excluir Cadastro'),
              ),
            ), 
          ],
        ),
      ),
    );
  }
}

class AddItemPage extends StatelessWidget {
  final TextEditingController _itemNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inserir Item'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextField(
              controller: _itemNameController,
              decoration: InputDecoration(labelText: 'Nome do Item'),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () async {
                String itemName = _itemNameController.text;
                await DatabaseHelper.instance.insertItem(itemName);
                Navigator.pop(context); 

                //limpar campo após a inserção 
                _itemNameController.clear();
              },
              child: Text('Inserir'),
            ),
          ],
        ),
      ),
    );
  }
}

class ListItemsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Itens'),
      ),
      body: FutureBuilder(
        future: DatabaseHelper.instance.queryAllItems(limit: 50), // Ajuste aqui para limitar a quantidade de itens
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            List<Map<String, dynamic>> items = snapshot.data as List<Map<String, dynamic>>;
            if (items.isEmpty) {
              return Center(
                child: Text('Nenhum item encontrado.'),
              );
            }

            return ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(items[index]['name']),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UpdateDeleteItemPage(item: items[index]),
                      ),
                    );
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}

class UpdateDeleteItemPage extends StatefulWidget {
  final Map<String, dynamic> item;

  UpdateDeleteItemPage({required this.item});

  @override
  _UpdateDeleteItemPageState createState() => _UpdateDeleteItemPageState();
}

class _UpdateDeleteItemPageState extends State<UpdateDeleteItemPage> {
  late TextEditingController _itemNameController;

  @override
  void initState() {
    super.initState();
    _itemNameController = TextEditingController(text: widget.item['name']);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalhes do Item'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextField(
              controller: _itemNameController,
              decoration: InputDecoration(labelText: 'Nome do Item'),
            ),
            SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                ElevatedButton(
                  onPressed: () async {
                    String updatedName = _itemNameController.text;
                    await DatabaseHelper.instance.updateItem(widget.item['id'], updatedName);
                    Navigator.pop(context);
                  },
                  child: Text('Atualizar'),
                ),
                ElevatedButton(
                  onPressed: () async {
                    await DatabaseHelper.instance.deleteItem(widget.item['id']);
                    Navigator.pop(context);
                  },
                  child: Text('Excluir'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _itemNameController.dispose();
    super.dispose();
  }
}



class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
  static Database? _database;

  DatabaseHelper._privateConstructor();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDatabase();
    return _database!;
  }

  _initDatabase() async {
    String path = join(await getDatabasesPath(), 'cadastro_database.db');
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE cadastro_items (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT
      )
    ''');
  }

  Future<void> insertItem(String name) async {
    final db = await database;
    await db.insert(
      'cadastro_items',
      {'name': name},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

 
  Future<List<Map<String, dynamic>>> queryAllItems({int limit = 50}) async {
    final db = await database;
    return await db.query('cadastro_items', limit: limit);
  }

  Future<void> updateItem(int id, String name) async {
    final db = await database;
    await db.update(
      'cadastro_items',
      {'name': name},
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> deleteItem(int id) async {
    final db = await database;
    await db.delete(
      'cadastro_items',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
