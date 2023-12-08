import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:p4h_mobile/appstate/user/user_state_old.dart';
import 'package:p4h_mobile/appstate/user_bloc/reducer.dart';
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
    on<AddError>((event, emit) {
      final prevState = state as UserStateSuccess;

      final nextState = userStateReducer(event, prevState);

      emit(nextState);
    });
    on<ClearLoginErrors>((event, emit) {
      final prevState = state as UserInitial;

      final nextState = userStateReducer(event, prevState);

      emit(nextState);
    });
    on<ClearUserResourceResponseError>((event, emit) {
      final prevState = state as UserStateSuccess;

      final nextState = userStateReducer(event, prevState);

      emit(nextState);
    });

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

      emit(
        prevState.copyWith(
          resourceFolder: event.resourceFolderIdResponse,
        ),
      );
    });
    on<Download>(
      (event, emit) async {
        final resp = await http.downloadFile(
          fileId: event.fileID,
          fileName: event.fileName,
          type: Notes(),
        );

        final nextState = state as UserStateSuccess;
//TODO @yasantha
        emit(nextState.copyWith(filePath: resp));
      },
    );

    on<UserLoginEvent>((event, emit) async {
      final prevState = state as UserInitial;
      emit(const UserStateLoading());

      final loginRes = await http.login(event.username, event.password);

      if (loginRes is LoginErrorType) {
        emit(prevState.copyWith(
          loginErrors: [
            ...prevState.loginErrors,
            loginRes,
          ],
        ));
      }

      if (loginRes is UserSuccess) {
        ///this is ugly break it down
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
            const UserStateError(error: 'Fetching User Post Failed'),
          );
        }
      }
    });

    on<AddPost>((event, emit) async {
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

  String errorMessage() => ("");
}

class UserInitial extends UserState {
  final List<LoginErrorType> loginErrors;

  UserInitial({
    this.loginErrors = const [],
  });

  UserInitial copyWith({
    final List<LoginErrorType>? loginErrors,
  }) {
    return UserInitial(loginErrors: loginErrors ?? []);
  }
}

class UserStateLoading extends UserState {
  const UserStateLoading();
}

class UserStateError extends UserState {
  final String error;

  const UserStateError({required this.error});

  @override
  String errorMessage() {
    return error;
  }
}

class UserStateSuccess extends UserState {
  final UserSuccess _user;
  final List<UserPost> userPost;
  final String? filePath;

  final List<RepresentableError> errors;

  final ResourcesFolderIdResponse? resourceFolder;

  final Iterable<MyProgress> progress;

  const UserStateSuccess({
    required UserSuccess user,
    this.userPost = const [],
    this.progress = const [],
    this.errors = const [],
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
    final List<RepresentableError>? errors,
  }) {
    return UserStateSuccess(
      user: user ?? _user,
      userPost: userPost ?? this.userPost,
      filePath: filePath ?? this.filePath,
      resourceFolder: resourceFolder ?? this.resourceFolder,
      progress: progress ?? this.progress,
      errors: errors ?? [],
    );
  }
}

class UserStatePush extends UserState {}
