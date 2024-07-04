part of 'new_account_bloc.dart';

sealed class NewAccountEvent {
  const NewAccountEvent();
}

class DoRegistrer extends NewAccountEvent {
  final String accountName;
  final String password;
  final bool verifyAge;

  const DoRegistrer(this.accountName, this.password, this.verifyAge);
}