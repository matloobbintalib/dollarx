// To parse this JSON data, do
//
//     final referralResponse = referralResponseFromJson(jsonString);

import 'dart:convert';

ReferralResponse referralResponseFromJson(dynamic json) => ReferralResponse.fromJson(json);

String referralResponseToJson(ReferralResponse data) => json.encode(data.toJson());

class ReferralResponse {
  int status;
  String success;
  String message;
  ReferralModel data;

  ReferralResponse({
    required this.status,
    required this.success,
    required this.message,
    required this.data,
  });

  factory ReferralResponse.fromJson(Map<String, dynamic> json) => ReferralResponse(
    status: json["status"],
    success: json["success"],
    message: json["message"],
    data: ReferralModel.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "success": success,
    "message": message,
    "data": data.toJson(),
  };
}

class ReferralModel {
  String userReferralId;
  String parentId;
  String firstLevelInvestment;
  String secondLevelInvestment;
  String thirdLevelInvestment;
  String fourthLevelInvestment;
  String fifthLevelInvestment;
  int totalReferralsLevel1;
  List<LevelReferral> level1Referrals;
  int totalReferralsLevel2;
  List<LevelReferral> level2Referrals;
  int totalReferralsLevel3;
  List<LevelReferral> level3Referrals;
  int totalReferralsLevel4;
  List<LevelReferral> level4Referrals;
  int totalReferralsLevel5;
  List<LevelReferral> level5Referrals;

  ReferralModel({
    required this.userReferralId,
    required this.parentId,
    required this.firstLevelInvestment,
    required this.secondLevelInvestment,
    required this.thirdLevelInvestment,
    required this.fourthLevelInvestment,
    required this.fifthLevelInvestment,
    required this.totalReferralsLevel1,
    required this.level1Referrals,
    required this.totalReferralsLevel2,
    required this.level2Referrals,
    required this.totalReferralsLevel3,
    required this.level3Referrals,
    required this.totalReferralsLevel4,
    required this.level4Referrals,
    required this.totalReferralsLevel5,
    required this.level5Referrals,
  });

  factory ReferralModel.fromJson(Map<String, dynamic> json) => ReferralModel(
    userReferralId: json["userReferralID"],
    parentId: json["parentID"],
    firstLevelInvestment: json["firstLevelInvestment"],
    secondLevelInvestment: json["secondLevelInvestment"],
    thirdLevelInvestment: json["thirdLevelInvestment"],
    fourthLevelInvestment: json["fourthLevelInvestment"],
    fifthLevelInvestment: json["fifthLevelInvestment"],
    totalReferralsLevel1: json["totalReferralsLevel1"],
    level1Referrals: List<LevelReferral>.from(json["level1Referrals"].map((x) => LevelReferral.fromJson(x))),
    totalReferralsLevel2: json["totalReferralsLevel2"],
    level2Referrals: List<LevelReferral>.from(json["level2Referrals"].map((x) => LevelReferral.fromJson(x))),
    totalReferralsLevel3: json["totalReferralsLevel3"],
    level3Referrals: List<LevelReferral>.from(json["level3Referrals"].map((x) => LevelReferral.fromJson(x))),
    totalReferralsLevel4: json["totalReferralsLevel4"],
    level4Referrals: List<LevelReferral>.from(json["level4Referrals"].map((x) => LevelReferral.fromJson(x))),
    totalReferralsLevel5: json["totalReferralsLevel5"],
    level5Referrals: List<LevelReferral>.from(json["level5Referrals"].map((x) => LevelReferral.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "userReferralID": userReferralId,
    "parentID": parentId,
    "firstLevelInvestment": firstLevelInvestment,
    "secondLevelInvestment": secondLevelInvestment,
    "thirdLevelInvestment": thirdLevelInvestment,
    "fourthLevelInvestment": fourthLevelInvestment,
    "fifthLevelInvestment": fifthLevelInvestment,
    "totalReferralsLevel1": totalReferralsLevel1,
    "level1Referrals": List<dynamic>.from(level1Referrals.map((x) => x.toJson())),
    "totalReferralsLevel2": totalReferralsLevel2,
    "level2Referrals": List<dynamic>.from(level2Referrals.map((x) => x.toJson())),
    "totalReferralsLevel3": totalReferralsLevel3,
    "level3Referrals": List<dynamic>.from(level3Referrals.map((x) => x.toJson())),
    "totalReferralsLevel4": totalReferralsLevel4,
    "level4Referrals": List<dynamic>.from(level4Referrals.map((x) => x.toJson())),
    "totalReferralsLevel5": totalReferralsLevel5,
    "level5Referrals": List<dynamic>.from(level5Referrals.map((x) => x.toJson())),
  };
}

class LevelReferral {
  int id;
  String parentId;
  String referralId;
  String? depositsSumTotalAmount;

  LevelReferral({
    required this.id,
    required this.parentId,
    required this.referralId,
    required this.depositsSumTotalAmount,
  });

  factory LevelReferral.fromJson(Map<String, dynamic> json) => LevelReferral(
    id: json["id"],
    parentId: json["parent_id"],
    referralId: json["referral_id"],
    depositsSumTotalAmount: json["deposits_sum_total_amount"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "parent_id": parentId,
    "referral_id": referralId,
    "deposits_sum_total_amount": depositsSumTotalAmount,
  };
}
