import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import "../main-bloc.dart";

class BD {
 // criaremos uma variável static, pois nunca irá mudar
 static final BD _instance = new BD.internal();

 // criaremos uma classe factory porque não será recriada sempre que chamarmos a classe BD (POO)
 factory BD() => _instance;

 // internal é um construtor então toda vez que precisamos é só instanciá-lo
 BD.internal();

 // criando o esqueleto da nossa tabela do banco de dados
 final String tabelaPet = "TabelaPet";
 final String colunaId = "Id";
 final String colunaName = "Name";
 final String colunaHappy = "Happy";
 final String colunaHunger = "Hunger";
 final String colunaHealth = "Health";
 final String colunaDirty = "Dirty";
 final String colunaSleep = "Sleep";
 final String colunaState = "State"; 
 final String colunaLastTime = "LastTime";

 //Database é a classe do SQFlite que iremos usar, por isso iremos criá-la
 static Database _db;

  // sempre que formos acessar alguma coisa utilizar o future, pois ele é uma transação alheia
  Future<Database> get db async {
    // se o _db existe na memória
    if(_db != null){
      //caso exista, retorna este _bd existente
      return _db;
    }
    // chamamos agora o initBd que irá iniciar o nosso banco de dados
    _db = await initBd();
    return _db;
  }

  // iniciando nosso banco de dados em async pois ele é uma transição
  initBd() async {
    // Directory faz parte do plugin dart:io e o getApplicationDocumentsDirectory() faz parte do path_provider
    // aqui nós estamos acessando o diretório nativo do android
    Directory documentoDiretorio = await getApplicationDocumentsDirectory();

    // o join() junta duas coisas, no caso iremos juntar o diretorio juntamente com o nosso banco de dados
    String caminho = join(
      documentoDiretorio.path, "bd_principal.db"
    );

    // após ter acesso ao local do nosso BD, iremos abri-lo
    var nossoBD = await openDatabase(caminho, version: 1, onCreate: _onCreate);
    return nossoBD;
 
  }

  //criando o método _onCreate que irá criar o nosso BD
  void _onCreate(Database db, int version) async {
    // aqui iremos colocar o SQL que é outra linguagem, por isso, colocaremos
    // dentro de aspas, pois é string
    await db.execute("CREATE TABLE $tabelaPet($colunaId INTEGER PRIMARY KEY,"
      "$colunaName TEXT,"
      "$colunaHappy INTEGER,"
      "$colunaHunger INTEGER,"
      "$colunaHealth INTEGER,"
      "$colunaDirty INTEGER,"
      "$colunaSleep INTEGER,"
      "$colunaState INTEGER,"
      "$colunaLastTime TEXT)");
  }

  Future<int> inserirPet(Pet pet) async {
  // o db aqui é do get escrito lá no início
  // ao inserirmos um usuario, temos que criar um já esta instância de db
  // esse db irá retornar um database
  var bdCliente = await db;

  // para inserir temos que passar uma tabela e valores que pode ser um mapa
  // ese mapa é aquele que criamos em usuarios.dart
  int res = await bdCliente.insert("$tabelaPet", pet.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);

  // aqui irá retornar um número
  return res;
  }

 // para podermos pegar os usuarios criados
  Future<List> pegarPets() async {
    // praticamente iremos fazer a mesma coisa da função de inserir
    var bdCliente = await db;

    // rawQuery é como se fosse um pedido, então iremos solicitar todos os dados
    var res = await bdCliente.rawQuery("SELECT * FROM $tabelaPet");
    // agora iremos retornar uma list
    return res.toList();
 }

 Future<int> pegarContagem() async {
    var bdCliente = await db;
    // para pegarmos a contagem temos que ir na SQFlite e utilizar o firstIntValue
    return Sqflite.firstIntValue(await bdCliente.rawQuery("SELECT COUNT(*) FROM $tabelaPet"));
  }

  // iremos mostrar somente um usuário
  Future<Pet> pegarUnicoPet(int id) async {
    var bdCliente = await db;
    var res = await bdCliente.rawQuery("SELECT * FROM $tabelaPet"
              " WHERE $colunaId = $id"); 

    // verificando se a lista retorna nada
    if (res.length == 0) return null;

    // iremos retornar um mapa dos dados, pega só o primeiro 
    return new Pet.fromMap(res.first);
 }

  Future<int> apagarPet(int id) async {
    var bdCliente = await db;

    // where é o local de onde iremos deletar os dados
    return await bdCliente.delete(tabelaPet,
      where: "$colunaId = ?", whereArgs: [id]);
  }

  Future<int> editarPet(Pet pet) async {
    var bdCliente = await db;
    // usaremos o toMap
    print("cheguei aqui tambem");
    return await bdCliente.update(tabelaPet,
      pet.toMap(), where: "$colunaId = ?", whereArgs: [pet.getId()]
    );
    
  } 

   deleteOptionTable() async {
    final bdCliente = await db;
    bdCliente.rawDelete("DROP TABLE IF EXISTS *");
  }

  Future fechar() async {
    var bdCliente = await db;

    return bdCliente.close();
  } 
}