import 'package:flutter/material.dart';

void main() {
  runApp(myapp());
}

class myapp extends StatefulWidget {
  const myapp({super.key});

  @override
  State<myapp> createState() => _myappState();
}

class _myappState extends State<myapp> {
  var grid = ['-', '-', '-', '-', '-', '-', '-', '-', '-'];
  var winner = '';
  var currentplayer = 'X';
  void drawxo(i) {
    if (grid[i] == '-')
      setState(() {
        grid[i] = currentplayer;
        currentplayer = currentplayer == 'X' ? 'O' : 'X';
      });
    findwinner(grid[i]);
  }

  bool checkmove(i1, i2, i3, sign) {
    if (grid[i1] == sign && grid[i2] == sign && grid[i3] == sign) {
      return true;
    }
    return false;
  }

  void findwinner(currentsign) {
    if (checkmove(0, 1, 2, currentsign) ||
            checkmove(3, 4, 5, currentsign) ||
            checkmove(3, 4, 5, currentsign) || //rows

            checkmove(0, 3, 6, currentsign) ||
            checkmove(1, 4, 7, currentsign) ||
            checkmove(2, 5, 8, currentsign) || //column
            checkmove(0, 4, 8, currentsign) ||
            checkmove(2, 4, 6, currentsign) //diagonals

        ) {
      //print('$currentsign won');
      setState(() {
        winner = currentsign;
      });
    }
  }

  void reset() {
    setState(() {
      grid = ['-', '-', '-', '-', '-', '-', '-', '-', '-'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Tic Tac Toe",
      theme: ThemeData(primaryColor: Colors.amber),
      home: Scaffold(
          appBar: AppBar(
            title: Text('Tic tac toe'),
          ),
          body: SingleChildScrollView(
            child: Center(
              child: Column(
                children: [
                  if (winner != "")
                    Text(
                      '$winner won the game',
                      style: TextStyle(fontSize: 30),
                    ),
                  Container(
                    margin: EdgeInsets.all(20),
                    color: Colors.black,
                    child: GridView.builder(
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10),
                      itemCount: grid.length,
                      itemBuilder: (context, index) => Material(
                        color: Colors.amber,
                        child: InkWell(
                          splashColor: Colors.black,
                          onTap: () {
                            drawxo(index);
                          },
                          child: Center(
                            child: Text(
                              grid[index],
                              style: TextStyle(fontSize: 50),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  ElevatedButton.icon(
                      onPressed: reset,
                      icon: Icon(Icons.refresh),
                      label: Text("play again"))
                ],
              ),
            ),
          )),
    );
  }
}
