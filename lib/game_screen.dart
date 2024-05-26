import 'package:flutter/material.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  var grid = [
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
  ];

  var currentPlayer = "X";
  var winner = "";

  void drawXO(i) {
    if (grid[i] == "") {
      setState(() {
        grid[i] = currentPlayer;
        currentPlayer = currentPlayer == "X" ? "O" : "X";
      });
      findWinner(grid[i]);
    }
  }

  void resetGame() {
    setState(() {
      grid = [
        "",
        "",
        "",
        "",
        "",
        "",
        "",
        "",
        "",
      ];
      currentPlayer = "X";
      winner = "";
    });
  }

  bool checkMove(int i1, int i2, int i3, String sign) {
    return grid[i1] == sign && grid[i2] == sign && grid[i3] == sign;
  }

  void findWinner(String currentsign) {
    if (checkMove(0, 1, 2, currentsign) ||
        checkMove(3, 4, 5, currentsign) ||
        checkMove(6, 7, 8, currentsign) ||
        checkMove(0, 3, 6, currentsign) ||
        checkMove(1, 4, 7, currentsign) ||
        checkMove(2, 5, 8, currentsign) ||
        checkMove(0, 4, 8, currentsign) ||
        checkMove(2, 4, 6, currentsign)) {
      setState(() {
        winner = currentsign;
      });
      showWinnerDialog("$currentsign Win!");
    }
    else if (!grid.contains("")){
      showWinnerDialog("It's Draw");
    }
  }

  void showWinnerDialog(String message) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.amber,
            title: const Text(
              "Game Over",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 28),
            ),
            content: Text(
              message,
              style: TextStyle(fontSize: 24),
            ),
            actions: [
              TextButton.icon(
                onPressed: () {
                  Navigator.of(context).pop();
                  resetGame();
                },
                style: TextButton.styleFrom(
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                ),
                icon: const Icon(Icons.refresh),
                label: const Text("Play Again!"),
              )
            ],
          );
        }).then((_) => resetGame());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tic Tac Toe"),
        backgroundColor: Colors.amber,
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              color: Colors.black,
              constraints: const BoxConstraints(maxWidth: 300, maxHeight: 300),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                ),
                itemCount: grid.length,
                itemBuilder: (context, index) => Material(
                  color: Colors.amber,
                  child: InkWell(
                    onTap: () => drawXO(index),
                    splashColor: Colors.black38,
                    child: Center(
                      child: Text(
                        grid[index],
                        style: const TextStyle(fontSize: 32),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30.0),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.amber,
                foregroundColor: Colors.black,
                elevation: 20.0,
              ),
              onPressed: () => resetGame(),
              icon: const Icon(Icons.refresh),
              label: const Text("Restart Game"),
            ),
          ],
        ),
      ),
    );
  }
}
