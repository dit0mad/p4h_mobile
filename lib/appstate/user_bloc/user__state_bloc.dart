import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:p4h_mobile/appstate/user/user_state.dart';
import 'package:p4h_mobile/appstate/user_bloc/user_state_events.dart';
import 'package:p4h_mobile/models/progress_model.dart';
import 'package:p4h_mobile/models/resource.dart';
import 'package:p4h_mobile/models/user.dart';
import 'package:p4h_mobile/models/user_post.dart';
import 'package:p4h_mobile/services/http_service.dart';

class UserStateBloc extends Bloc<UserStateEvents, UserState> {
  final UserStatus user;
  final HttpRepo http;

  UserStateBloc()
      : user = const EmptyUserState(),
        http = HttpRepo(),
        super(
          UserInitial(),
        ) {
    on<GoToMyProgressSuccess>((event, emit) {
      final prevState = state as UserStateSuccess;

      final result = event.result;

      emit(
        prevState.copyWith(progress: result),
      );

      //here we need to update state with progress info
    });
    on<SetResourceFolder>((event, emit) {
      final prevState = state as UserStateSuccess;

      emit(const UserStateLoading());

      if (!checkState(state)) {}

      emit(
        prevState.copyWith(
          resourceFolder: event.rr,
        ),
      );
    });
    on<Download>(
      (event, emit) async {
        final resp = await http.downloadFile(
          fileId: event.fileID,
          fileName: event.fileName,
        );

        final nextState = state as UserStateSuccess;
//TODO @yasantha
        emit(nextState.copyWith(filePath: resp));
      },
    );

    on<UserLoginEvent>((event, emit) async {
      emit(const UserStateLoading());

      final loginRes = await http.login(event.userName, event.password);

      if (loginRes is InvalidLoginInfo) {
        emit(
          UserStateError(),
        );
      }

      if (loginRes is UserSuccess) {
        final getPostRes = await http.getPosts(loginRes.id);

        if (getPostRes is UserPostSuccess) {
          emit(UserStatePush());

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

class UserStateLoading extends UserState {
  const UserStateLoading();
}

class UserStateError extends UserState {}

class UserStateSuccess extends UserState {
  final UserSuccess _user;
  final List<UserPost> userPost;
  final String? filePath;

  final ResourcesFolderIdResponse? resourceFolder;

  final Iterable<MyProgress> progress;

  const UserStateSuccess({
    required UserSuccess user,
    this.userPost = const [],
    this.progress = const [],
    this.filePath,
    this.resourceFolder,
  }) : _user = user;

  UserSuccess get userState => _user;

  UserStateSuccess copyWith({
    final UserSuccess? user,
    final List<UserPost>? userPost,
    final String? filePath,
    final ResourcesFolderIdResponse? resourceFolder,
    final Iterable<MyProgress>? progress,
  }) {
    return UserStateSuccess(
      user: user ?? _user,
      userPost: userPost ?? this.userPost,
      filePath: filePath ?? this.filePath,
      resourceFolder: resourceFolder ?? this.resourceFolder,
      progress: progress ?? this.progress,
    );
  }
}

class UserStatePush extends UserState {}

bool checkState(UserState state) {
  if (state is UserStateSuccess) {
    return true;
  }

  return false;
}
