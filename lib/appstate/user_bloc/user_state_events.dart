import 'package:p4h_mobile/models/progress_model.dart';
import 'package:p4h_mobile/models/resource.dart';

sealed class UserStateEvents {
  const UserStateEvents();
}

class UserLoginEvent extends UserStateEvents {
  final String userName;
  final String password;

  const UserLoginEvent({
    required this.userName,
    required this.password,
  });
}

class GoToMyProgressSuccess extends UserStateEvents {
  final Iterable<MyProgress> result;

  const GoToMyProgressSuccess({required this.result});
}

class SetResourceFolder extends UserStateEvents {
  final ResourcesFolderIdResponse rr;

  const SetResourceFolder({required this.rr});
}

class Download extends UserStateEvents {
  final int fileID;
  final String fileName;
  const Download({required this.fileID, required this.fileName});
}

class AddPost extends UserStateEvents {
  final String post;

  AddPost({
    required this.post,
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

class AddComment extends UserStateEvents {}
