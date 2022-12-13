import 'package:conversor_moeda/home.dart';
import 'package:flutter/material.dart';
import 'dart:async';

void main() async {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
      theme: ThemeData(
        hintColor: Colors.amber,
        primaryColor: Colors.white,
        inputDecorationTheme: InputDecorationTheme(
          enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.amber)),
          focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.amber)),
          hintStyle: TextStyle(color: Colors.amber),
        ),
      ),
    ),
  );
}
