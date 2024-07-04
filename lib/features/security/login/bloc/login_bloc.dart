import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:wenia/BLL/security/security_bll.dart';

import 'package:wenia/core/service/culture_service.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  // [Properties]
  
  LoginBloc() : super(LoginInitial()) {
    // All events
    on<DoLogin>(_onDoLogin);
    on<DoNotifyRegistrerSuccess>(_onDoNotifyRegistrerSuccess);
  }

  // [Events]
  Future<void> _onDoLogin(DoLogin event, Emitter<LoginState> emit) async {
    // Set state Loading
    emit(LoginLoading());

    // Login
    User? currentUser = await SecurityBll().signInWithEmailAndPassword(event.accountName, event.password);

    if(currentUser == null) {
      // Set state Error
      emit(LoginError(CultureService().getLocalResource("login-error-message")));
    }
    else {
      
      // Set state Result
      emit(LoginSuccess(currentUser));
    }
  }

  Future<void> _onDoNotifyRegistrerSuccess(DoNotifyRegistrerSuccess event, Emitter<LoginState> emit) async {
    // Notify
    emit(LoginLoaded("login-registrer-success-notification-message"));
  }
}
