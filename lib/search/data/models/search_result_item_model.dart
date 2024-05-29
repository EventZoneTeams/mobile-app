import 'package:eventzone/core/utils/functions.dart';
import 'package:eventzone/search/domain/entities/search_result_item.dart';

class SearchResultItemModel extends SearchResultItem {
  const SearchResultItemModel({
    required super.tmdbID,
    required super.posterUrl,
    required super.title,
    required super.isEvent,
  });

  factory SearchResultItemModel.fromJson(Map<String, dynamic> json) {
    return SearchResultItemModel(
      tmdbID: json['id'],
      posterUrl: getPosterUrl(json['poster_path']),
      title: json['title'] ?? json['name'],
      isEvent: json['media_type'] == 'event',
    );
  }
}
