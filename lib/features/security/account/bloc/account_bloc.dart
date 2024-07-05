import 'package:bloc/bloc.dart';

import 'package:wenia/BLL/security/security_bll.dart';
import 'package:wenia/core/Entities/common/result_entity.dart';
import 'package:wenia/core/Entities/security/user_entity.dart';

part 'account_event.dart';
part 'account_state.dart';

class AccountBloc extends Bloc<AccountEvent, AccountState> {
  // [Contructor]
  AccountBloc() : super(AccountInitial()) {
    on<DoAccountLoad>(_onAccountLoad);
    on<DoAccountUpdate>(_onAccountUpdate);
  }

  // [Methods]
  Future<void> _onAccountLoad(DoAccountLoad event, Emitter<AccountState> emit) async {
    // Get user
    UserEntity? currentUser = await SecurityBll().getCurrentUser();

    emit(AccountLoaded(currentUser));
  }

  Future<void> _onAccountUpdate(DoAccountUpdate event, Emitter<AccountState> emit) async {
    emit(AccountLoading());
    
    // Update user
    ResultEntity result = await SecurityBll().saveUser(event.user);

    if(result.result) {
      emit(AccountSuccess(true, "account-save-success"));
      emit(AccountLoaded(event.user));
    }
    else {
      emit(AccountError("account-save-error"));
    }
  }

}
