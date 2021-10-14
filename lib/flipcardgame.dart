import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flip_card/flip_card.dart';
import 'data.dart';
import 'homepage.dart';

class FlipCardGame extends StatefulWidget {
  final Level _level;
  FlipCardGame(this._level);
  @override
  _FlipCardGameState createState() => _FlipCardGameState(_level);
}

class _FlipCardGameState extends State<FlipCardGame>
    with TickerProviderStateMixin {
  _FlipCardGameState(this._level);

  late final AnimationController controller;
  late final Animation<double> explosaoBomba;

  int _previousIndex = -1;
  bool _flip = false;
  bool _start = false;

  var _wait = false;
  var _level;
  var _timer;
  // var _time = 3;
  var _left;
  var _isFinished;
  var _isMented = true;
  late List<dynamic> _data;

  late List<bool> _cardFlips;
  late List<GlobalKey<FlipCardState>> _cardStateKeys;

  Widget getItem(int index) {
    return Container(
      padding: EdgeInsets.all(8),
      child: CircleAvatar(
        radius: 50,
        backgroundImage: AssetImage(_data[index]),
      ),
    );
  }

  startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (t) {
      // setState(() {
      //   _time = _time - 1;
      // });
    });
  }

  void restart() {
    startTimer();
    _data = getSourceArray(
      _level,
    );
    _cardFlips = getInitialItemState(_level);
    _cardStateKeys = getCardStateKeys(_level);
    // _time = 3;
    _left = (_data.length ~/ 2);

    _isFinished = false;
    _isMented = true;
    Future.delayed(const Duration(seconds: 0), () {
      setState(() {
        _start = true;
        _timer.cancel();
      });
    });
  }

  @override
  void initState() {
    super.initState();

    // controller =
    //     new AnimationController(duration: Duration(seconds: 6), vsync: this)
    //       ..addListener(() => setState(() {}));

    // explosaoBomba = Tween(begin: 0.0, end: 1.0).animate(
    //   CurvedAnimation(
    //       parent: controller, curve: Interval(0.01, 1.0, curve: Curves.ease)),
    // );

    // controller.forward();

    restart();
  }

  @override
  void dispose() {
    super.dispose();
    // if (_isFinished) {
    //   Future.delayed(const Duration(milliseconds: 5500), () {
    //     _isMented = true;
    //   });
    // }
  }

  Widget _sombra(BuildContext context, Widget? child) {
    return Padding(
      padding: const EdgeInsets.all(42.0),
      child: Container(
        width: 300,
        height: 300,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              "images/sombra.png",
            ),
            // fit: BoxFit.scaleDown,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _isFinished
        ? _isMented
            ? Scaffold(
                body: Center(
                  child: Scaffold(
                    backgroundColor: Colors.black,
                    body: Container(
                      height: 200,
                      width: 200,
                      child:Image.network('http://www.reactiongifs.com/wp-content/uploads/2013/10/mind-blown.gif',
                      ),
                    ),
                  ),
                ),
              )
            : Scaffold(
                body: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            restart();
                          });
                        },
                        child: Container(
                          height: 50,
                          width: 200,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(24),
                          ),
                          child: Text(
                            "Jogar novamente",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 17,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Center(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                                // since this triggers when the animation is done, no duration is needed
                                builder: (context) => HomePage()),
                          );
                        },
                        child: Container(
                          height: 50,
                          width: 200,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(24),
                          ),
                          child: Text(
                            "Página inicial",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 17,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
        : Scaffold(
            body: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text(
                        'Faltam $_left pares',
                        style: TextStyle(
                          fontSize: 30,
                          color: Colors.red,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(4.0),
                      child: GridView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4,
                        ),
                        itemBuilder: (context, index) => _start
                            ? FlipCard(
                                key: _cardStateKeys[index],
                                onFlip: () {
                                  if (!_flip) {
                                    _flip = true;
                                    _previousIndex = index;
                                  } else {
                                    _flip = false;
                                    if (_previousIndex != index) {
                                      if (_data[_previousIndex] !=
                                          _data[index]) {
                                        _wait = true;

                                        Future.delayed(
                                            const Duration(milliseconds: 1000),
                                            () {
                                          _cardStateKeys[_previousIndex]
                                              .currentState!
                                              .toggleCard();
                                          _previousIndex = index;
                                          _cardStateKeys[_previousIndex]
                                              .currentState!
                                              .toggleCard();

                                          Future.delayed(
                                              const Duration(milliseconds: 160),
                                              () {
                                            setState(() {
                                              _wait = false;
                                            });
                                          });
                                        });
                                      } else {
                                        _cardFlips[_previousIndex] = false;
                                        _cardFlips[index] = false;
                                        print(_cardFlips);

                                        setState(() {
                                          _left -= 1;
                                        });
                                        if (_cardFlips
                                            .every((t) => t == false)) {
                                          print("Won");
                                          Future.delayed(
                                              const Duration(milliseconds: 160),
                                              () {
                                            setState(() {
                                              _isFinished = true;
                                              // _isMented = true;
                                              _start = false;
                                            });
                                          });

                                          Future.delayed(
                                              const Duration(
                                                  milliseconds: 5572), () {
                                            setState(() {
                                              // _isFinished = true;
                                              _isMented = false;
                                              // _start = false;
                                            });
                                          });
                                        }
                                      }
                                    }
                                  }
                                  setState(() {});
                                },
                                flipOnTouch: _wait ? false : _cardFlips[index],
                                direction: FlipDirection.HORIZONTAL,
                                front: Padding(
                                  padding: EdgeInsets.all(10),
                                  child: CircleAvatar(
                                    radius: 35,
                                    backgroundColor: Colors.black,
                                    child: CircleAvatar(
                                      radius: 30,
                                      backgroundImage: AssetImage(
                                        "assets/sc.png",
                                      ),
                                    ),
                                  ),
                                ),
                                back: getItem(index))
                            : getItem(index),
                        itemCount: _data.length,
                      ),
                    ),
                    Center(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                                // since this triggers when the animation is done, no duration is needed
                                builder: (context) => HomePage()),
                          );
                        },
                        child: Container(
                          margin: EdgeInsets.fromLTRB(0, 40, 0, 0),
                          height: 50,
                          width: 200,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(24),
                          ),
                          child: Text(
                            "Página inicial",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 17,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
