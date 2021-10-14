import 'package:flip_card/flip_card.dart';
import 'package:flutter/cupertino.dart';

enum Level { Dificil, Intermediario, Facil }

List<String> fillSourceArray() {
  return [
    'assets/appleandroid.png',
    'assets/appleandroid.png',
    'assets/bootstrap.png',
    'assets/bootstrap.png',
    'assets/css.png',
    'assets/css.png',
    'assets/dart.png',
    'assets/dart.png',
    'assets/flutter.png',
    'assets/flutter.png',
    'assets/html.png',
    'assets/html.png',
    'assets/jquery.png',
    'assets/jquery.png',
    'assets/js.png',
    'assets/js.png',
    'assets/react.png',
    'assets/react.png',
    'assets/vscode.png',
    'assets/vscode.png',
  ];
}

List getSourceArray(Level level) {
  List<String> levelAndKindList = <String>[];
  List sourceArray = fillSourceArray();
  if (level == Level.Dificil) {
    sourceArray.forEach((element) {
      levelAndKindList.add(element);
    });
  } else if (level == Level.Intermediario) {
    for (int i = 0; i < 16; i++) {
      levelAndKindList.add(sourceArray[i]);
    }
  } else if (level == Level.Facil) {
    for (int i = 0; i < 8; i++) {
      levelAndKindList.add(sourceArray[i]);
    }
  }
//shuffle embaralha a lista
  levelAndKindList.shuffle();
  return levelAndKindList;
}

List<bool> getInitialItemState(Level level) {
  List<bool> initialItemState = <bool>[];
  if (level == Level.Dificil) {
    for (int i = 0; i < 20; i++) {
      initialItemState.add(true);
    }
  } else if (level == Level.Intermediario) {
    for (int i = 0; i < 16; i++) {
      initialItemState.add(true);
    }
  } else if (level == Level.Facil) {
    for (int i = 0; i < 8; i++) {
      initialItemState.add(true);
    }
  }
  return initialItemState;
}

List<GlobalKey<FlipCardState>> getCardStateKeys(Level level) {
  List<GlobalKey<FlipCardState>> cardStateKeys = <GlobalKey<FlipCardState>>[];
  if (level == Level.Dificil) {
    for (int i = 0; i < 20; i++) {
      cardStateKeys.add(GlobalKey<FlipCardState>());
    }
  } else if (level == Level.Intermediario) {
    for (int i = 0; i < 16; i++) {
      cardStateKeys.add(GlobalKey<FlipCardState>());
    }
  } else if (level == Level.Facil) {
    for (int i = 0; i < 8; i++) {
      cardStateKeys.add(GlobalKey<FlipCardState>());
    }
  }
  return cardStateKeys;
}
