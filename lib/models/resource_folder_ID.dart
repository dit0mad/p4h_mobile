class ResourceFolderId {
  DateTime? updatedat;
  String? displayname;

  ResourceFolderId({this.updatedat, this.displayname});

  ResourceFolderId.fromJson(Map<String, dynamic> json) {
    updatedat = json['updated_at'];
    displayname = json['display_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['updated_at'] = updatedat;
    data['display_name'] = displayname;
    return data;
  }
}


