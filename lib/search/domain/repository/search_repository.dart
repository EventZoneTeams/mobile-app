import 'package:dartz/dartz.dart';
import 'package:eventzone/core/data/error/failure.dart';
import 'package:eventzone/search/domain/entities/search_result_item.dart';

abstract class SearchRepository {
  Future<Either<Failure, List<SearchResultItem>>> search(String title);
}
