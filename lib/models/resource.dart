abstract class UserResourceResponse {
  const UserResourceResponse();
}

class ResourcesResponse extends UserResourceResponse {
  final List<UserResourceResponseSuccess> resource;

  const ResourcesResponse({required this.resource});
}

class UserResourceResponseSuccess extends UserResourceResponse {
  final int? id;
  final String? name;
  final String? updatedAt;

  const UserResourceResponseSuccess({
    this.id,
    this.name,
    this.updatedAt,
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
