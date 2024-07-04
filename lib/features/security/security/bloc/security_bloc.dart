import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:wenia/BLL/common/common_database.dart';
import 'package:wenia/BLL/security/security_bll.dart';
import 'package:wenia/core/Entities/security/user_entity.dart';

part 'security_event.dart';
part 'security_state.dart';

class SecurityBloc extends Bloc<SecurityEvent, SecurityState> {
  SecurityBloc() : super(SecurityInitial()) {
    // All events
    on<DoInitProject>(_onInitProject);
    on<DoGetSecurityUser>(_onGetSecurityUser);
  }

  // [Events]
  Future<void> _onInitProject(DoInitProject event, Emitter<SecurityState> emit) async {
    // Init database
    CommonDatabase().initDatabase();

    emit(SecurityInitial());
  }
  
  Future<void> _onGetSecurityUser(DoGetSecurityUser event, Emitter<SecurityState> emit) async {
    // Get information about the current user
    UserEntity? currentUser = await SecurityBll().getCurrentUser();

    // Set state
    emit(SecurityLoaded(currentUser));
  }
}
