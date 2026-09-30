class AccountPageModel {
  UserDetails? userDetails;

  AccountPageModel({this.userDetails});

  AccountPageModel.fromJson(Map<String, dynamic> json) {
    userDetails = json['userDetails'] != null
        ? UserDetails.fromJson(json['userDetails'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (userDetails != null) {
      data['userDetails'] = userDetails!.toJson();
    }
    return data;
  }
}

class UserDetails {
  int? id;
  String? userName;
  String? password;
  String? userType;
  String? fName;
  String? lName;
  String? mobile;
  String? email;
  String? address;
  String? dob;
  String? profilePhoto;
  String? createDtm;
  String? status;

  UserDetails(
      {this.id,
      this.userName,
      this.password,
      this.userType,
      this.fName,
      this.lName,
      this.mobile,
      this.email,
      this.address,
      this.dob,
      this.profilePhoto,
      this.createDtm,
      this.status});

  UserDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userName = json['userName'];
    password = json['password'];
    userType = json['userType'];
    fName = json['fName'];
    lName = json['lName'];
    mobile = json['mobile'];
    email = json['email'];
    address = json['address'];
    dob = json['dob'];
    profilePhoto = json['profilePhoto'];
    createDtm = json['createDtm'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['userName'] = userName;
    data['password'] = password;
    data['userType'] = userType;
    data['fName'] = fName;
    data['lName'] = lName;
    data['mobile'] = mobile;
    data['email'] = email;
    data['address'] = address;
    data['dob'] = dob;
    data['profilePhoto'] = profilePhoto;
    data['createDtm'] = createDtm;
    data['status'] = status;
    return data;
  }
}
