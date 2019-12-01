import 'package:flutter/material.dart';

class TicTacToeButton {
  final id;
  String text;
  Color bg;
  bool enabled;

  TicTacToeButton(
      {this.id, this.text = "", this.bg = Colors.grey, this.enabled = true});
}

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tic-Tac-Toe',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Tic-Tac-Toe'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  /*
  int player represents the active player:
  0 = the 'X' player
  1 = the 'O' player

  Every time a button is pushed, the player flips

  Upon pressing a button in the GUI, clickButton is called 
  and the corresponding button will either switch to 'X'
  or 'O' depending on the player. 

  Once the button has swapped, we'll have to check which player
  just played and what button was changed. Check the stubbed-out
  'checkWin()' method.

  Given the button index 'i' and the last player int 'p', we need
  to check the cases for a win (horizontal, vertical, oblique, etc.)
  and return whether or not this was a win.

  Think of the buttonList like this:
  [0][1][2]
  [3][4][5]
  [6][7][8]
  */


  int player; // 0 for X, 1 for O
  int _xWins = 0;
  int _oWins = 0;
  int _draws = 0;
  int enableCount = 9;
  List<TicTacToeButton> buttonList; 
  
  @override
  void initState() {
    super.initState();
    buttonList = new List<TicTacToeButton>(); 
    for (var i = 0; i <= 9; i++) {
      buttonList.add(new TicTacToeButton(id: i));  
    }
    player = 0;
  }

  void newGame(){
    player = 0;
    enableCount = 9;
    for (TicTacToeButton b in buttonList) {
      setState(() {
        b.text = "";
        b.enabled = true;
        b.bg = Colors.grey;
      });
    }
  }

  void resetGame(){
    newGame();
  //Reset score labels
  }

  void clickButton(TicTacToeButton b, int buttonIndex) {
    enableCount--;
    int lastPlayer = player;
    setState(() {
      if(player == 0) { // X's turn
        b.text = "X";
        b.bg = Colors.blue;
        b.enabled = false;
        player = 1;
      } else {  // O's turn
        b.text = "O";
        b.bg = Colors.orange;
        b.enabled = false;
        player = 0;
      }
    });

    if(isWin(buttonIndex, lastPlayer)) {
      for (TicTacToeButton b in buttonList)
        b.enabled = false;
      if (lastPlayer == 0)
          _xWins++;
        else _oWins++;
    } else if (enableCount == 0)
      _draws++;
  }

  bool isWin(int i, int p) {
//Initializing neede variables
    int rangeMin =0;
    int rangeMax =0;
    String winningText = (playerText(p));
    int possible = i;
    int valid = 0;
    bool keepGoing = true;

//Checking the minimum and maximum possible values in a row
    if(i == 0 || i == 1 || i == 2){
      rangeMin = 0;
      rangeMax = 2;
    } 
    if(i == 3 || i == 4 || i == 5){
      rangeMin = 3;
      rangeMax = 5;
    }
    if(i == 6 || i == 7 || i == 8){
      rangeMin = 6;
      rangeMax = 8;
    }

  //Checking for horizontal wins
    while(keepGoing){
      possible++;
      if(possible <= rangeMax){
        if(winningText == buttonList[possible].text){
          valid++;
        }
      }
      else{
        keepGoing = false;
      }
      if(valid == 2){
        return true;
      }
    }
    possible = i;
    keepGoing = true;

    while(keepGoing){
      possible--;
      if(possible >= rangeMin){
        if(winningText == buttonList[possible].text){
          valid++;
        }
      }
      else{
        keepGoing = false;
      }
      if(valid == 2){
        return true;
      }
    }

//Checking for vertical wins
  possible = i;
  keepGoing = true;
  valid = 0;
    while(keepGoing){
      possible+=3;
      if(possible <= 8){
        if(winningText == buttonList[possible].text){
          valid++;
        }
      }
      else{
        keepGoing = false;
      }
      if(valid == 2){
        return true;
      }
    }
    possible = i;
    keepGoing = true;

    while(keepGoing){
      possible -=3;
      if(possible >= 0){
        if(winningText == buttonList[possible].text){
          valid++;
        }
      }
      else{
        keepGoing = false;
      }
      if(valid == 2){
        return true;
      }
    }
    
//Check for diagonal wins only if 0,2,4,6,8
if(i == 0){
  if(winningText == buttonList[4].text && winningText == buttonList[8].text){
    return true;
  }
}
if(i == 2){
  if(winningText == buttonList[4].text && winningText == buttonList[6].text){
    return true;
  }
}
if(i == 4){
  if(winningText == buttonList[0].text && winningText == buttonList[8].text){
    return true;
  }
  else if(winningText == buttonList[2].text && winningText == buttonList[6].text){
    return true;
  }
}
if(i == 6){
  if(winningText == buttonList[4].text && winningText == buttonList[2].text){
    return true;
  }
}
if (i == 8){
  if(winningText == buttonList[4].text && winningText == buttonList[0].text){
    return true;
  }
}

//Return false if none of the above are found to be true
    return false;
  }

  String playerText(int p){
    if(p == 0){
      return "X";
    }
    else{
      return "O";
    }
  }

  @override
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: 
      new Center(child: 
          new Column(children: <Widget>[
            new Row(children: <Widget>[
              Expanded(child: RaisedButton(
                onPressed: () {
                  resetGame();
                },
                child: Text("Next Game"))),
              Expanded(child: RaisedButton(
                onPressed: () {
                  _xWins = 0;
                  _draws = 0;
                  _oWins = 0;
                  resetGame();
                },
                child: Text("Reset Game")))]),
             new Row(children: <Widget>[
            Expanded(child: Text("'X' Wins: $_xWins",
                                 textAlign: TextAlign.center)),
            Expanded(child: Text("Draws: $_draws",
                                 textAlign: TextAlign.center)),
            Expanded(child: Text("'O' Wins: $_oWins",
                                 textAlign: TextAlign.center))
            ]),
          new Container(
            height: 400, 
            width: 400,
            child: new GridView.builder(
              padding: const EdgeInsets.all(10.0),
              gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 1.0,
                crossAxisSpacing: 9.0,
                mainAxisSpacing: 9.0
              ),
              itemCount: 9,
              itemBuilder: (context, i) => new SizedBox(
                width: 50.0,
                height: 50.0,
                child: new RaisedButton(
                  onPressed: buttonList[i].enabled
                    ? () => clickButton(buttonList[i], i)
                    : null,
                  padding: const EdgeInsets.all(8.0),
                  child: new Text(
                    buttonList[i].text,
                    style: new TextStyle(
                      color: Colors.black, 
                      fontSize: 50.0,
                    ),
                  ),
                  color: buttonList[i].bg,
                  disabledColor: buttonList[i].bg,
                ),
              ),
            ),
          )     // /container
        ])      // /column
        )       // /center
      );        // /scaffold
  }
}
