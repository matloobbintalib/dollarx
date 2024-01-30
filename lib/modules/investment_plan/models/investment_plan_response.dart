// To parse this JSON data, do
//
//     final investmentPlansResponse = investmentPlansResponseFromJson(jsonString);

import 'dart:convert';

InvestmentPlansResponse investmentPlansResponseFromJson(dynamic json) => InvestmentPlansResponse.fromJson(json);

String investmentPlansResponseToJson(InvestmentPlansResponse data) => json.encode(data.toJson());

class InvestmentPlansResponse {
  int status;
  String success;
  String message;
  List<InvestmentPlanModel> data;

  InvestmentPlansResponse({
    required this.status,
    required this.success,
    required this.message,
    required this.data,
  });

  factory InvestmentPlansResponse.fromJson(Map<String, dynamic> json) => InvestmentPlansResponse(
    status: json["status"],
    success: json["success"],
    message: json["message"],
    data: List<InvestmentPlanModel>.from(json["data"].map((x) => InvestmentPlanModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "success": success,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class InvestmentPlanModel {
  int id;
  String name;
  String personelInvestmentLimit;
  String structuralInvestmentLimit;
  String price;
  String expectedReturn;
  String type;
  String imgUrl;
  String incrementInterval;
  String incrementType;
  String? incrementAmount;
  String expiration;
  dynamic createdAt;
  dynamic updatedAt;
  List<InvestmentBonus> investmentBonus;
  List<ProfitBonus> profitBonus;

  InvestmentPlanModel({
    required this.id,
    required this.name,
    required this.personelInvestmentLimit,
    required this.structuralInvestmentLimit,
    required this.price,
    required this.expectedReturn,
    required this.type,
    required this.imgUrl,
    required this.incrementInterval,
    required this.incrementType,
    required this.incrementAmount,
    required this.expiration,
    required this.createdAt,
    required this.updatedAt,
    required this.investmentBonus,
    required this.profitBonus,
  });

  factory InvestmentPlanModel.fromJson(Map<String, dynamic> json) => InvestmentPlanModel(
    id: json["id"],
    name: json["name"],
    personelInvestmentLimit: json["personel_investment_limit"],
    structuralInvestmentLimit: json["structural_investment_limit"],
    price: json["price"],
    expectedReturn: json["expected_return"],
    type: json["type"],
    imgUrl: json["img_url"],
    incrementInterval: json["increment_interval"],
    incrementType: json["increment_type"],
    incrementAmount: json["increment_amount"],
    expiration: json["expiration"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    investmentBonus: List<InvestmentBonus>.from(json["investment_bonus"].map((x) => InvestmentBonus.fromJson(x))),
    profitBonus: List<ProfitBonus>.from(json["profit_bonus"].map((x) => ProfitBonus.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "personel_investment_limit": personelInvestmentLimit,
    "structural_investment_limit": structuralInvestmentLimit,
    "price": price,
    "expected_return": expectedReturn,
    "type": type,
    "img_url": imgUrl,
    "increment_interval": incrementInterval,
    "increment_type": incrementType,
    "increment_amount": incrementAmount,
    "expiration": expiration,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "investment_bonus": List<dynamic>.from(investmentBonus.map((x) => x.toJson())),
    "profit_bonus": List<dynamic>.from(profitBonus.map((x) => x.toJson())),
  };
}

class InvestmentBonus {
  int id;
  String planId;
  String firstLine;
  String secondLine;
  String thirdLine;
  String fourthLine;
  String fifthLine;
  dynamic createdAt;
  dynamic updatedAt;

  InvestmentBonus({
    required this.id,
    required this.planId,
    required this.firstLine,
    required this.secondLine,
    required this.thirdLine,
    required this.fourthLine,
    required this.fifthLine,
    required this.createdAt,
    required this.updatedAt,
  });

  factory InvestmentBonus.fromJson(Map<String, dynamic> json) => InvestmentBonus(
    id: json["id"],
    planId: json["plan_id"],
    firstLine: json["first_line"],
    secondLine: json["second_line"],
    thirdLine: json["third_line"],
    fourthLine: json["fourth_line"],
    fifthLine: json["fifth_line"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "plan_id": planId,
    "first_line": firstLine,
    "second_line": secondLine,
    "third_line": thirdLine,
    "fourth_line": fourthLine,
    "fifth_line": fifthLine,
    "created_at": createdAt,
    "updated_at": updatedAt,
  };
}

class ProfitBonus {
  int id;
  String planId;
  String firstPline;
  String secondPline;
  String thirdPline;
  String fourthPline;
  String fifthPline;
  dynamic createdAt;
  dynamic updatedAt;

  ProfitBonus({
    required this.id,
    required this.planId,
    required this.firstPline,
    required this.secondPline,
    required this.thirdPline,
    required this.fourthPline,
    required this.fifthPline,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ProfitBonus.fromJson(Map<String, dynamic> json) => ProfitBonus(
    id: json["id"],
    planId: json["plan_id"],
    firstPline: json["first_pline"],
    secondPline: json["second_pline"],
    thirdPline: json["third_pline"],
    fourthPline: json["fourth_pline"],
    fifthPline: json["fifth_pline"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "plan_id": planId,
    "first_pline": firstPline,
    "second_pline": secondPline,
    "third_pline": thirdPline,
    "fourth_pline": fourthPline,
    "fifth_pline": fifthPline,
    "created_at": createdAt,
    "updated_at": updatedAt,
  };
}
