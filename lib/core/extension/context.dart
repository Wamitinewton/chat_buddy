import 'package:flutter/material.dart';

extension Context on BuildContext {
  TextTheme get textTheme => Theme.of(this).textTheme;
  // this keyword is used to refer to the current instance in dart
  // refer to https://stackoverflow.com/questions/64324559/what-does-mean-of-using-the-this-keyword-in-dart
//   class Car {
//   String engine;

//   void newEngine({String engine}) {
//     if (engine!= null) {
//       this.engine= engine;
//     }
//   }
// }
TextTheme get primaryTextTheme => Theme.of(this).primaryTextTheme;

ColorScheme get colorScheme => Theme.of(this).colorScheme;
 void closeKeyboard() => FocusScope.of(this).unfocus();
}