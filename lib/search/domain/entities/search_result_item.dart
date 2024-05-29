import 'package:equatable/equatable.dart';

class SearchResultItem extends Equatable {
  final int tmdbID;
  final String posterUrl;
  final String title;
  final bool isEvent;

  const SearchResultItem({
    required this.tmdbID,
    required this.posterUrl,
    required this.title,
    required this.isEvent,
  });

  @override
  List<Object?> get props => [
        tmdbID,
        posterUrl,
        title,
        isEvent,
      ];
}
