/// about : ""
/// cf_id : ""
/// email : ""
/// name : ""
/// nu_roll : ""
/// userID : ""
/// year : ""
/// profile_photo_url : ""

class PostCreator {
  PostCreator({
      this.about, 
      this.cfId, 
      this.email, 
      this.name, 
      this.nuRoll, 
      this.userID, 
      this.year, 
      this.profilePhotoUrl,});

  PostCreator.fromJson(dynamic json) {
    about = json['about'];
    cfId = json['cf_id'];
    email = json['email'];
    name = json['name'];
    nuRoll = json['nu_roll'];
    userID = json['userID'];
    year = json['year'];
    profilePhotoUrl = json['profile_photo_url'];
  }
  String? about;
  String? cfId;
  String? email;
  String? name;
  String? nuRoll;
  String? userID;
  String? year;
  String? profilePhotoUrl;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['about'] = about;
    map['cf_id'] = cfId;
    map['email'] = email;
    map['name'] = name;
    map['nu_roll'] = nuRoll;
    map['userID'] = userID;
    map['year'] = year;
    map['profile_photo_url'] = profilePhotoUrl;
    return map;
  }

}