import 'package:credicxo_task/bloc/bloc.dart';
import 'package:credicxo_task/movies/listPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'detailspage.dart';

class MovieContainer extends StatefulWidget {
  @override
  _MovieContainerState createState() => _MovieContainerState();
}

class _MovieContainerState extends State<MovieContainer> {
  MoviesBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = BlocProvider.of(context);
    _bloc.add(FetchMovieList());
  }

  @override
  void dispose() {
    super.dispose();
    // _bloc?.close();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
        bloc: _bloc,
        builder: (context, state) {
          if (state is MoviesInitial) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is MoviesError) {
            return Center(
              child: Text(
                'Some Error occured.',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                    color: Colors.black87),
              ),
            );
          } else if (state is MoviesLoaded) {
            return ListPage(state: state, bloc: _bloc);
          } else {
            return DetailsPage(
              state: state,
            );
          }
        });
  }
}

enum PageDirection { next, back }
