import 'package:p4h_mobile/appstate/user_bloc/user__state_bloc.dart';
import 'package:p4h_mobile/appstate/user_bloc/user_state_events.dart';

UserState userStateReducer(
  final UserStateEvents action,
  final UserState state,
) {
  if (action is ClearLoginErrors) {
    final prevState = state as UserInitial;

    if (prevState.loginErrors.isEmpty) {
      return state;
    }
    return prevState.copyWith(
      loginErrors: null,
    );
  }

  if (action is AddError) {
    final prevState = state as UserStateSuccess;

    return prevState.copyWith(
      errors: [...prevState.errors, ...action.errors],
    );
  }

  if (action is ClearUserResourceResponseError) {
    final prevState = state as UserStateSuccess;

    //clear ClearUserResourceResponseError errors

    return prevState.copyWith(
      errors: null,
    );
  }
  return state;
}
