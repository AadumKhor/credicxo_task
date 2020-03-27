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
  final MovieDetails details;

  MovieDetailsLoaded({this.details, this.isLoading});

  MovieDetailsLoaded copyWith({bool isLoading, MovieDetails details}) {
    return MovieDetailsLoaded(
        isLoading: isLoading ?? this.isLoading,
        details: details ?? this.details);
  }

  @override
  List<Object> get props => [isLoading, details];

  @override
  String toString() =>
      'Movie details loading : $isLoading and details : ${details.toString()}';
}

// class SearchInit

class Search extends MoviesState {
  final bool isSearching;
  final List<MovieListItem> searchResults;

  Search({this.searchResults, this.isSearching});

  Search copyWith({List<MovieListItem> searchResults, bool isSearching}) {
    return Search(
        isSearching: isSearching ?? this.isSearching,
        searchResults: searchResults ?? this.searchResults);
  }

  @override
  String toString() =>
      'Search results : ${searchResults?.length},is searching = $isSearching';

  @override
  List<Object> get props => [isSearching, searchResults];
}

class MoviesError extends MoviesState {
  @override
  List<Object> get props => null;

  @override
  String toString() => 'Some error occured.';
}
