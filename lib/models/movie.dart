part of 'models.dart';

class MovieModel {
  final int id;
  final String title;
  final double voteAverage;
  final String overview;
  final String posterPath;
  final String backdropPath;

  MovieModel({
    required this.id,
    required this.title,
    required this.voteAverage,
    required this.overview,
    required this.posterPath,
    required this.backdropPath,
  });

  List<Object?> get props => [
        id,
        title,
        voteAverage,
        overview,
        posterPath,
        backdropPath,
      ];
}
