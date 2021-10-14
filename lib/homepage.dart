import 'package:flutter/material.dart';
import 'data.dart';
import 'flipcardgame.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.fromLTRB(0, 80, 0, 30),
            decoration: BoxDecoration(
              border: Border.all(
                width: 5,
                color:Color(0xFF54A3FB),
              ),
              borderRadius: BorderRadius.circular(8),
            ),
              child: Image(
                width: 120,
                image: AssetImage(
                  'assets/images/logocerta.jpeg',
                ),
              ),
            ),
          Container(
            margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
            child: Text(
              'Escolha o nível:',
              style: TextStyle(
                fontSize: 30,
                color: Colors.black,
              ),
            ),
          ),
          Expanded(
            child: Container(
              child: Padding(
                padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
                child: ListView.builder(
                  itemCount: _list.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (BuildContext context) {
                            return _list[index].goto;
                          },
                        ));
                      },
                      child: Container(
                        margin: EdgeInsets.all(8),
                        height: 90,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: _list[index].primarycolor,
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: [
                            BoxShadow(
                                blurRadius: 2,
                                color: Colors.black45,
                                spreadRadius: 0.5,
                                offset: Offset(3, 4))
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Center(
                                child: Text(
                              _list[index].name,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 27,
                                  fontWeight: FontWeight.bold,
                                  shadows: [
                                    Shadow(
                                      color: Colors.black26,
                                      blurRadius: 2,
                                      offset: Offset(1, 2),
                                    ),
                                    Shadow(
                                        color: Colors.black,
                                        blurRadius: 1,
                                        offset: Offset(0.5, 1))
                                  ]),
                            )),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Details {
  var name;
  var primarycolor;
  var goto;

  Details({this.name, this.primarycolor, this.goto});
}

List<Details> _list = [
  Details(
      name: "Fácil",
      primarycolor: Color(0xff83f52c),
      goto: FlipCardGame(Level.Facil)),
  Details(
      name: "Intermediário",
      primarycolor: Color(0xFF52A5FF),
      goto: FlipCardGame(Level.Intermediario)),
  Details(
      name: "Difícil",
      primarycolor: Color(0xFFFF51A6),
      goto: FlipCardGame(Level.Dificil))
];
