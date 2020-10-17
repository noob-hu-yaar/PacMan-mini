import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gamess/path.dart';
import 'package:gamess/pixel.dart';
import 'package:gamess/player.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static int numberInRow = 11;
  int numberOfSquares = numberInRow * 16;
  int player = numberInRow * 14 + 1; //pos of player
  bool mouthClosed = false;
  bool ate = true;
  int score = 0;

  List<int> barriers = [
    0,
    1,
    2,
    3,
    4,
    5,
    6,
    7,
    8,
    9,
    10,
    11,
    22,
    33,
    44,
    55,
    66,
    24,
    35,
    46,
    26,
    28,
    37,
    38,
    39,
    30,
    41,
    52,
    59,
    70,
    67,
    68,
    69,
    61,
    72,
    73,
    74,
    75,
    100,
    101,
    102,
    103,
    105,
    106,
    107,
    108,
    116,
    123,
    134,
    145,
    114,
    136,
    137,
    138,
    147,
    149,
    129,
    151,
    140,
    99,
    110,
    121,
    132,
    143,
    154,
    165,
    166,
    167,
    168,
    169,
    170,
    171,
    172,
    173,
    174,
    175,
    164,
    153,
    142,
    131,
    120,
    109,
    76,
    65,
    54,
    43,
    32,
    21
  ];

  List<int> food = [];
  List<int> vis = [];

  String direction = "right";

  void moveLeft() {
    if (!barriers.contains(player - 1)) {
      setState(() {
        player--;
      });
    }
  }

  void moveRight() {
    if (!barriers.contains(player + 1)) {
      setState(() {
        player++;
      });
    }
  }

  void moveUp() {
    if (!barriers.contains(player - numberInRow)) {
      setState(() {
        player -= numberInRow;
      });
    }
  }

  void moveDown() {
    if (!barriers.contains(player + numberInRow)) {
      setState(() {
        player += numberInRow;
      });
    }
  }

  void getFood() {
    for (int i = 0; i < numberOfSquares; i++) {
      if (!barriers.contains(i)) {
        food.add(i);
      }
    }
  }

  

  void startGame() {
     getFood();
     
    

    Timer.periodic(Duration(milliseconds: 200), (timer) {
     setState(() {
        mouthClosed = !mouthClosed;
      });

     /* setState(() {
        ate = !ate;
      });*/
     // ate = !ate;
     

      if (food.contains(player)) {
        score++;
        food.remove(player);
        vis.add(player);
        
        //return MyPath(innerColor: Colors.black, outerColor: Colors.black,);
        
      }

      switch (direction) {
        case "left":
          moveLeft();
          break;

        case "right":
          moveRight();
          break;

        case "up":
          moveUp();
          break;

        case "down":
          moveDown();
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Expanded(
            flex: 6,
            child: GestureDetector(
              onVerticalDragUpdate: (details) {
                if (details.delta.dy > 0) {
                  direction = "down";
                } else if (details.delta.dy < 0) {
                  direction = "up";
                }
              },
              onHorizontalDragUpdate: (details) {
                if (details.delta.dx > 0) {
                  direction = "right";
                } else if (details.delta.dx < 0) {
                  direction = "left";
                }
              },
              child: Container(
                child: GridView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: numberOfSquares,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: numberInRow),
                    itemBuilder: (BuildContext context, int index) {
                      if (mouthClosed && player==index) {
                        return Padding(
                          padding: EdgeInsets.all(4.0),
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.yellow[400], shape: BoxShape.circle),
                          ),
                        );
                        
                      } else if (player == index) {
                        switch (direction) {
                          case "left":
                            return Transform.rotate(
                              angle: pi,
                              child: MyPlayer(),
                            );
                            break;

                          case "right":
                            return MyPlayer();
                            break;
                          case "up":
                            return Transform.rotate(
                              angle: 3 * pi / 2,
                              child: MyPlayer(),
                            );
                            break;
                          case "down":
                            return Transform.rotate(
                              angle: pi / 2,
                              child: MyPlayer(),
                            );
                            break;

                          default:
                            return MyPlayer();
                        }

                        // return MyPlayer();
                      } else if (barriers.contains(index)) {
                        return MyPixel(
                          innerColor: Colors.blue[800],
                          outerColor: Colors.blue[900],
                          //child: Text(index.toString()),
                        );
                      } else if(!barriers.contains(index) && vis.contains(index)) {
                        return MyPath(
                          innerColor: Colors.black,
                          outerColor: Colors.black,
                          //child: Text(index.toString()),
                        );
                      }
                      else {
                        return MyPath(
                          innerColor: Colors.yellow[400],
                          outerColor: Colors.black,
                          //child: Text(index.toString()),
                        );
                      }
                    }),
                //color: Colors.red,
              ),
            ),
          ),
          Expanded(
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "Score "+ score.toString(),
                    style: TextStyle(color: Colors.white, fontSize: 25.0),
                  ),
                  GestureDetector(
                    onTap: startGame,
                    child: Text(
                      "PLAY ",
                      style: TextStyle(color: Colors.white, fontSize: 25.0),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
