import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
      theme: ThemeData(
        backgroundColor: Colors.grey[900],
        textTheme: TextTheme(
            headline6: TextStyle(
              color: Colors.white,
              fontSize: 40,
            ),
            headline5: TextStyle(
              color: Colors.red,
              fontSize: 40,
            ),
            overline: TextStyle(
              color: Colors.black,
              fontSize: 20,
            )),
        fontFamily: 'Stick Regular',
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isO = true;
  List<String> displayXO = ['', '', '', '', '', '', '', '', ''];
  int oScore = 0;
  int xScore = 0;
  int filledTiles = 0;
  int currentAccent = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Column(
        children: [
          Expanded(
            child: Container(
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('o',
                            style: isO
                                ? Theme.of(context).textTheme.headline5
                                : Theme.of(context).textTheme.headline6),
                        Text('$oScore',
                            style: Theme.of(context).textTheme.headline6),
                      ],
                    ),
                    Padding(padding: EdgeInsets.all(50)),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('x',
                            style: isO
                                ? Theme.of(context).textTheme.headline6
                                : Theme.of(context).textTheme.headline5),
                        Text('$xScore',
                            style: Theme.of(context).textTheme.headline6),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: GridView.builder(
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
              itemCount: 9,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    _tapped(index);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey[700])),
                    child: Center(
                      child: Text(displayXO[index],
                          style: currentAccent == index
                              ? Theme.of(context).textTheme.headline5
                              : Theme.of(context).textTheme.headline6),
                    ),
                  ),
                );
              },
            ),
          ),
          Expanded(child: Container()),
        ],
      ),
    );
  }

  void _tapped(int index) {
    setState(() {
      if (displayXO[index] == '') {
        isO ? displayXO[index] = 'o' : displayXO[index] = 'x';
        isO = !isO;
        _checkWinner();
        filledTiles++;
        if (filledTiles == 9) _showDialog('', isWon: false);
        currentAccent = index;
      }
    });
  }

  void _showDialog(String winner, {bool isWon = true}) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(isWon ? '$winner is won!!!' : 'It\'s a draw!'),
            titleTextStyle: Theme.of(context).textTheme.overline,
          );
        });
    for (int i = 0; i < displayXO.length; i++) displayXO[i] = '';
    if (isWon) isO ? xScore++ : oScore++;
    filledTiles = 0;
  }

  void _checkWinner() {
    if (displayXO[0] == displayXO[1] &&
        displayXO[0] == displayXO[2] &&
        displayXO[0] != '') _showDialog(displayXO[0]);

    if (displayXO[3] == displayXO[4] &&
        displayXO[3] == displayXO[5] &&
        displayXO[3] != '') _showDialog(displayXO[3]);

    if (displayXO[6] == displayXO[7] &&
        displayXO[6] == displayXO[8] &&
        displayXO[6] != '') _showDialog(displayXO[6]);

    if (displayXO[0] == displayXO[3] &&
        displayXO[0] == displayXO[6] &&
        displayXO[0] != '') _showDialog(displayXO[0]);

    if (displayXO[1] == displayXO[4] &&
        displayXO[1] == displayXO[7] &&
        displayXO[1] != '') _showDialog(displayXO[1]);

    if (displayXO[2] == displayXO[5] &&
        displayXO[2] == displayXO[8] &&
        displayXO[2] != '') _showDialog(displayXO[2]);

    if (displayXO[0] == displayXO[4] &&
        displayXO[0] == displayXO[8] &&
        displayXO[0] != '') _showDialog(displayXO[0]);

    if (displayXO[2] == displayXO[4] &&
        displayXO[2] == displayXO[6] &&
        displayXO[2] != '') _showDialog(displayXO[2]);
  }
}
