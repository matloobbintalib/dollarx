  // To parse this JSON data, do
//
//     final dashboardDataResponse = dashboardDataResponseFromJson(jsonString);

import 'dart:convert';

import 'package:dollarax/modules/trade/models/active_trade_response.dart';

import '../../user/models/user_model.dart';

DashboardDataResponse dashboardDataResponseFromJson(dynamic json) => DashboardDataResponse.fromJson(json);

String dashboardDataResponseToJson(DashboardDataResponse data) => json.encode(data.toJson());

class DashboardDataResponse {
  int status;
  String success;
  String message;
  DashboardDataModel data;

  DashboardDataResponse({
    required this.status,
    required this.success,
    required this.message,
    required this.data,
  });

  factory DashboardDataResponse.fromJson(Map<String, dynamic> json) => DashboardDataResponse(
    status: json["status"],
    success: json["success"],
    message: json["message"],
    data: DashboardDataModel.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "success": success,
    "message": message,
    "data": data.toJson(),
  };
}

class DashboardDataModel {
  UserModel user;
  double walletBalanceDollarAx;
  String profitLossDollarAx;
  String totalInvestmentUsdt;
  String investmentUSD;
  double totalAuxTradeBalance;
  String totalCopyTradeInvestmentUSD;
  String copyTradeProfit;
  List<Slider> sliders;
  List<LatestWithdrawal> latestWithdrawals;
  List<LatestDeposit> latestDeposits;
  WalletBalance walletBalanceAllCurrencies;

  DashboardDataModel({
    required this.user,
    required this.walletBalanceDollarAx,
    required this.totalCopyTradeInvestmentUSD,
    required this.copyTradeProfit,
    required this.profitLossDollarAx,
    required this.totalInvestmentUsdt,
    required this.investmentUSD,
    required this.totalAuxTradeBalance,
    required this.sliders,
    required this.latestWithdrawals,
    required this.latestDeposits,
    required this.walletBalanceAllCurrencies,
  });

  factory DashboardDataModel.fromJson(Map<String, dynamic> json) => DashboardDataModel(
    user: UserModel.fromJson(json["user"]),
    walletBalanceDollarAx: json["walletBalanceUSDT"]?.toDouble(),
    totalCopyTradeInvestmentUSD: json["totalCopyTradeInvestmentUSD"],
    copyTradeProfit: json["copyTradeProfit"],
    profitLossDollarAx: json["profitLossDollarAx"],
    totalInvestmentUsdt: json["totalInvestmentUSDT"],
    investmentUSD: json["investmentUSD"],
    totalAuxTradeBalance: json["totalAuxTradeBalance"]?.toDouble(),
    sliders: List<Slider>.from(json["sliders"].map((x) => Slider.fromJson(x))),
    latestWithdrawals: List<LatestWithdrawal>.from(json["latestWithdrawals"].map((x) => LatestWithdrawal.fromJson(x))),
    latestDeposits: List<LatestDeposit>.from(json["latestDeposits"].map((x) => LatestDeposit.fromJson(x))),
    walletBalanceAllCurrencies: WalletBalance.fromJson(json["walletBalanceAllCurrencies"]),

  );

  Map<String, dynamic> toJson() => {
    "user": user.toJson(),
    "walletBalanceUSDT": walletBalanceDollarAx,
    "totalCopyTradeInvestmentUSD": totalCopyTradeInvestmentUSD,
    "copyTradeProfit": copyTradeProfit,
    "profitLossDollarAx": profitLossDollarAx,
    "totalInvestmentUSDT": totalInvestmentUsdt,
    "investmentUSD": investmentUSD,
    "totalAuxTradeBalance": totalAuxTradeBalance,
    "sliders": List<dynamic>.from(sliders.map((x) => x.toJson())),
    "latestWithdrawals": List<dynamic>.from(latestWithdrawals.map((x) => x.toJson())),
    "latestDeposits": List<dynamic>.from(latestDeposits.map((x) => x.toJson())),
    "walletBalanceAllCurrencies": walletBalanceAllCurrencies.toJson(),
  };
}

class WalletBalance {
  final double usdt;
  final double btc;
  final double eth;

  WalletBalance({required this.usdt, required this.btc, required this.eth});

  factory WalletBalance.fromJson(Map<String, dynamic> json) {
    return WalletBalance(
      usdt: json['USDT'] != null ? json['USDT'].toDouble() : 0,
      btc: json['BTC'] != null ? json['BTC'].toDouble() : 0,
      eth: json['ETH'] != null ? json['ETH'].toDouble() : 0,
    );
  }
  Map<String, dynamic> toJson() => {
    "USDT": usdt,
    "BTC": btc,
    "ETH": eth,
  };
}
class Slider {
  String title;
  String image;

  Slider({
    required this.title,
    required this.image,
  });

  factory Slider.fromJson(Map<String, dynamic> json) => Slider(
    title: json["title"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "image": image,
  };
}


class LatestDeposit {
  int id;
  String userId;
  String amount;
  String currency;
  String currencyRate;
  String rateId;
  String totalAmount;
  String transactionId;
  String? transType;
  DateTime transactionDate;
  String proofImage;
  String planId;
  String depositType;
  String status;
  DateTime createdAt;
  DateTime updatedAt;
  UserModel user;

  LatestDeposit({
    required this.id,
    required this.userId,
    required this.amount,
    required this.currency,
    required this.currencyRate,
    required this.rateId,
    required this.totalAmount,
    required this.transactionId,
    required this.transType,
    required this.transactionDate,
    required this.proofImage,
    required this.planId,
    required this.depositType,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.user
  });

  factory LatestDeposit.fromJson(Map<String, dynamic> json) => LatestDeposit(
    id: json["id"],
    userId: json["user_id"],
    amount: json["amount"],
    currency: json["currency"],
    currencyRate: json["currency_rate"],
    rateId: json["rate_id"],
    totalAmount: json["total_amount"],
    transactionId: json["transaction_id"],
    transType: json["trans_type"],
    transactionDate: DateTime.parse(json["transaction_date"]),
    proofImage: json["proof_image"],
    planId: json["plan_id"],
    depositType: json["deposit_type"],
    status:json["status"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    user: UserModel.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "amount": amount,
    "currency": currency,
    "currency_rate": currencyRate,
    "rate_id": rateId,
    "total_amount": totalAmount,
    "transaction_id": transactionId,
    "trans_type": transType,
    "transaction_date": transactionDate.toIso8601String(),
    "proof_image": proofImage,
    "plan_id": planId,
    "deposit_type": depositType,
    "status": status,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "user": user.toJson(),
  };
}

class LatestWithdrawal {
    int id;
    String userId;
    String amount;
    String fee;
    String currency;
    String currencyRate;
    String rateId;
    String totalAmount;
    String withdrawType;
    String status;
    dynamic approvedDate;
    DateTime createdAt;
    DateTime updatedAt;
    UserModel user;

    LatestWithdrawal({
      required this.id,
      required this.userId,
      required this.amount,
      required this.fee,
      required this.currency,
      required this.currencyRate,
      required this.rateId,
      required this.totalAmount,
      required this.withdrawType,
      required this.status,
      required this.approvedDate,
      required this.createdAt,
      required this.updatedAt,
      required this.user,
    });

    factory LatestWithdrawal.fromJson(Map<String, dynamic> json) => LatestWithdrawal(
      id: json["id"],
      userId: json["user_id"],
      amount: json["amount"],
      fee: json["fee"],
      currency: json["currency"],
      currencyRate: json["currency_rate"],
      rateId: json["rate_id"],
      totalAmount: json["total_amount"],
      withdrawType: json["withdraw_type"],
      status: json["status"],
      approvedDate: json["approved_date"],
      createdAt: DateTime.parse(json["created_at"]),
      updatedAt: DateTime.parse(json["updated_at"]),
      user: json["user"] != null ? UserModel.fromJson(json["user"]):UserModel.empty,
    );

    Map<String, dynamic> toJson() => {
      "id": id,
      "user_id": userId,
      "amount": amount,
      "fee": fee,
      "currency": currency,
      "currency_rate": currencyRate,
      "rate_id": rateId,
      "total_amount": totalAmount,
      "withdraw_type": withdrawType,
      "status": status,
      "approved_date": approvedDate,
      "created_at": createdAt.toIso8601String(),
      "updated_at": updatedAt.toIso8601String(),
      "user": user!.toJson(),
    };
  }
