import 'package:eventzone/tv_shows/data/models/episode_model.dart';
import 'package:eventzone/tv_shows/domain/entities/season_details.dart';

class SeasonDetailsModel extends SeasonDetails {
  const SeasonDetailsModel({
    required super.episodes,
  });

  factory SeasonDetailsModel.fromJson(Map<String, dynamic> json) {
    return SeasonDetailsModel(
      episodes: List<EpisodeModel>.from(
          (json['episodes'] as List).map((e) => EpisodeModel.fromJson(e))),
    );
  }
}
