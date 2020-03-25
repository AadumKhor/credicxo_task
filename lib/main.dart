import 'package:bloc/bloc.dart';
import 'package:credicxo_task/repository/movie_repo.dart';
import 'package:credicxo_task/screens.dart/homescreen.dart';
import 'package:flutter/material.dart';

import 'bloc/bloc.dart';

void main() {
  BlocSupervisor.delegate = SimpleBlocDelegate();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final movieRepo = new MovieRepo();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(repo: movieRepo),
    );
  }
}
