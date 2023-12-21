import 'package:p4h_mobile/appstate/user_bloc/user__state_bloc.dart';
import 'package:p4h_mobile/appstate/user_bloc/user_state_events.dart';
import 'package:p4h_mobile/models/comment.dart';
import 'package:p4h_mobile/models/user_post.dart';

UserState userStateReducer(
  final UserStateEvents action,
  final UserState state,
) {
  if (action is DeletePost) {
    final prevState = state as UserStateSuccess;
    final nextState = prevState.userPost.where(
      (element) => element.id != action.id,
    );

    return prevState.copyWith(
      userPost: nextState.toList(),
    );
  }

  if (action is AddPost) {
    final prevState = state as UserStateSuccess;

    final nextState = [
      ...prevState.userPost,
      UserPost(
        message: action.post,
      ),
    ];

    return prevState.copyWith(userPost: nextState);
  }

  if (action is AddComment) {
    final prevState = state as UserStateSuccess;
    final post =
        prevState.userPost.where((element) => element.id == action.id).first;

    final userComment = Comment(
      message: action.comment,
    );

    final resolvedPost = post.copyWith(comments: [
      ...post.comments!,
      userComment,
    ]);

    final nextState = [
      resolvedPost,
      ...prevState.userPost.where((element) => element.id != post.id),
    ];

    return prevState.copyWith(userPost: nextState);
  }

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

    return prevState.copyWith(
      errors: null,
    );
  }
  return state;
}
