part of 'movies_bloc.dart';

abstract class MoviesEvent extends Equatable {
  const MoviesEvent();
}

class FetchMovieList extends MoviesEvent {
  @override
  String toString() => 'Fetching list of movies.';

  @override
  List<Object> get props => null;
}

class FetchMovieDetails extends MoviesEvent {
  final String movieId;

  FetchMovieDetails({this.movieId});

  @override
  String toString() => 'Movie details for id: $movieId';

  @override
  List<Object> get props => null;
}
