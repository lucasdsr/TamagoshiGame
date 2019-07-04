import 'package:flutter/material.dart';
import 'package:novoprojeto/ui/bd.dart';
import './main-bloc.dart';
import 'dart:async';

var db = new BD();
List listaPet;
Pet pet;
void main() async {
  listaPet = await db.pegarPets();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
    
    Timer.periodic(Duration(seconds: 1), (timer) {
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
              Container(
                height: 60,
                color: Colors.grey,
                child: ButtonBar(
                  alignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    FloatingActionButton(
                      tooltip: "Comida",
                      backgroundColor: Colors.brown,
                      onPressed: () {
                        print("Dando comida");
                        setState(() {
                          pet.setHunger(hunger + 5);
                          db.editarPet(pet);
                        });
                      },
                    ),
                    FloatingActionButton(
                      tooltip: "Saude",
                      backgroundColor: Colors.red,
                      onPressed: () {
                        print("Dando Saude");
                        setState(() {
                          pet.setHealth(health + 5);
                          db.editarPet(pet);
                        });
                      },
                      // child: Image.network("  "),
                    ),
                    FloatingActionButton(
                      tooltip: "Dormindo",
                      backgroundColor: Colors.black,
                      onPressed: () {
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
                      },
                      // child: Image.network("  "),
                    ),
                    FloatingActionButton(
                      tooltip: "Brincar",
                      backgroundColor: Colors.green,
                      onPressed: () {
                        print("Dando uma pleiada");
                        setState(() {
                          pet.setHappy(happy + 5);
                          db.editarPet(pet);
                        });
                      },
                      // child: Image.network("  "),
                    ),
                    FloatingActionButton(
                      tooltip: "Dar banho",
                      backgroundColor: Colors.blue,
                      onPressed: () {
                        print("Tomando banho");
                        setState(() {
                          pet.setDirty(dirty + 5);
                          db.editarPet(pet);
                        });
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
