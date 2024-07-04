import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:wenia/BLL/security/security_bll.dart';

part 'security_event.dart';
part 'security_state.dart';

class SecurityBloc extends Bloc<SecurityEvent, SecurityState> {
  SecurityBloc() : super(SecurityInitial()) {
    // All events
    on<DoGetSecurityUser>(_onGetSecurityUser);
  }

  // [Events]
  Future<void> _onGetSecurityUser(DoGetSecurityUser event, Emitter<SecurityState> emit) async {    
    // Get information about the current user
    User? currentUser = await SecurityBll().getCurrentUser();

    // Set state
    emit(SecurityLoaded(currentUser));
  }
}
