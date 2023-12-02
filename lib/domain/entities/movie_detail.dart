import 'package:freezed_annotation/freezed_annotation.dart';

part 'movie_detail.freezed.dart';

@freezed
class MovieDetail with _$MovieDetail {
  const factory MovieDetail({
    required int id,
    required String title,
    String? posterPath,
    required String overview,
    String? backdropPath,
    required int runTime,
    required double voteAvarage,
    required List<String> genres,
  }) = _MovieDetail;

  factory MovieDetail.fromJSON(Map<String, dynamic> json) => MovieDetail(
      id: json['id'],
      title: json['title'],
      overview: json['overview'],
      runTime: json['runtime'],
      voteAvarage: json['vote_avarage'].toDouble(),
      genres: List<String>.from(json['genres'].map((e) => e['name'])),
      posterPath: json['poster_path'],
      backdropPath: json['backdrop_path']);
}
