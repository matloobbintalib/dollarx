class UserModel {
  int id;
  String name;
  String referralId;
  String email;
  dynamic parentId;
  String planId;
  String mobile;
  dynamic address;
  String status;
  dynamic btcAddress;
  dynamic ethAddress;
  dynamic usdtAddress;
  String profilePic;

  static UserModel empty = UserModel(
      id: -1,
      name: '',
      referralId: '',
      email: '',
      parentId: '',
      planId: '',
      mobile: '',
      address: '',
      status: '',
      btcAddress: '',
      ethAddress: '',
      usdtAddress: '',
      profilePic: '');

  UserModel({
    required this.id,
    required this.name,
    required this.referralId,
    required this.email,
    required this.parentId,
    required this.planId,
    required this.mobile,
    required this.address,
    required this.status,
    required this.btcAddress,
    required this.ethAddress,
    required this.usdtAddress,
    required this.profilePic,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    id: json["id"],
    name: json["name"],
    referralId: json["referral_id"],
    email: json["email"],
    parentId: json["parent_id"],
    planId: json["plan_id"],
    mobile: json["mobile"],
    address: json["address"],
    status: json["status"],
    btcAddress: json["btc_address"],
    ethAddress: json["eth_address"],
    usdtAddress: json["usdt_address"],
    profilePic: json["profile_pic"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "referral_id": referralId,
    "email": email,
    "parent_id": parentId,
    "plan_id": planId,
    "mobile": mobile,
    "address": address,
    "status": status,
    "btc_address": btcAddress,
    "eth_address": ethAddress,
    "usdt_address": usdtAddress,
    "profile_pic": profilePic,
  };



}