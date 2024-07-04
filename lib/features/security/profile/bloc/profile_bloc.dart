import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:wenia/BLL/security/security_bll.dart';
import 'package:wenia/core/Entities/security/user_entity.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileInitial()) {
    // All events
    on<DoGetProfileUser>(_onDoGetProfileUser);
    on<DoLogOutProfileUser>(_onDoLogOutProfileUser);
  }

  // [Events]
  Future<void> _onDoGetProfileUser(DoGetProfileUser event, Emitter<ProfileState> emit) async {
    // Get information about the current user
    UserEntity? currentUser = await SecurityBll().getCurrentUser();

    // Set state
    emit(ProfileLoaded(currentUser));
  }

  Future<void> _onDoLogOutProfileUser(DoLogOutProfileUser event, Emitter<ProfileState> emit) async {
    // Get information about the current user
    await SecurityBll().signOut();

    // Set state
    emit(ProfileLoaded(null));
  }  
}
