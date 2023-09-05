abstract class UserResourceResponse {
  const UserResourceResponse();
}

class UserResourceFolderResponse {
  String display;
  int folderID;
  int id;
  String updatedAt;

  UserResourceFolderResponse(
      {required this.display,
      required this.folderID,
      required this.id,
      required this.updatedAt});

  factory UserResourceFolderResponse.fromJson(Map<String, dynamic> data) {
    final id = data['id'];
    final display = data['display_name'];
    final updatedAt = data['updated_at'];
    final folderID = data['folderId'];

    return UserResourceFolderResponse(
      id: id,
      display: display,
      updatedAt: updatedAt,
      folderID: folderID,
    );
  }
}

class ResourcesResponse extends UserResourceResponse {
  final List<UserResourceResponseSuccess> resource;

  const ResourcesResponse({required this.resource});
}

class ResourcesFolderIdResponse extends UserResourceResponse {
  final List<UserResourceFolderResponse> resources;
  ResourcesFolderIdResponse({required this.resources});
}

class UserResourceResponseSuccess extends UserResourceResponse {
  final int id;
  final String name;
  final String updatedAt;

  const UserResourceResponseSuccess({
    required this.id,
    required this.name,
    required this.updatedAt,
  });

  factory UserResourceResponseSuccess.fromJson(Map<String, dynamic> data) {
    final id = data['id'];
    final name = data['name'];
    final updatedAt = data['updated_at'];

    return UserResourceResponseSuccess(
      id: id,
      name: name,
      updatedAt: updatedAt,
    );
  }

  Map<String, dynamic> toJson() => {
        ' id': id,
        'name': name,
        'updatedAt': updatedAt,
      };
}

class UserResourceResponseFailure extends UserResourceResponse {
  const UserResourceResponseFailure();
}
