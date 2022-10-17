part of 'models.dart';

class MovieDetailModel extends MovieModel {
  final List<String>? genres;
  final String? language;

  MovieDetailModel(MovieModel movie, {this.genres, this.language})
      : super(
          id: movie.id,
          title: movie.title,
          voteAverage: movie.voteAverage,
          posterPath: movie.posterPath,
          backdropPath: movie.backdropPath,
          overview: movie.overview,
        );

  String get genresAndLanguage {
    String s = '';
    for (var genre in genres!) {
      s += genre + (genre != genres!.last ? ', ' : '');
    }
    return "$s - $language";
  }

  @override
  List<Object?> get props => super.props + [genres, language];
}
