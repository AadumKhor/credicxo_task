import 'package:credicxo_task/bloc/bloc.dart';
import 'package:credicxo_task/movies/listPage.dart';
import 'package:credicxo_task/movies/movies.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'detailspage.dart';

class MovieContainer extends StatefulWidget {
  @override
  _MovieContainerState createState() => _MovieContainerState();
}

class _MovieContainerState extends State<MovieContainer> {
  MoviesBloc _bloc;
  PageController _pageController;

  @override
  void initState() {
    super.initState();
    _bloc = BlocProvider.of(context);
    _bloc.add(FetchMovieList());
    _pageController = new PageController();
  }

  @override
  void dispose() {
    super.dispose();
    _bloc?.close();
    _pageController.dispose();
  }

  _onPageChanged(PageDirection direction) {
    switch (direction) {
      case (PageDirection.back):
        _pageController.jumpToPage(0);
        break;
      case (PageDirection.next):
        return _pageController.jumpToPage(1);
        break;
      default:
        return _pageController.jumpToPage(0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
        bloc: _bloc,
        listener: (context, state) {
          if (state is MoviesError) {
            Scaffold.of(context).showSnackBar(SnackBar(
                content: Text(
                  'Some error has occued',
                  style: TextStyle(color: Colors.white),
                ),
                backgroundColor: Colors.black));
          }
        },
        child: BlocBuilder(
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
              }
              return PageView(
                controller: _pageController,
                children: <Widget>[
                  ListPage(
                    state: state,
                    bloc: _bloc,
                    onPagechanged: _onPageChanged,
                  ),
                  DetailsPage(
                    state: state,
                    bloc: _bloc,
                    onPageChanged: _onPageChanged,
                  )
                ],
              );
            }));
  }
}

enum PageDirection { next, back }
