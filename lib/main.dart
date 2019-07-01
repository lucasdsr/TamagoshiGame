import 'package:flutter/material.dart';
import 'package:novoprojeto/ui/bd.dart';
import './main-bloc.dart';

var db = new BD();
List listaPet;
Pet pet;
void main() async {
  // criando nossa classe BD
  // var petSalvo = await db.inserirPet(new Pet("Primeiro Pet", (new DateTime.now()).toString(), "normal", 100, 100, 100, 100, 100));
  // print("usuário inserido $petSalvo");

  listaPet = await db.pegarPets();
  //   pet = Pet.map(listaPet[0]);
  
  //add usuario que irá retornar um int

  

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
  var happy ;
  var hunger;
  var health;
  var sleep;
  var dirty;

  
  @override
  void initState() {
    pet = Pet.map(listaPet[0]);
    pet.update();
    happy = pet.getHappy();
    hunger = pet.getHunger();
    health = pet.getHealth();
    sleep = pet.getSleep();
    dirty = pet.getDirty();

    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: Text(widget.title),
      ),
      body: Container(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text('felicidade: $happy | '),
                                Text('Fome: $hunger | '),
                                Text('Saude: $health | '),
                                Text('Sono: $sleep | '),
                                Text('Sujeira: $dirty'),
                              ],
                            ),
                            Image.network(
                              // pet.getState() == "normal" ? 
                              'https://pm1.narvii.com/7106/ff9fd8c887e8b59973641c658eb3c3d6b0db4dc6r1-720-652v2_128.jpg',
                            ),
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

                      },
                    ),
                    FloatingActionButton(
                      tooltip: "Saude",
                      backgroundColor: Colors.red,
                      onPressed: () {
                        print("Dando Saude");
                      },
                      // child: Image.network("  "),
                    ),
                    FloatingActionButton(
                      tooltip: "Dormindo",
                      backgroundColor: Colors.black,
                      onPressed: () {
                        print("Dando uma dormida");
                      },
                      // child: Image.network("  "),
                    ),
                    FloatingActionButton(
                      tooltip: "Brincar",
                      backgroundColor: Colors.green,
                      onPressed: () {
                        print("Dando uma pleiada");
                      },
                      // child: Image.network("  "),
                    )
                  ],
                ),
              ),
            ]
            //     children: <Widget>[
            //       Text(
            //         'You have pushed the button this many times:',
            //       ),
            //       Text(
            //         '$_counter',
            //         style: TextStyle(
            //           color: Color(0xff444444),
            //           fontSize: 150,
            //         ),
            //       ),
            //     ],
            ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: _incrementCounter,
      //   tooltip: 'Increment',
      //   child: Icon(Icons.add),
      // ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
