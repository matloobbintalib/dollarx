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
  dynamic totalInvestmentUsdt;
  dynamic totalInvestmentBtc;
  dynamic totalInvestmentEth;
  dynamic totalWithdrawUsdt;
  dynamic balanceUsdt;
  dynamic balanceBtc;
  dynamic balanceEth;
  dynamic profitBalance;
  dynamic bonus;
  dynamic referralTotalAmount;
  List<LatestTransDatum> latestTransData;
  UserCurrentPlan userCurrentPlan;

  InvestmentModel({
    required this.totalInvestmentUsdt,
    required this.totalInvestmentBtc,
    required this.totalInvestmentEth,
    required this.totalWithdrawUsdt,
    required this.balanceUsdt,
    required this.balanceBtc,
    required this.balanceEth,
    required this.profitBalance,
    required this.bonus,
    required this.referralTotalAmount,
    required this.latestTransData,
    required this.userCurrentPlan,
  });

  factory InvestmentModel.fromJson(Map<String, dynamic> json) => InvestmentModel(
    totalInvestmentUsdt: json["totalInvestmentUSDT"],
    totalInvestmentBtc: json["totalInvestmentBTC"],
    totalInvestmentEth: json["totalInvestmentETH"],
    totalWithdrawUsdt: json["totalWithdrawUSDT"],
    balanceUsdt: json["balanceUSDT"],
    balanceBtc: json["balanceBTC"],
    balanceEth: json["balanceETH"],
    profitBalance: json["profitBalance"],
    bonus: json["bonus"],
    referralTotalAmount: json["referralTotalAmount"],
    latestTransData: List<LatestTransDatum>.from(json["latestTransData"].map((x) => LatestTransDatum.fromJson(x))),
    userCurrentPlan: UserCurrentPlan.fromJson(json["user_current_plan"]),
  );

  Map<String, dynamic> toJson() => {
    "totalInvestmentUSDT": totalInvestmentUsdt,
    "totalInvestmentBTC": totalInvestmentBtc,
    "totalInvestmentETH": totalInvestmentEth,
    "totalWithdrawUSDT": totalWithdrawUsdt,
    "balanceUSDT": balanceUsdt,
    "balanceBTC": balanceBtc,
    "balanceETH": balanceEth,
    "profitBalance": profitBalance,
    "bonus": bonus,
    "referralTotalAmount": referralTotalAmount,
    "latestTransData": List<dynamic>.from(latestTransData.map((x) => x.toJson())),
    "user_current_plan": userCurrentPlan.toJson(),
  };
}

class LatestTransDatum {
  dynamic amount;
  dynamic totalAmount;
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