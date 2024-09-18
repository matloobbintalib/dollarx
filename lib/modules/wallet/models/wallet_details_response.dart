// To parse this JSON data, do
//
//     final walletDetailsResponse = walletDetailsResponseFromJson(jsonString);

import 'dart:convert';

WalletDetailsResponse walletDetailsResponseFromJson(dynamic json) => WalletDetailsResponse.fromJson(json);

String walletDetailsResponseToJson(WalletDetailsResponse data) => json.encode(data.toJson());

class WalletDetailsResponse {
  int status;
  String success;
  String message;
  WalletModel data;

  WalletDetailsResponse({
    required this.status,
    required this.success,
    required this.message,
    required this.data,
  });

  factory WalletDetailsResponse.fromJson(Map<String, dynamic> json) => WalletDetailsResponse(
    status: json["status"],
    success: json["success"],
    message: json["message"],
    data: WalletModel.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "success": success,
    "message": message,
    "data": data.toJson(),
  };
}

class WalletModel {
  List<CurrencyModel> currencyData;
  String totalBalanceUsd;
  String daxBalance;
  List<RecentFundReceiver> recentFundReceivers;

  WalletModel({
    required this.currencyData,
    required this.totalBalanceUsd,
    required this.daxBalance,
    required this.recentFundReceivers,
  });

  factory WalletModel.fromJson(Map<String, dynamic> json) => WalletModel(
    currencyData: List<CurrencyModel>.from(json["currency_data"].map((x) => CurrencyModel.fromJson(x))),
    totalBalanceUsd: json["total_balance_usd"],
    daxBalance: json["dax_balance"],
    recentFundReceivers: List<RecentFundReceiver>.from(json["recent_fund_receivers"].map((x) => RecentFundReceiver.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "currency_data": List<dynamic>.from(currencyData.map((x) => x.toJson())),
    "total_balance_usd": totalBalanceUsd,
    "dax_balance": daxBalance,
    "recent_fund_receivers": List<dynamic>.from(recentFundReceivers.map((x) => x.toJson())),
  };
}

class CurrencyModel {
  String currency;
  String balance;
  dynamic rate;
  double balanceUsd;

  CurrencyModel({
    required this.currency,
    required this.balance,
    required this.rate,
    required this.balanceUsd,
  });

  factory CurrencyModel.fromJson(Map<String, dynamic> json) => CurrencyModel(
    currency: json["currency"],
    balance: json["balance"],
    rate: json["rate"],
    balanceUsd: json["balance_usd"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "currency": currency,
    "balance": balance,
    "rate": rate,
    "balance_usd": balanceUsd,
  };
}

class RecentFundReceiver {
  String userId;
  String amount;
  String currency;
  String fundReceiverReferralId;
  String fundReceiverName;
  dynamic profilePic;

  RecentFundReceiver({
    required this.userId,
    required this.amount,
    required this.currency,
    required this.fundReceiverReferralId,
    required this.fundReceiverName,
    required this.profilePic,
  });

  factory RecentFundReceiver.fromJson(Map<String, dynamic> json) => RecentFundReceiver(
    userId: json["user_id"],
    amount: json["amount"],
    currency: json["currency"],
    fundReceiverReferralId: json["fund_receiver_referral_id"],
    fundReceiverName: json["fund_receiver_name"],
    profilePic: json["profile_pic"],
  );

  Map<String, dynamic> toJson() => {
    "user_id": userId,
    "amount": amount,
    "currency": currency,
    "fund_receiver_referral_id": fundReceiverReferralId,
    "fund_receiver_name": fundReceiverName,
    "profile_pic": profilePic,
  };
}
