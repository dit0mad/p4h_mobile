class UserId {
    String? name;
    bool? hasSubmission;
    String? description;
    int? id;

    UserId({this.name, this.hasSubmission, this.description, this.id}); 

    UserId.fromJson(Map<String, dynamic> json) {
        name = json['name'];
        hasSubmission = json['hasSubmission'];
        description = json['description'];
        id = json['id'];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = Map<String, dynamic>();
        data['name'] = name;
        data['hasSubmission'] = hasSubmission;
        data['description'] = description;
        data['id'] = id;
        return data;
    }
}


