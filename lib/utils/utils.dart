import 'package:flutter/material.dart';

class Utils{

  static message(message, context){
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('$message',),
        backgroundColor: Colors.pink,
        behavior: SnackBarBehavior.floating,
    )
    );
  }
}