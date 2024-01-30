class UserModel {
  int id;
  String name;
  String referralId;
  String email;
  String? parentId;
  String planId;
  String mobile;
  String? address;
  String status;
  String? btcAddress;
  String? ethAddress;
  String? usdtAddress;
  String? profilePic;
  String? city;
  dynamic bankName;
  dynamic bankAccountName;
  dynamic bankIbanNo;
  dynamic kycDocType;
  dynamic selfiPic;
  dynamic kycDocument;

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
      profilePic: '', city: '', bankName: '', bankAccountName: '', bankIbanNo: '', kycDocType: null, selfiPic: null, kycDocument: null,
  );

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
    required this.city,
    required this.bankName,
    required this.bankAccountName,
    required this.bankIbanNo,
    required this.kycDocType,
    required this.selfiPic,
    required this.kycDocument,
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
    city: json["city"],
    bankName: json["bank_name"],
    bankAccountName: json["bank_account_name"],
    bankIbanNo: json["bank_iban_no"],
    kycDocType: json["kyc_doc_type"],
    selfiPic: json["selfi_pic"],
    kycDocument: json["kyc_document"],
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
    "city": city,
    "bank_name": bankName,
    "bank_account_name": bankAccountName,
    "bank_iban_no": bankIbanNo,
    "kyc_doc_type": kycDocType,
    "selfi_pic": selfiPic,
    "kyc_document": kycDocument,
  };



}