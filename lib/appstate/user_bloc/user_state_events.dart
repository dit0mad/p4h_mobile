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
