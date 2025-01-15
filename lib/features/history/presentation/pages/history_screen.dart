import 'package:easy_bank/core/common/widgets/custom_snackbar.dart';
import 'package:easy_bank/core/services/notification_services.dart';
import 'package:easy_bank/features/history/presentation/widgets/history_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../manager/history_bloc/fetch_history_bloc.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  final NotificationServices notificationServices = NotificationServices();
  late ScrollController _scrollController;
  @override
  void initState() {
    super.initState();
    notificationServices.requestNotificationPermission();
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
      context.read<FetchHistoryBloc>().add(FetchHistory(limit: 10));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<FetchHistoryBloc, FetchHistoryState>(
        listener: (context, state) {
          if (state is FetchHistoryError) {
            CustomSnackbar.show(context, message: state.message, type: SnackbarType.error);
          }
        },
        builder: (context, state) {
          if (state is FetchHistoryInitial) {
            context.read<FetchHistoryBloc>().add(FetchHistory(limit: 10));
          }

          if (state is FetchHistoryLoading && (state is FetchHistoryInitial || state is FetchHistoryLoaded)) {
            return Center(child: CircularProgressIndicator());
          }

          if (state is FetchHistoryLoaded || state is FetchHistoryNoMoreData) {
            final history = state is FetchHistoryLoaded
                ? state.transactionHistory
                : (state as FetchHistoryNoMoreData).history;
            if(history.isEmpty){
              return Center(
                child: Text('No Transactions'),
              );
            }
            return ListView.builder(
              controller: _scrollController,
              itemCount: history.length + 1,
              itemBuilder: (context, index) {
                if (index == history.length) {
                  if(history.length<10){
                    return SizedBox.shrink();
                  }
                  if (state is FetchHistoryNoMoreData) {
                    if (history.length > 10) {
                      return Center(child: Text('No more data'));
                    }
                    return SizedBox.shrink();
                  }
                  return Center(child: CircularProgressIndicator());
                }

                final transaction = history[index];
                return HistoryContainer(transactionHistory: transaction);
              },
            );
          }

          return Center(child: Text('Something went wrong'));
        },
      ),
    );
  }
}



