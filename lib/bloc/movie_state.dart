part of 'movie_bloc.dart';

abstract class MovieState extends Equatable {
  const MovieState();

  // @override
  // List<Object> get props => [];
}

class MovieInitial extends MovieState {
  @override
  List<Object> get props => [];
}

class MovieLoadedState extends MovieState {
  final List<MovieModel> movies;
  const MovieLoadedState(this.movies);
  @override
  List<Object> get props => [movies];
}
