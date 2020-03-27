import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:credicxo_task/bloc/bloc.dart';
import 'package:credicxo_task/models/models.dart';
import 'package:credicxo_task/repository/movie_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

part 'movies_event.dart';
part 'movies_state.dart';

class MoviesBloc extends Bloc<MoviesEvent, MoviesState> {
  final MovieRepo movieRepo;

  MoviesBloc({@required this.movieRepo}) : assert(movieRepo != null);

  @override
  MoviesState get initialState => MoviesInitial();

  @override
  Stream<MoviesState> mapEventToState(
    MoviesEvent event,
  ) async* {
    if (event is FetchMovieList) {
      try {
        print('Loading is true');
        yield MoviesLoaded(isLoading: true, movies: [], details: '');
        print('Fetching movies...');
        var movies = await movieRepo.getMovies();
        print('Fetched movies');
        MoviesLoaded state = this.state as MoviesLoaded;
        print('Mutating state');
        yield state.copyWith(isLoading: false, movies: movies);
        print('All done');
      } catch (e) {
        print(e.toString());
        yield MoviesError();
      }
    }
    if (event is FetchMovieDetails) {
      try {
        print('Ready to get details');
        yield MovieDetailsLoaded(isLoading: true, details: MovieDetails());
        MovieDetails details = await movieRepo.getMovieDetails(event.movieId);
        print('Details fetched');
        MovieDetailsLoaded state = this.state as MovieDetailsLoaded;
        print('Mutating state');
        yield state.copyWith(isLoading: false, details: details);
        print('All done');
      } catch (e) {
        print(e.toString());
        yield MoviesError();
      }
    }

    if (event is SearchButtonClicked) {
      yield Search(isSearching: true, searchResults: []);
    }

    if (event is SearchForMovie) {
      try {
        print('Search init');        
        var list = await movieRepo.search(event.name);
        print('Search successful');
        Search state = this.state as Search;
        yield state.copyWith(isSearching: false, searchResults: list);
        print(state.isSearching.toString() + list.length.toString());
        print('All done');
      } catch (e) {
        print(e.toString());
        yield MoviesError();
      }
    }
  }
}
