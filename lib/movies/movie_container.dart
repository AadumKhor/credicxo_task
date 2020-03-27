import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:credicxo_task/bloc/bloc.dart';
import 'package:credicxo_task/movies/listPage.dart';
import 'package:credicxo_task/movies/movies.dart';
import 'package:credicxo_task/movies/searchPage.dart';
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
  final Connectivity _connectivity = new Connectivity();
  var status = ConnectivityResult.none;
  StreamSubscription<ConnectivityResult> _streamSubscription;

  @override
  void initState() {
    super.initState();
    _bloc = BlocProvider.of(context);
    _bloc.add(FetchMovieList());
    _pageController = new PageController();
    initConnectivity();
    _streamSubscription =
        _connectivity.onConnectivityChanged.listen(updateStatus);
  }

  @override
  void dispose() {
    super.dispose();
    _bloc?.close();
    _pageController.dispose();
    _streamSubscription.cancel();
  }

  Future<void> initConnectivity() async {
    ConnectivityResult result;
    try {
      result = await _connectivity.checkConnectivity();
    } catch (e) {
      print(e.toString());
    }
    updateStatus(result);
  }

  Future<void> updateStatus(ConnectivityResult result) async {
    switch (result) {
      case ConnectivityResult.wifi:
        setState(() {
          status = ConnectivityResult.wifi;
        });
        break;
      case ConnectivityResult.mobile:
        setState(() {
          status = ConnectivityResult.mobile;
        });
        break;
      case ConnectivityResult.none:
        setState(() => status = ConnectivityResult.none);
        break;
      default:
        setState(() => status = ConnectivityResult.none);
        break;
    }
  }

  _onPageChanged(PageDirection direction) {
    switch (direction) {
      case (PageDirection.back):
        _pageController.jumpToPage(0);
        break;
      case (PageDirection.next):
        return _pageController.jumpToPage(1);
        break;
      case (PageDirection.search):
        return _pageController.jumpToPage(2);
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
                  'Network Error',
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
              if (state is MoviesError || status == ConnectivityResult.none) {
                return Center(
                  child: Text(
                    'Something went wrong.',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                        color: Colors.black87),
                  ),
                );
              }

              if (state is Search) {
                return SearchPage(
                  bloc: _bloc,
                  state: state,
                  // onPageChanged: _onPageChanged,
                );
              }

              if (state is MovieDetailsLoaded) {
                return DetailsPage(
                  state: state,
                  bloc: _bloc,
                );
              }

              return ListPage(
                bloc: _bloc,
                state: state as MoviesLoaded,
              );
            }));
  }
}

enum PageDirection { next, back, search }
