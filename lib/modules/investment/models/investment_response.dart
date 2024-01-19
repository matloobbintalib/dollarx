import 'dart:convert';

InvestmentResponse investmentResponseFromJson(dynamic json) => InvestmentResponse.fromJson(json);

String investmentResponseToJson(InvestmentResponse data) => json.encode(data.toJson());

class InvestmentResponse {
  int status;
  String success;
  String message;
  InvestmentModel data;

  InvestmentResponse({
    required this.status,
    required this.success,
    required this.message,
    required this.data,
  });

  factory InvestmentResponse.fromJson(Map<String, dynamic> json) => InvestmentResponse(
    status: json["status"],
    success: json["success"],
    message: json["message"],
    data: InvestmentModel.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "success": success,
    "message": message,
    "data": data.toJson(),
  };
}

class InvestmentModel {
  int balance;
  int totalInvestmentUsdt;
  int totalWithdrawUsdt;
  int profitBalance;
  int referralTotalAmount;
  int bonus;
  List<LatestTransDatum> latestTransData;
  UserCurrentPlan userCurrentPlan;

  InvestmentModel({
    required this.balance,
    required this.totalInvestmentUsdt,
    required this.totalWithdrawUsdt,
    required this.profitBalance,
    required this.referralTotalAmount,
    required this.bonus,
    required this.latestTransData,
    required this.userCurrentPlan,
  });

  factory InvestmentModel.fromJson(Map<String, dynamic> json) => InvestmentModel(
    balance: json["balance"],
    totalInvestmentUsdt: json["totalInvestmentUSDT"],
    totalWithdrawUsdt: json["totalWithdrawUSDT"],
    profitBalance: json["profitBalance"],
    referralTotalAmount: json["referralTotalAmount"],
    bonus: json["bonus"],
    latestTransData: List<LatestTransDatum>.from(json["latestTransData"].map((x) => LatestTransDatum.fromJson(x))),
    userCurrentPlan: UserCurrentPlan.fromJson(json["user_current_plan"]),
  );

  Map<String, dynamic> toJson() => {
    "balance": balance,
    "totalInvestmentUSDT": totalInvestmentUsdt,
    "totalWithdrawUSDT": totalWithdrawUsdt,
    "profitBalance": profitBalance,
    "referralTotalAmount": referralTotalAmount,
    "bonus": bonus,
    "latestTransData": List<dynamic>.from(latestTransData.map((x) => x.toJson())),
    "user_current_plan": userCurrentPlan.toJson(),
  };
}

class LatestTransDatum {
  String amount;
  String totalAmount;
  String currency;
  String status;
  String type;
  String createdAt;

  LatestTransDatum({
    required this.amount,
    required this.totalAmount,
    required this.currency,
    required this.status,
    required this.type,
    required this.createdAt,
  });

  factory LatestTransDatum.fromJson(Map<String, dynamic> json) => LatestTransDatum(
    amount: json["amount"],
    totalAmount: json["total_amount"],
    currency: json["currency"],
    status: json["status"],
    type: json["type"],
    createdAt: json["created_at"],
  );

  Map<String, dynamic> toJson() => {
    "amount": amount,
    "total_amount": totalAmount,
    "currency": currency,
    "status": status,
    "type": type,
    "created_at": createdAt,
  };
}

class UserCurrentPlan {
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
  dynamic incrementAmount;
  String expiration;
  dynamic createdAt;
  dynamic updatedAt;

  UserCurrentPlan({
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
  });

  factory UserCurrentPlan.fromJson(Map<String, dynamic> json) => UserCurrentPlan(
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
  };
}
