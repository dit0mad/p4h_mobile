import 'package:p4h_mobile/appstate/user/user_state_old.dart';
import 'package:p4h_mobile/models/progress_model.dart';
import 'package:p4h_mobile/models/resource.dart';

sealed class UserStateEvents {
  const UserStateEvents();
}

class UserLoginEvent extends UserStateEvents {
  final String username;
  final String password;

  const UserLoginEvent({
    required this.username,
    required this.password,
  });
}

class GoToMyProgressSuccess extends UserStateEvents {
  final Iterable<MyProgress> result;

  const GoToMyProgressSuccess({required this.result});
}

class ClearLoginErrors extends UserStateEvents {}

class ClearUserResourceResponseError extends UserStateEvents {}

class AddError extends UserStateEvents {
  final List<RepresentableError> errors;

  const AddError({required this.errors});
}

class SetResourceFolder extends UserStateEvents {
  final ResourcesFolderIdResponse resourceFolderIdResponse;

  const SetResourceFolder({required this.resourceFolderIdResponse});
}

class Download extends UserStateEvents {
  final int fileID;
  final String fileName;
  const Download({required this.fileID, required this.fileName});
}

class AddPost extends UserStateEvents {
  final String post;
  final int userID;

  AddPost({
    required this.post,
    required this.userID,
  });
}

class DeletePost extends UserStateEvents {
  int id;
  DeletePost({required this.id});
}

class DownloadFile extends UserStateEvents {
  final String fileId;
  const DownloadFile({required this.fileId});
}

class AddComment extends UserStateEvents {
  final String comment;
  final int id;

  AddComment({required this.comment, required this.id});
}

class GetPosts extends UserStateEvents {}
