import 'package:flutter/material.dart';
import 'package:novoprojeto/ui/bd.dart';
import './game.dart';
import './main-bloc.dart';
import 'dart:async';

List listaPet;
Pet pet;
var db;
void main() async {
  // int petSalvo = await db.inserirPet(new Pet("Piskel", DateTime.now().toString(), "normal",100,100,100,100,100));
  // listaPet = await db.pegarPets();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  void initDb() async {
    db = new BD();
    listaPet = await db.pegarPets();
  }
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    initDb();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tamagoshando',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Primeiro Tamagoshi'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // Pet pet;
  
  var happy;
  var hunger;
  var health;
  var sleep;
  var dirty;
  var state;
  var imageState;
  var isSleep;
  

  @override
  void initState() {
    super.initState();
    pet = Pet.map(listaPet[0]);
    pet.update();
    happy = pet.getHappy();
    hunger = pet.getHunger();
    health = pet.getHealth();
    sleep = pet.getSleep();
    dirty = pet.getDirty();
    state = pet.getState();
    isSleep = pet.getisSleep();
    pet.setinGame(1);
    db.editarPet(pet);
    
    Timer.periodic(Duration(seconds: 5), (timer) {
      if(pet.getinGame() == 1) {
          setState(() {
          pet.update();
          happy = pet.getHappy();
          hunger = pet.getHunger();
          health = pet.getHealth();
          sleep = pet.getSleep();
          dirty = pet.getDirty();
          state = pet.getState();
          isSleep = pet.getisSleep();
          db.editarPet(pet);      
        });
      } else {
        print("fora da tela do jogo");
      }
    });
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: Text(widget.title),
      ),
      body: Container(
        decoration: pet.getisSleep() == 0 ?
        BoxDecoration(color: Colors.black54): BoxDecoration(color: Colors.white),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(child: Text("Vida", textAlign: TextAlign.end,)),
                  Expanded(
                    flex: 5,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: LinearProgressIndicator(
                        backgroundColor: Colors.tealAccent[100],
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.tealAccent[700]),
                        value: health * .01,
                      ),
                    ),
                  ),
                  Expanded(child: Text("$health %", textAlign: TextAlign.center,)),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(child: Text("Feliz", textAlign: TextAlign.end,)),
                  Expanded(
                    flex: 5,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: LinearProgressIndicator(
                        backgroundColor: Colors.amber[50],
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.amber[400]),
                        value: happy * .01,
                      ),
                    ),
                  ),
                  Expanded(child: Text("$happy %", textAlign: TextAlign.center,)),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(child: Text("Fome", textAlign: TextAlign.end,)),
                  Expanded(
                    flex: 5,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: LinearProgressIndicator(
                        backgroundColor: Colors.red[50],
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.red[600]),
                        value: hunger * .01,
                      ),
                    ),
                  ),
                  Expanded(child: Text("$hunger %", textAlign: TextAlign.center,)),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(child: Text("Sono", textAlign: TextAlign.end,)),
                  Expanded(
                    flex: 5,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: LinearProgressIndicator(
                        backgroundColor: Colors.pink[50],
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.pink[600]),
                        value: sleep * .01,
                      ),
                    ),
                  ),
                  Expanded(child: Text("$sleep %", textAlign: TextAlign.center,)),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(child: Text("Sujeira", textAlign: TextAlign.end,)),
                  Expanded(
                    flex: 5,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: LinearProgressIndicator(
                        backgroundColor: Colors.brown[50],
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.brown[600]),
                        value: dirty * .01,
                      ),
                    ),
                  ),
                  Expanded(child: Text("$dirty %", textAlign: TextAlign.center,)),
                ],
              ),
              Expanded(
                child: 
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                        Column(
                          children: <Widget>[
                            pet.getisSleep() == 1 ?
                            Image.asset("Assets/Sprites/Piskel/$state.gif")
                            : Image.asset("Assets/Sprites/Piskel/sleeping.gif")
                          ],
                        ),
                      ],
                    ),
                  ],
                ), 
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  FloatingActionButton(
                    child: Icon(Icons.close),
                    tooltip: "Reiniciar Pet",
                    heroTag: 'bt6',
                    backgroundColor: Colors.black,
                    onPressed: () {
                      setState(() {
                        pet.setHappy(100);
                        pet.setDirty(100);
                        pet.setHealth(100);
                        pet.setHunger(100);
                        pet.setSleep(100);
                        pet.setState('normal');
                        happy = pet.getHappy();
                        hunger = pet.getHunger();
                        health = pet.getHealth();
                        sleep = pet.getSleep();
                        dirty = pet.getDirty();
                        state = pet.getState();
                        isSleep = pet.getisSleep();
                        pet.update();
                        db.editarPet(pet);
                      });
                    },
                  ),
                ],
              ),
              Container(
                height: 60,
                color: Colors.grey,
                child: ButtonBar(
                  alignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    FloatingActionButton(
                      child: Image.asset("Assets/Sprites/icons/Hungry_Icon.gif"),
                      tooltip: "Comida",
                      heroTag: 'bt1',
                      backgroundColor: Colors.brown,
                      onPressed: () {
                        if (pet.getisSleep() == 1 && state != 'dead') {
                          print("Dando comida");
                          setState(() {
                            pet.setHunger(hunger + 5);
                            pet.update();
                            hunger = pet.getHunger();
                            db.editarPet(pet);
                          });
                        }
                      },
                    ),
                    FloatingActionButton(
                      child: Image.asset("Assets/Sprites/icons/Health_Icon.gif"),
                      tooltip: "Saude",
                      heroTag: 'bt2',
                      backgroundColor: Colors.red,
                      onPressed: () {
                        if (pet.getisSleep() == 1 && state != 'dead') {
                          print("Dando Saude");
                          setState(() {
                            pet.setHealth(health + 5);
                            pet.update();
                            health = pet.getHealth();
                            db.editarPet(pet);
                          });
                        }
                      },
                      // child: Image.network("  "),
                    ),
                    FloatingActionButton(
                      child: Image.asset("Assets/Sprites/icons/Sleep_Icon.gif"),
                      tooltip: "Dormindo",
                      heroTag: 'bt3',
                      backgroundColor: Colors.black,
                      onPressed: () {
                        if (state != 'dead') {
                          print("Dando uma dormida");
                          setState(() {
                            if (state != "sleeping"){
                              pet.setisSleep();
                            } else {
                              pet.setisSleep();
                            }
                            pet.update();
                            sleep = pet.getSleep();
                            db.editarPet(pet);
                          });
                        }
                      },
                    ),
                    FloatingActionButton(
                      child: Image.asset("Assets/Sprites/icons/Game_Icon.gif"),
                      tooltip: "Brincar",
                      heroTag: 'bt4',
                      backgroundColor: Colors.green,
                      onPressed: () {
                        if (pet.getisSleep() == 1 && state != 'dead') {
                          setState(() {
                            pet.setHappy(happy + 30);
                            pet.update();
                            happy = pet.getHappy();
                            db.editarPet(pet);
                            pet.setinGame(0);
                          });
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => GameRoute()),
                          );
                        }
                      },
                    ),
                    FloatingActionButton(
                      child: Image.asset("Assets/Sprites/icons/Clean_Icon.gif"),
                      tooltip: "Dar banho",
                      heroTag: 'bt5',
                      backgroundColor: Colors.blue,
                      onPressed: () {
                        if (pet.getisSleep() == 1 && state != 'dead') {
                          print("Tomando banho");
                          setState(() {
                            pet.setDirty(dirty + 5);
                            pet.update();
                            dirty = pet.getDirty();
                            db.editarPet(pet);
                          });
                        }
                      },
                      // child: Image.network("  "),
                    )
                  ],
                ),
              ),
            ]),
      ),
    );
  }
}
