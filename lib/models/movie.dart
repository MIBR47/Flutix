part of 'models.dart';

class MovieModel {
  int? id;
  String? title;
  double? voteAverage;
  String? overview;
  String? posterPath;
  String? backdropPath;

  MovieModel({
    this.id = 0,
    this.title = "",
    this.voteAverage = 0.0,
    this.overview = "",
    this.posterPath = "",
    this.backdropPath = "",
  });

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
      id: json['id'],
      title: json['title'],
      voteAverage: (json['vote_average'] as num).toDouble(),
      overview: json['overview'],
      posterPath: json['poster_path'],
      backdropPath: json['backdrop_path'],
    );
  }

  List<Object?> get props => [
        id,
        title,
        voteAverage,
        overview,
        posterPath,
        backdropPath,
      ];
}
