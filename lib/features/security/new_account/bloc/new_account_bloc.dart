import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:wenia/BLL/security/security_bll.dart';
import 'package:wenia/core/Entities/common/result_entity.dart';
import 'package:wenia/core/service/culture_service.dart';

part 'new_account_event.dart';
part 'new_account_state.dart';

class NewAccountBloc extends Bloc<NewAccountEvent, NewAccountState> {
  NewAccountBloc() : super(NewAccountInitial()) {
    // All events
    on<DoRegistrer>(_onDoRegistrer);
  }

  // [Events]
  Future<void> _onDoRegistrer(DoRegistrer event, Emitter<NewAccountState> emit) async {
    // Set state Loading
    emit(NewAccountLoading());

    // Login
    ResultEntity isValidAccount = await SecurityBll().itsPossibleSaveAccount(event.accountName, event.password, event.verifyAge);

    if(isValidAccount.result) {
      User? currentUser = await SecurityBll().createUserWithEmailAndPassword(event.accountName, event.password);

      if(currentUser == null) {
        // Set state Error
        emit(NewAccountError(CultureService().getLocalResource("login-registrer-error-message")));
      }
      else {
        // Set state Result
        emit(NewAccountSuccess(currentUser));
      }
    }
    else {
      // Set state Error
      emit(NewAccountError(CultureService().getLocalResource(isValidAccount.cultureMessage)));
    }
  }
}
