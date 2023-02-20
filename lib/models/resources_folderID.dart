// To parse this JSON data, do
//
//     final resourcesFolderId = resourcesFolderIdFromJson(jsonString);

import 'dart:convert';

List<ResourcesFolderId> resourcesFolderIdFromJson(String str) => List<ResourcesFolderId>.from(json.decode(str).map((x) => ResourcesFolderId.fromJson(x)));

String resourcesFolderIdToJson(List<ResourcesFolderId> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ResourcesFolderId {
    ResourcesFolderId({
        required this.updatedAt,
        required this.displayName,
    });

    DateTime updatedAt;
    String displayName;

    factory ResourcesFolderId.fromJson(Map<String, dynamic> json) => ResourcesFolderId(
        updatedAt: DateTime.parse(json["updated_at"]),
        displayName: json["display_name"],
    );

    Map<String, dynamic> toJson() => {
        "updated_at": updatedAt.toIso8601String(),
        "display_name": displayName,
    };
}
