import 'package:flutter/material.dart';
import 'package:cs_354/tic_tac_toe_button.dart';

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
  List<TicTacToeButton> buttonList = <TicTacToeButton>[
    new TicTacToeButton(id: 1),
    new TicTacToeButton(id: 2),
    new TicTacToeButton(id: 3),
    new TicTacToeButton(id: 4),
    new TicTacToeButton(id: 5),
    new TicTacToeButton(id: 6),
    new TicTacToeButton(id: 7),
    new TicTacToeButton(id: 8),
    new TicTacToeButton(id: 9),
  ];

  void clickButton(TicTacToeButton b, int buttonIndex) {
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
      // TODO handle win scenario
    }
  }

  bool isWin(int i, int p) {
    // TODO check if last move was a winning move 
    return false;
  }

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
          )
        )
      );
  }
}
