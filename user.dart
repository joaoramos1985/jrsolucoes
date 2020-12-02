import 'package:flutter/material.dart';

class Pessoa {
  String _nome;
  double num1;
  double num2;
  double result = 0;

  Pessoa(this.num1, this.num2, [this._nome]) {
    this.result = calcularResultado();
  }

  double calcularResultado() {
    return num1 + num2;
  }
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final List<Pessoa> lista = []; // Lista vazia

  MyApp() {
    Pessoa pessoa1 = Pessoa(55.5, 193, "Claudio");
    Pessoa pessoa2 = Pessoa(89.0, 100, "Ana");
    lista.add(pessoa1);
    lista.add(pessoa2);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Aula de Flutter",
      theme: ThemeData(
        primarySwatch: Colors.grey,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(lista),
    );
  }
}

class HomePage extends StatefulWidget {
  final List<Pessoa> lista;

  // Construtor
  HomePage(this.lista);

  @override
  _HomePageState createState() => _HomePageState(lista);
}

class _HomePageState extends State<HomePage> {
  final List<Pessoa> lista;

  // Construtor
  _HomePageState(this.lista);

  // Métodos
  void _atualizarTela() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    return Scaffold(
      drawer: NavDrawer(lista),
      appBar: AppBar(
        title: Text("Pessoas (${lista.length})"),
      ),
      body: ListView.builder(
          itemCount: lista.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              title: Text(
                "${lista[index]._nome}",
                style: TextStyle(fontSize: 18.0),
              ),
              onTap: () {},
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: _atualizarTela,
        tooltip: 'Atualizar',
        child: Icon(Icons.update),
      ),
    );
  }
}

class NavDrawer extends StatelessWidget {
  // Atributos
  final List lista;
  final double _fontSize = 16.0;

  // Construtor
  NavDrawer(this.lista);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          // Opcional
          DrawerHeader(
            child: Text(
              "Menu",
              style: TextStyle(color: Colors.white, fontSize: 25),
            ),
            decoration: BoxDecoration(color: Colors.black),
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text(
              "Informações do Pessoa",
              style: TextStyle(fontSize: _fontSize),
            ),
            onTap: () {
              Navigator.pop(context); 
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TelaInformacoesDoPessoa(lista),
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.person_search),
            title: Text(
              "Buscar por um Pessoa",
              style: TextStyle(fontSize: _fontSize),
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TelaBuscarPorPessoa(),
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.person_add_alt_1_sharp),
            title: Text(
              "Cadastrar um Novo Pessoa",
              style: TextStyle(fontSize: _fontSize),
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TelaCadastrarPessoa(lista),
                ),
              );
            },
          ),
          Container(
            padding: EdgeInsets.all(20.0),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: ListTile(
              leading: Icon(Icons.face),
              title: Text(
                "Sobre",
                style: TextStyle(fontSize: _fontSize),
              ),
              onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TelaCadastrarPessoa(lista),
                ),
              );
            },
          ),
            ),
       
        ],
      ),
    );
  }
}

//-----------------------------------------------------------------------------
// Tela Informações do Pessoa
//-----------------------------------------------------------------------------

class TelaInformacoesDoPessoa extends StatefulWidget {
  final List<Pessoa> lista;

  // Construtor
  TelaInformacoesDoPessoa(this.lista);

  @override
  _TelaInformacoesDoPessoa createState() => _TelaInformacoesDoPessoa(lista);
}

class _TelaInformacoesDoPessoa extends State<TelaInformacoesDoPessoa> {
  // Atributos
  final List lista;
  Pessoa pessoa;
  int index = -1;
  double _fontSize = 18.0;
  final nomeController = TextEditingController();
  final num1Controller = TextEditingController();
  final num2Controller = TextEditingController();
  final resultController = TextEditingController();
  bool _edicaoHabilitada = false;

  // Construtor
  _TelaInformacoesDoPessoa(this.lista) {
    if (lista.length > 0) {
      index = 0;
      pessoa = lista[0];
      nomeController.text = pessoa._nome;
      num1Controller.text = pessoa.num1.toString();
      num2Controller.text = pessoa.num2.toString();
      resultController.text = pessoa.result.toStringAsFixed(1);
    }
  }

  // Métodos
  void _exibirRegistro(index) {
    if (index >= 0 && index < lista.length) {
      this.index = index;
      pessoa = lista[index];
      nomeController.text = pessoa._nome;
      num1Controller.text = pessoa.num1.toString();
      num2Controller.text = pessoa.num2.toString();
      resultController.text = pessoa.result.toStringAsFixed(1);
      setState(() {});
    }
  }

  void _atualizarDados() {
    if (index >= 0 && index < lista.length) {
      _edicaoHabilitada = false;
      lista[index]._nome = nomeController.text;
      lista[index].num1 = double.parse(num1Controller.text);
      lista[index].num2 = double.parse(num2Controller.text);
      lista[index].result = lista[index].calcularResultado();
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    var titulo = "Informações do Pessoa";
    if (pessoa == null) {
      return Scaffold(
        appBar: AppBar(title: Text(titulo)),
        body: Column(
          children: <Widget>[
            Text("Nenhum pessoa encontrado!"),
            Container(
              color: Colors.grey,
              child: BackButton(),
            ),
          ],
        ),
      );
    }
    return Scaffold(
      appBar: AppBar(title: Text(titulo)),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Align(
              alignment: Alignment.topRight,
              child: FloatingActionButton(
                heroTag: null,
                onPressed: () {
                  _edicaoHabilitada = true;
                  setState(() {});
                },
                tooltip: 'Primeiro',
                child: Text("Hab. Edição"),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(5),
              child: TextField(
                enabled: _edicaoHabilitada,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Nome completo",
                  // hintText: "Nome do pessoa",
                ),
                style: TextStyle(fontSize: _fontSize),
                controller: nomeController,
              ),
            ),
            
            Padding(
              padding: EdgeInsets.all(5),
              child: TextField(
                enabled: _edicaoHabilitada,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "PRIMEIRO NÚMERO",
                  hintText: 'PRIMEIRO NÚMERO',
                ),
                style: TextStyle(fontSize: _fontSize),
                controller: num1Controller,
              ),
            ),
            // --- Altura do Pessoa ---
            Padding(
              padding: EdgeInsets.fromLTRB(5, 5, 5, 20),
              child: TextField(
                enabled: _edicaoHabilitada,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "SEGUNDO NÚMERO",
                  hintText: "SEGUNDO NÚMERO",
                ),
                style: TextStyle(fontSize: _fontSize),
                controller: num2Controller,
              ),
            ),
           
            Padding(
              padding: EdgeInsets.fromLTRB(5, 5, 5, 20),
              child: TextField(
                enabled: false,
                // keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "RESULTADO",
                  hintText: "RESULTADO",
                ),
                style: TextStyle(fontSize: _fontSize),
                controller: resultController,
              ),
            ),
            RaisedButton(
              child: Text(
                "Atualizar Dados",
                style: TextStyle(fontSize: _fontSize),
              ),
              onPressed: _atualizarDados,
            ),
            Text(
              "[${index + 1}/${lista.length}]",
              style: TextStyle(fontSize: 15.0),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <FloatingActionButton>[
                  FloatingActionButton(
                    heroTag: null,
                    onPressed: () => _exibirRegistro(0),
                    tooltip: 'Primeiro',
                    child: Icon(Icons.first_page),
                  ),
                  FloatingActionButton(
                    heroTag: null,
                    onPressed: () => _exibirRegistro(index - 1),
                    tooltip: 'Primeiro',
                    child: Icon(Icons.navigate_before),
                  ),
                  FloatingActionButton(
                    heroTag: null,
                    onPressed: () => _exibirRegistro(index + 1),
                    tooltip: 'Primeiro',
                    child: Icon(Icons.navigate_next),
                  ),
                  FloatingActionButton(
                    heroTag: null,
                    onPressed: () => _exibirRegistro(lista.length - 1),
                    tooltip: 'Primeiro',
                    child: Icon(Icons.last_page),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//-----------------------------------------------------------------------------
// Tela: Buscar por Pessoa
// ----------------------------------------------------------------------------

class TelaBuscarPorPessoa extends StatefulWidget {
  @override
  _TelaBuscarPorPessoaState createState() => _TelaBuscarPorPessoaState();
}

class _TelaBuscarPorPessoaState extends State<TelaBuscarPorPessoa> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Buscar por Pessoa")),
     
    );
  }
}



//-----------------------------------------------------------------------------
// Tela: Cadastrar Pessoa
// ----------------------------------------------------------------------------

class TelaCadastrarPessoa extends StatefulWidget {
  final List<Pessoa> lista;

  // Construtor
  TelaCadastrarPessoa(this.lista);

  @override
  _TelaCadastrarPessoaState createState() =>
      _TelaCadastrarPessoaState(lista);
}

class _TelaCadastrarPessoaState extends State<TelaCadastrarPessoa> {
  // Atributos
  final List<Pessoa> lista;
  String _nome = "";
  double num1 = 0.0;
  double num2 = 0.0;
  double _fontSize = 20.0;
  final nomeController = TextEditingController();
  final num1Controller = TextEditingController();
  final num2Controller = TextEditingController();
  final resultController = TextEditingController();

  // Construtor
  _TelaCadastrarPessoaState(this.lista);

  // Métodos
  void _cadastrarPessoa() {
    _nome = nomeController.text;
    num1 = double.parse(num1Controller.text);
    num2 = double.parse(num2Controller.text);
    if (num1 > 0 && num2 > 0) {
      var pessoa = Pessoa(num1, num2, _nome); // Cria um novo objeto
      // result = pessoa.result;
      lista.add(pessoa);
      // _index = lista.length - 1;
      nomeController.text = "";
      num1Controller.text = "";
      num2Controller.text = "";
      resultController.text = "${pessoa.result.toStringAsFixed(1)}";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cadastrar Pessoa (???)"),
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: Text(
                "Dados do Pessoa:",
                style: TextStyle(fontSize: _fontSize),
              ),
            ),
            // --- Nome do Pessoa ---
            Padding(
              padding: EdgeInsets.all(5),
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Nome completo",
                  // hintText: "Nome do pessoa",
                ),
                style: TextStyle(fontSize: _fontSize),
                controller: nomeController,
              ),
            ),
            
            Padding(
              padding: EdgeInsets.all(5),
              child: TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "PRIMEIRO NÚMERO",
                  hintText: 'PRIMEIRO NÚMERO',
                ),
                style: TextStyle(fontSize: _fontSize),
                controller: num1Controller,
              ),
            ),
            
            Padding(
              padding: EdgeInsets.fromLTRB(5, 5, 5, 20),
              child: TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "SEGUNDO NÚMERO",
                  hintText: "SEGUNDO NÚMERO",
                ),
                style: TextStyle(fontSize: _fontSize),
                controller: num2Controller,
              ),
            ),
         
            Padding(
              padding: EdgeInsets.fromLTRB(5, 5, 5, 20),
              child: TextField(
                enabled: false,
                // keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "RESULTADO",
                  hintText: "RESULTADO",
                ),
                style: TextStyle(fontSize: _fontSize),
                controller: resultController,
              ),
            ),
            // Saída
            RaisedButton(
              child: Text(
                "Cadastrar Pessoa",
                style: TextStyle(fontSize: _fontSize),
              ),
              onPressed: _cadastrarPessoa,
            ),
          ],
        ),
      ),
    );
  }
}