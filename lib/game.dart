import 'package:flutter/material.dart';
import 'main.dart';
import 'dart:math';

class GameRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tamagoshando',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Game(title: 'Game das contas'),
    );
  }
}

class Game extends StatefulWidget {
  Game({Key key, this.title}) : super(key: key);

  final String title;
  @override
  _MyGameState createState() => _MyGameState();
}

class _MyGameState extends State<Game> {
  var firstOperator;
  var secondOperator;
  var result;
  var error;

  final myController = TextEditingController();

  void submit() {
    print("Dando comida $result");
    setState(() {
      if (result != '?') {
        if (int.parse(result) == firstOperator + secondOperator) {
          error = 'acertouuuuuuu';
          // setState(() {
          //   pet.setHappy(happy + 5);
          //   pet.update();
          //   happy = pet.getHappy();
          //   db.editarPet(pet);
          // });
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MyApp()));
        } else {
          error = 'Errou, \n mas continue tentando \n que ta legal S2';
        }
      } else {
        error = 'Errou, \n mas continue tentando \n que ta legal S2';
      }
    });
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    Random rnd;
    rnd = new Random();
    firstOperator = rnd.nextInt(9);
    secondOperator = rnd.nextInt(9);
    result = '?';
    error = 'Tente acertar qual a soma';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: Text(widget.title),
      ),
      body: Container(
        decoration: BoxDecoration(color: Colors.white),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('$error', textScaleFactor: 2),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('$firstOperator + $secondOperator = $result',
                    textScaleFactor: 5),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: TextField(
                keyboardType: TextInputType.numberWithOptions(
                    signed: true, decimal: false),
                decoration: InputDecoration(),
                controller: myController,
                onChanged: (text) {
                  setState(() {
                    result = myController.value.text;
                  });
                },
              ),
            ),
            Row(),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
              RaisedButton(
                color: Colors.blue,
                child: Icon(Icons.done),
                onPressed: submit
              )
            ])
          ],
        ),
      ),
    );
  }
}
