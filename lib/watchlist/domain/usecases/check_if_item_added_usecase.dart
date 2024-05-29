import 'package:dartz/dartz.dart';
import 'package:eventzone/core/domain/usecase/base_use_case.dart';
import 'package:eventzone/watchlist/domain/repository/watchlist_repository.dart';
import 'package:eventzone/core/data/error/failuredart';

class CheckIfItemAddedUseCase extends BaseUseCase<int, int> {
  final WatchlistRepository _watchlistRepository;

  CheckIfItemAddedUseCase(this._watchlistRepository);
  @override
  Future<Either<Failure, int>> call(int p) async {
    return await _watchlistRepository.checkIfItemAdded(p);
  }
}
