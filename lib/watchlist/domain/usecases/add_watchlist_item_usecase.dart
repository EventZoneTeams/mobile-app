import 'package:eventzone/core/data/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:eventzone/core/domain/entities/event.dart';
import 'package:eventzone/core/domain/usecase/base_use_case.dart';
import 'package:eventzone/watchlist/domain/repository/watchlist_repository.dart';

class AddWatchlistItemUseCase extends BaseUseCase<int, Media> {
  final WatchlistRepository _baseWatchListRepository;

  AddWatchlistItemUseCase(this._baseWatchListRepository);

  @override
  Future<Either<Failure, int>> call(Media p) async {
    return await _baseWatchListRepository.addWatchListItem(p);
  }
}
