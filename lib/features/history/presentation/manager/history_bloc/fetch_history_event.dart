part of 'fetch_history_bloc.dart';

sealed class FetchHistoryEvent {}

final class FetchHistory extends FetchHistoryEvent{
  int page;
  int limit;
  FetchHistory({this.page = 1,this.limit = 1});
}
