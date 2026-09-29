class UserModel {
  User? user;
  String? token;

  UserModel({this.user, this.token});

  UserModel.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (user != null) {
      data['user'] = user!.toJson();
    }
    data['token'] = token;
    return data;
  }
}

class User {
  int? id;
  String? userName;
  String? password;
  String? userType;
  String? fName;
  String? lName;
  String? mobile1;
  String? email;
  String? address;
  String? dob;
  String? profilePhoto;
  String? createDtm;
  String? status;
  String? rights;
  String? additionalUserType;
  String? primaryRole;

  User(
      {this.id,
      this.userName,
      this.password,
      this.userType,
      this.fName,
      this.lName,
      this.mobile1,
      this.email,
      this.address,
      this.dob,
      this.profilePhoto,
      this.createDtm,
      this.status,
      this.rights,
      this.additionalUserType,
      this.primaryRole});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userName = json['userName'];
    password = json['password'];
    userType = json['userType'];
    fName = json['fName'];
    lName = json['lName'];
    mobile1 = json['mobile'];
    email = json['email'];
    address = json['address'];
    dob = json['dob'];
    profilePhoto = json['profilePhoto'];
    createDtm = json['createDtm'];
    status = json['status'];
    rights = json['rights'];
    additionalUserType = json['additionalUserType'];
    primaryRole = json['primaryRole'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['userName'] = userName;
    data['password'] = password;
    data['userType'] = userType;
    data['fName'] = fName;
    data['lName'] = lName;
    data['mobile'] = mobile1;
    data['email'] = email;
    data['address'] = address;
    data['dob'] = dob;
    data['profilePhoto'] = profilePhoto;
    data['createDtm'] = createDtm;
    data['status'] = status;
    data['rights'] = rights;
    data['additionalUserType'] = additionalUserType;
    data['primaryRole'] = primaryRole;
    return data;
  }
}
