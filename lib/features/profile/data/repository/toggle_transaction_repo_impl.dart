
import 'package:easy_bank/features/profile/data/data_sources/toggle_transaction_data_source.dart';

import '../../domain/repository/toggle_transaction_repository.dart';

class ToggleTransactionRepoImpl extends ToggleTransactionRepository{
  final ToggleTransactionDataSource toggleTransactionDataSource;

  ToggleTransactionRepoImpl(this.toggleTransactionDataSource);
  @override
  Future<bool> toggleTransaction() {
    return toggleTransactionDataSource.toggleTransaction();
  }

}