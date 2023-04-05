

class Resources {
  List<Folders>? folders;
  List<String>? icons;

  Resources({this.folders, this.icons});

  Resources.fromJson(Map<String, dynamic> json) {
    if (json['folders'] != null) {
      folders = <Folders>[];
      json['folders'].forEach((v) {
        folders!.add(new Folders.fromJson(v));
      });
    }
    icons = json['icons'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.folders != null) {
      data['folders'] = this.folders!.map((v) => v.toJson()).toList();
    }
    data['icons'] = this.icons;
    return data;
  }
}

class Folders {
  String? updatedAt;
  String? name;
  String? id;

  Folders({this.updatedAt, this.name, this.id});

  Folders.fromJson(Map<String, dynamic> json) {
    updatedAt = json['updated_at'];
    name = json['name'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['updated_at'] = this.updatedAt;
    data['name'] = this.name;
    data['id'] = this.id;
    return data;
  }
}