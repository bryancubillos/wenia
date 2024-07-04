import 'package:bloc/bloc.dart';
import 'package:wenia/BLL/security/security_bll.dart';
import 'package:wenia/core/Entities/common/result_entity.dart';

part 'change_password_event.dart';
part 'change_password_state.dart';

class ChangePasswordBloc extends Bloc<ChangePasswordEvent, ChangePasswordState> {
  ChangePasswordBloc() : super(ChangePasswordInitial()) {
    on<DoChangePassword>(_onDoChangePassword);
  }

  // [Events]
  Future<void> _onDoChangePassword(DoChangePassword event, Emitter<ChangePasswordState> emit) async {
    // Set state Loading
    emit(ChangePasswordLoading());

    // Change password
    ResultEntity result = await SecurityBll().changePassword(event.newPassword);
    
    if(result.result) {
      emit(ChangePasswordSuccess(true));
    }
    else {
      emit(ChangePasswordError(result.cultureMessage));
    }
  }
}
