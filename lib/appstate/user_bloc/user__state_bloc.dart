import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:p4h_mobile/appstate/user/user_state.dart';
import 'package:p4h_mobile/appstate/user_bloc/user_state_events.dart';
import 'package:p4h_mobile/models/comment.dart';
import 'package:p4h_mobile/models/resource.dart';
import 'package:p4h_mobile/models/user.dart';
import 'package:p4h_mobile/models/user_post.dart';
import 'package:p4h_mobile/services/http_service.dart';

const resourse = [
  UserResourceResponseSuccess(
    id: 1,
    name: 'notes',
    updatedAt: 'today',
  ),
  UserResourceResponseSuccess(
    id: 1,
    name: 'pictures',
    updatedAt: 'today',
  ),
  UserResourceResponseSuccess(
    id: 1,
    name: 'videos',
    updatedAt: 'today',
  ),
];

const userSucess = UserSuccess(
  resources: resourse,
  canvasID: 1,
  email: 'email',
  id: 1,
  name: "name",
  username: "username",
);

final userpost = UserPost(
  message: 'message',
  comments: [
    Comment(
      message: 'comment',
      author: userSucess,
    ),
  ],
);

final dum = UserStateSuccess(
  user: userSucess,
  userPost: [userpost],
);

class UserStateBloc extends Bloc<UserStateEvents, UserState> {
  final UserStatus user;

  UserStateBloc()
      : user = const EmptyUserState(),
        super(
          UserInitial(),
        ) {
    final HttpRepo http = HttpRepo();

    on<Download>(
      (event, emit) async {
        final resp = await http.downloadFile('1');

        final nextState = state as UserStateSuccess;

        emit(nextState.copyWith(image: resp));
      },
    );

    on<UserLoginEvent>((event, emit) async {
      // emit(UserStatePush());
      // emit(dum);

      // return;
      emit(UserStateLoading());

      final loginRes = await http.login(event.userName, event.password);

      if (loginRes is InvalidLoginInfo) {
        emit(
          UserStateError(),
        );
      }

      if (loginRes is UserSuccess) {
        final getPostRes = await http.getPosts(loginRes.id);

        emit(UserStatePush());

        if (getPostRes is UserPostSuccess) {
          emit(UserStateSuccess(
            user: loginRes,
            userPost: getPostRes.userPosts,
          ));
        }

        if (getPostRes is UserPostFailedResponse) {
          emit(
            UserStateError(),
          );
        }
      }
    });

    on<AddPost>((event, emit) async {
      if (state is! UserStateSuccess) {
        //emit addpost failure
        return;
      }
      final currentState = state as UserStateSuccess;

      final userPost = UserPost(
        message: event.post,
        user: currentState._user,
        comments: [],
        id: 69,
      );

      final nextState = currentState.copyWith(userPost: [
        ...currentState.userPost,
        userPost,
      ]);

      emit(nextState);
    });

    on<DeletePost>(
      (event, emit) {
        if (state is! UserStateSuccess) {
          return;
        }
        final currentState = state as UserStateSuccess;

        final nextState = currentState.copyWith(userPost: [
          ...currentState.userPost.where((element) => element.id != event.id)
        ]);

        emit(nextState);
      },
    );
  }
}

abstract class UserState {
  const UserState();
}

class UserInitial extends UserState {}

class UserStateLoading extends UserState {}

class UserStateError extends UserState {}

class UserStateSuccess extends UserState {
  final UserSuccess _user;
  final List<UserPost> userPost;
  final String? image;

  const UserStateSuccess({
    required UserSuccess user,
    this.userPost = const [],
    this.image,
  }) : _user = user;

  UserSuccess get userSrate => _user;

  UserStateSuccess copyWith({
    final UserSuccess? user,
    final List<UserPost>? userPost,
    final String? image,
  }) {
    return UserStateSuccess(
      user: user ?? _user,
      userPost: userPost ?? this.userPost,
      image: image ?? this.image,
    );
  }
}

class UserStatePush extends UserState {}

abstract class BaseAction {}
