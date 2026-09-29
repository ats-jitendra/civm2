class UserDetails {
  final int id;
  final String userName;
  final String password;
  final String userType;
  final String fName;
  final String lName;
  final String mobile;
  final String email;
  final String address;
  final String? additionalUserType;

  UserDetails({
    required this.id,
    required this.userName,
    required this.password,
    required this.userType,
    required this.fName,
    required this.lName,
    required this.mobile,
    required this.email,
    required this.address,
    this.additionalUserType,
  });

  factory UserDetails.fromJson(Map<String, dynamic> json) {
    return UserDetails(
      id: json["id"],
      userName: json["userName"] ?? "",
      password: json["password"] ?? "",
      userType: json["userType"] ?? "",
      fName: json["fName"] ?? "",
      lName: json["lName"] ?? "",
      mobile: json["mobile"] ?? "",
      email: json["email"] ?? "",
      address: json["address"] ?? "",
      additionalUserType: json["additionalUserType"],
    );
  }
}