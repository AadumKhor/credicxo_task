import 'package:credicxo_task/bloc/bloc.dart';
import 'package:credicxo_task/movies/movies.dart';
import 'package:credicxo_task/repository/movie_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  final MovieRepo repo;

  HomeScreen({@required this.repo}) : assert(repo != null);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text('Popular Movie List'),
      ),
      body: SafeArea(
          minimum: EdgeInsets.all(5.0),
          child: BlocProvider(
            create: (context) {
              return MoviesBloc(movieRepo: widget.repo);
            },
            child: MovieContainer(),
          )),
    );
  }
}
