import 'package:flutter/material.dart';

class TicTacToeButton {
  final id;
  String text;
  Color bg;
  bool enabled;

  TicTacToeButton(
      {this.id, this.text = "", this.bg = Colors.grey, this.enabled = true});
}