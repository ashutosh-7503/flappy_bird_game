import 'dart:async';

import 'package:flappy_bird/barriers.dart';
import 'package:flappy_bird/bird.dart';
import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  static double birdY = 0.0;
  double initialPos = birdY;
  double height = 0, time = 0;
  bool isGameStarted = false;
  static double barrierx1 = 1;
  double barrierx2 = barrierx1 + 1.5;

  void startGame() {
    isGameStarted = true;
    Timer.periodic(Duration(milliseconds: 60), (timer) {
      initialPos = birdY;
      time += 0.05;
      height = -4.9 * time * time + 1.2 * time;

      setState(() {
        birdY = initialPos - height;
      });

      setState(() {
        if (barrierx1 < -1.4) {
          barrierx1 += 3;
        } else {
          barrierx1 -= 0.05;
        }
      });
      setState(() {
        if (barrierx2 < -1.4) {
          barrierx2 += 3;
        } else {
          barrierx2 -= 0.05;
        }
      });

      if (birdisDead()) {
        timer.cancel();
        isGameStarted = false;
        barrierx1 = 1;
        barrierx2 = barrierx1 + 1.5;
        _showDialog();
      }
    });
  }

  void resetGame() {
    Navigator.pop(context);
    setState(() {
      birdY = 0.0;
      initialPos = birdY;
      time = 0;
      isGameStarted = false;
    });
  }

  void _showDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.brown,
          title: Text('Game Over', style: TextStyle(color: Colors.white)),
          content: Text(
            'Your bird has fallen!',
            style: TextStyle(color: Colors.white),
          ),
          actions: [
            TextButton(
              onPressed: resetGame,
              child: Text('Restart', style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }

  void jump() {
    setState(() {
      time = 0;
      initialPos = birdY;
    });
  }

  bool birdisDead() {
    if (birdY > 1 || birdY < -1) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isGameStarted ? jump : startGame,
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              flex: 3,
              child: Container(
                color: Colors.blue,
                child: Center(
                  child: Stack(
                    children: [
                      MyBird(birdY: birdY),
                      Container(
                        alignment: Alignment(0, -0.5),
                        child: Text(
                          isGameStarted ? '' : 'T A P  T O  P L A Y',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      AnimatedContainer(
                        duration: Duration(milliseconds: 0),
                        alignment: Alignment(barrierx1, 1),
                        child: MyBarrier(size: 50.0),
                      ),
                      AnimatedContainer(
                        duration: Duration(milliseconds: 0),
                        alignment: Alignment(barrierx1, -1),
                        child: MyBarrier(size: 200.0),
                      ),
                      AnimatedContainer(
                        duration: Duration(milliseconds: 0),
                        alignment: Alignment(barrierx2, 1),
                        child: MyBarrier(size: 150.0),
                      ),
                      AnimatedContainer(
                        duration: Duration(milliseconds: 0),
                        alignment: Alignment(barrierx2, -1),
                        child: MyBarrier(size: 50.0),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(height: 15, color: Colors.green),
            Expanded(child: Container(color: Colors.brown)),
          ],
        ),
      ),
    );
  }
}
