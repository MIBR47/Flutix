// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:bwa_flutix/models/models.dart';
import 'package:bwa_flutix/services/services.dart';
import 'package:equatable/equatable.dart';

part 'movie_event.dart';
part 'movie_state.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  MovieBloc() : super(MovieInitial()) {
    // on<MovieEvent>((event, emit) {
    //
    // });

    on<MoviesLoadedEvent>((event, emit) async {
      List<MovieModel> movies = await MovieServices.getMovies(1);
      emit(MovieLoadedState(movies));
    });
  }
}
