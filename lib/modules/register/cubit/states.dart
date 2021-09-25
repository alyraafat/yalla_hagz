
abstract class RegisterStates {}

class RegisterInitialState extends RegisterStates {}

class RegisterLoadingState extends RegisterStates {}

class RegisterSuccessState extends RegisterStates
{
  final String uid;
  RegisterSuccessState(this.uid);
}

class RegisterErrorState extends RegisterStates
{
  final String error;

  RegisterErrorState(this.error);
}

class RegisterChangePasswordVisibilityState extends RegisterStates {}

class RegisterCreateUserSuccessState extends RegisterStates
{
  final String uid;
  RegisterCreateUserSuccessState(this.uid);
}

class RegisterCreateUserErrorState extends RegisterStates
{
  final String error;

  RegisterCreateUserErrorState(this.error);
}