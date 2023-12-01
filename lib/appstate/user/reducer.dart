import 'package:p4h_mobile/appstate/actions_bloc/actions.dart';
import 'package:p4h_mobile/appstate/user/user_state_old.dart';
import 'package:p4h_mobile/models/comment.dart';
import 'package:p4h_mobile/models/user_post.dart';

List<UserPost> postReducer(
  final BaseAction action,
  final List<UserPost> state,
) {
  if (action is DeletePostAttempt) {
    final nextState = state.where(
      (element) => element.id != action.postID,
    );

    return nextState.toList();
  }

  if (action is AddPostAttempt) {
    final nextState = [
      ...state,
      UserPost(
        message: action.post,
        user: action.user,
        comments: [],
        id: 69,
      ),
    ];

    return nextState;
  }

  if (action is AddCommentAttempt) {
    final post = state.where((element) => element.id == action.id).first;

    final userComment = Comment(
      message: action.comment,
    );

    final resolvedPost = post.copyWith(comments: [
      ...post.comments!,
      userComment,
    ]);

    final nextState = [
      resolvedPost,
      ...state.where((element) => element.id != post.id),
    ];

    return nextState;
  }
  return state;
}
