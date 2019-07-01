import 'dart:math';

class Pet {
  var _id;
  var _name;
  var _lastTime;
  var _state;
  var _happy;
  var _hunger;
  var _health;
  var _sleep;
  var _dirty;

  
  Pet(this._name, this._lastTime, this._state, this._happy, this._hunger, this._health, this._sleep, this._dirty);

  Pet.map(dynamic obj) {
    // quando passamos um nome ele já recebe como objeto
    this._id = obj['Id'];
    this._name = obj['Name'];
    this._happy = obj['Happy'];
    this._hunger = obj['Hunger'];
    this._health = obj['Health'];
    this._sleep = obj['Sleep'];
    this._dirty = obj['Dirty'];
    this._state = obj['State'];
    this._lastTime = obj['LastTime'];
  } 

  // o map irá acessar uma key, como string, e depois uma chave que eu deseje
  Map<String, dynamic> toMap() {
    //instanciando o mapa
    var mapa = new Map<String, dynamic>();
    // agora iremos fazer o inverso do anterio, iremos colocar o conteúdo 
    // dos atributos no mapa, ficará como se fosse um json
    mapa["Name"] = _name;
    mapa["Happy"] = _happy;
    mapa["Hunger"] = _hunger;
    mapa["Health"] = _health;
    mapa["Sleep"] = _sleep;
    mapa["Dirty"] = _dirty;
    mapa["State"] = _state;
    mapa["LastTime"] = _lastTime.toString();

    // verificar se o id tem alguma coisa, para não adicionar nada em branco
    if (_id != null){
      mapa["id"] = _id;
    }
    return mapa;
 }

 Pet.fromMap(Map<String, dynamic> mapa) {
    // pegarei o mapa que estamos recebendo da funcao acima e colocando em _nome
    this._name = mapa['Name'];
    this._id = mapa['id'];
    this._happy = mapa['Happy'];
    this._hunger = mapa['Hunger'];
    this._health = mapa['Health'];
    this._sleep = mapa['Sleep'];
    this._dirty = mapa['Dirty'];
    this._state = mapa['State'];
    this._lastTime = mapa['LastTime'];
  }
 
  int getHappy() => _happy;
  int getHunger() => _hunger;
  int getHealth() => _health;
  int getSleep() => _sleep;
  int getDirty() => _dirty;
  String getState() => _state;
  int getId() => _id;

  void setHappy(happy) => _happy += happy;
  void setHunger(hunger) => _hunger += hunger;
  void setHealth(health) => _health += health;
  void setSleep(sleep) => _sleep += sleep;
  void setDirty(dirty) => _dirty += dirty;
  void setLastTime(lastTime) => _lastTime = lastTime;


  update() {
    var dateNow = new DateTime.now();
    var deltaTime =  dateNow.difference(DateTime.parse(_lastTime)).inMinutes; // delta desde útimo update()
    print("$deltaTime");
    var heightHunger = 1, heightHealth = 1, heightHappy = 1, heightDirty = 1, heightSleep = 1;

    // máquina de estados do vpet
    if (_state == 'sick') {
      heightHunger = 3;
      heightHealth = 3;
      heightHappy = 3;
      heightDirty = 3;
      heightSleep = 3;
    }else if (_state == 'tired' || _state == 'dirty') {
      heightHappy = 2;
    }else if(_state == 'sad') {
      heightHealth = 2;
    }else if(_state == 'sleeping') {
      heightHunger = 2;
      heightSleep = -3;
    }else if(_state == 'hunger') {
      heightHealth = 2;
      heightSleep = 2;
      heightHappy = 3;
    }

    // taxas estão relacionadas ao estado atual do Pet
    var hungerRate = 5, healthRate = 4, happyRate = 3, dirtyRate = 4, sleepRate = 3;
    // atualiza itens de status (versão "muito simples")
    Random rnd;
    rnd = new Random();

    _hunger -= (hungerRate * rnd.nextDouble() * heightHunger * deltaTime ).toInt();
    _health -= (healthRate * rnd.nextDouble() * heightHealth * deltaTime).toInt();
    _happy -= (happyRate * rnd.nextDouble() * heightHappy * deltaTime).toInt();
    _dirty -= (dirtyRate * rnd.nextDouble() * heightDirty * deltaTime).toInt();
    _sleep -= (sleepRate * rnd.nextDouble() * heightSleep * deltaTime).toInt();

    if(_sleep > 100) _sleep = 100;
    if(_hunger > 100) _hunger = 100;
    if(_health > 100) _health = 100;
    if(_happy > 100) _happy = 100;
    if(_dirty > 100) _dirty = 100;

    if(_sleep <= 0) _sleep = 0;
    if(_hunger <= 0) _hunger = 0;
    if(_health <= 0) _health = 0;
    if(_happy <= 0) _happy = 0;
    if(_dirty <= 0) _dirty = 0;
    // atualiza estados
    if (_happy < 25) _state = 'sad';
    else if (_health < 25) _state = 'sick';
    else if(_dirty < 25 ) _state = 'dirty';
    else if(_sleep < 25) _state = 'tired';
    else if(_hunger < 25) _state = 'hunger';
    else if(_happy >= 25 && _health >= 25 && _hunger >= 25 && _sleep >= 25) _state = 'normal';
    if (_happy <= 0 || _health <= 0 || _hunger <= 0 || _sleep <= 0) _state = 'dead';

    setLastTime((new DateTime.now()).toString());
    print("$_state");
  }
  
}
