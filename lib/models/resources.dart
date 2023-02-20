// To parse this JSON data, do
//
//     final resources = resourcesFromJson(jsonString);

import 'dart:convert';

Resources resourcesFromJson(String str) => Resources.fromJson(json.decode(str));

String resourcesToJson(Resources data) => json.encode(data.toJson());

class Resources {
    Resources({
        required this.folders,
        required this.icons,
    });

    List<Folder> folders;
    List<String> icons;

    factory Resources.fromJson(Map<String, dynamic> json) => Resources(
        folders: List<Folder>.from(json["folders"].map((x) => Folder.fromJson(x))),
        icons: List<String>.from(json["icons"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "folders": List<dynamic>.from(folders.map((x) => x.toJson())),
        "icons": List<dynamic>.from(icons.map((x) => x)),
    };
}

class Folder {
    Folder({
        required this.updatedAt,
        required this.name,
        required this.files,
        required this.id,
    });

    DateTime updatedAt;
    String name;
    String files;
    String id;

    factory Folder.fromJson(Map<String, dynamic> json) => Folder(
        updatedAt: DateTime.parse(json["updated_at"]),
        name: json["name"],
        files: json["files"],
        id: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "updated_at": updatedAt.toIso8601String(),
        "name": name,
        "files": files,
        "id": id,
    };
}
