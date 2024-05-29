import 'package:dartz/dartz.dart';
import 'package:eventzone/core/domain/usecase/base_use_case.dart';
import 'package:eventzone/search/domain/entities/search_result_item.dart';
import 'package:eventzone/search/domain/repository/search_repository.dart';
import 'package:eventzone/core/data/error/failuredart';

class SearchUseCase extends BaseUseCase<List<SearchResultItem>, String> {
  final SearchRepository _baseSearchRepository;

  SearchUseCase(this._baseSearchRepository);

  @override
  Future<Either<Failure, List<SearchResultItem>>> call(String p) async {
    return await _baseSearchRepository.search(p);
  }
}
