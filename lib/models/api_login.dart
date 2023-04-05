
class UserLogin {
    int? canvasId;
    String? school;
    String? phone;
    String? name;
    int? id;
    String? email;
    String? username;

    UserLogin({this.canvasId, this.school, this.phone, this.name, this.id, this.email, this.username}); 

    UserLogin.fromJson(Map<String, dynamic> json) {
        canvasId = json['canvasId'];
        school = json['school'];
        phone = json['phone'];
        name = json['name'];
        id = json['id'];
        email = json['email'];
        username = json['username'];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = Map<String, dynamic>();
        data['canvasId'] = canvasId;
        data['school'] = school;
        data['phone'] = phone;
        data['name'] = name;
        data['id'] = id;
        data['email'] = email;
        data['username'] = username;
        return data;
    }
}


