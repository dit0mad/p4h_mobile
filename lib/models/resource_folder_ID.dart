/* 
// Example Usage
Map<String, dynamic> map = jsonDecode(<myJSONString>);
var myRootNode = Root.fromJson(map);
*/ 
class ResourceFolderID {
    DateTime? updatedat;
    String? displayname;

    ResourceFolderID({this.updatedat, this.displayname}); 

    ResourceFolderID.fromJson(Map<String, dynamic> json) {
        updatedat = json['updated_at'];
        displayname = json['display_name'];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = Map<String, dynamic>();
        data['updated_at'] = updatedat;
        data['display_name'] = displayname;
        return data;
    }
}


