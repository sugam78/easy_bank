import 'package:bloc/bloc.dart';
import 'package:easy_bank/features/history/domain/entities/transaction_history.dart';
import 'package:easy_bank/features/history/domain/use_cases/fetch_history_use_case.dart';
import 'package:meta/meta.dart';

part 'fetch_history_event.dart';
part 'fetch_history_state.dart';

class FetchHistoryBloc extends Bloc<FetchHistoryEvent, FetchHistoryState> {
  final FetchHistoryUseCase fetchHistoryUseCase;

  int currentPage = 1;
  final List<TransactionHistory> _history = [];

  FetchHistoryBloc(this.fetchHistoryUseCase) : super(FetchHistoryInitial()) {
    on<FetchHistory>(_fetchHistory);
  }

  void _fetchHistory(FetchHistory event, Emitter<FetchHistoryState> emit) async {
    if (event.page == 1) {
      emit(FetchHistoryLoading());
    }

    try {
      final history = await fetchHistoryUseCase.execute(
        page: currentPage,
        limit: event.limit,
      );

      if (history.isEmpty) {
        emit(FetchHistoryNoMoreData(List.unmodifiable(_history)));
        return;
      }

      _history.addAll(history);
      currentPage++;

      emit(FetchHistoryLoaded(List.unmodifiable(_history)));
    } catch (e) {
      emit(FetchHistoryError('$e'));
    }
  }
}
