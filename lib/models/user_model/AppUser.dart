class AppUser {
  AppUser({
      this.userID, 
      this.name,
      this.about,
      this.email, 
      this.nuRoll, 
      this.csiRoll, 
      this.cfId, 
      this.year, 
      this.profilePhotoUrl, 
      this.isAdmin, 
      this.isSuperuser, 
      this.expiryDate, 
      this.isActive, 
      this.notificationToken,});

  AppUser.fromJson(dynamic json) {
    userID = json['userID'];
    name = json['name'];
    about = json['about'];
    email = json['email'];
    nuRoll = json['nu_roll'];
    csiRoll = json['csi_roll'];
    cfId = json['cf_id'];
    year = json['year'];
    profilePhotoUrl = json['profile_photo_url'];
    isAdmin = json['is_admin'];
    isSuperuser = json['is_superuser'];
    expiryDate = json['expiry_date'];
    isActive = json['is_active'];
    notificationToken = json['notification_token'];
  }
  String? userID;
  String? name;
  String?about ;
  String? email;
  String? nuRoll;
  String? csiRoll;
  String? cfId;
  String? year;
  String? profilePhotoUrl;
  bool? isAdmin;
  bool? isSuperuser;
  num? expiryDate;
  bool? isActive;
  String? notificationToken;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['userID'] = userID;
    map['name'] = name;
    map['about']  = about ;
    map['email'] = email;
    map['nu_roll'] = nuRoll;
    map['csi_roll'] = csiRoll;
    map['cf_id'] = cfId;
    map['year'] = year;
    map['profile_photo_url'] = profilePhotoUrl;
    map['is_admin'] = isAdmin;
    map['is_superuser'] = isSuperuser;
    map['expiry_date'] = expiryDate;
    map['is_active'] = isActive;
    map['notification_token'] = notificationToken;
    return map;
  }

}