part of 'movies_bloc.dart';

abstract class MoviesState extends Equatable {
  const MoviesState();
}

class MoviesInitial extends MoviesState {
  @override
  List<Object> get props => [];
}

class MoviesLoaded extends MoviesState {
  final List<MovieListItem> movies;
  final bool isLoading;
  final String details;

  MoviesLoaded({this.movies, this.isLoading, this.details});

  MoviesLoaded copyWith(
      {List<MovieListItem> movies, bool isLoading, String details}) {
    return MoviesLoaded(
        details: details ?? this.details,
        movies: movies ?? this.movies,
        isLoading: isLoading ?? this.isLoading);
  }

  @override
  List<Object> get props => [isLoading, movies];

  @override
  String toString() => 'Number of movies loaded : ${movies.length}';
}

class MovieDetailsLoaded extends MoviesState {
  final bool isLoading;
  final String details;

  MovieDetailsLoaded({this.details, this.isLoading});

  MovieDetailsLoaded copyWith({bool isLoading, String details}) {
    return MovieDetailsLoaded(
        isLoading: isLoading ?? this.isLoading,
        details: details ?? this.details);
  }

  @override
  List<Object> get props => [isLoading, details];

  @override
  String toString() =>
      'Movie details loading : $isLoading and details : $details';
}

class MoviesError extends MoviesState {
  @override
  List<Object> get props => null;

  @override
  String toString() => 'Some error occured.';
}
