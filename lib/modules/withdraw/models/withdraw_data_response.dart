// To parse this JSON data, do
//
//     final withdrawDataResponse = withdrawDataResponseFromJson(jsonString);

import 'dart:convert';

WithdrawDataResponse withdrawDataResponseFromJson(dynamic json) => WithdrawDataResponse.fromJson(json);

String withdrawDataResponseToJson(WithdrawDataResponse data) => json.encode(data.toJson());

class WithdrawDataResponse {
  int status;
  String success;
  String message;
  WithdrawModel data;

  WithdrawDataResponse({
    required this.status,
    required this.success,
    required this.message,
    required this.data,
  });

  factory WithdrawDataResponse.fromJson(Map<String, dynamic> json) => WithdrawDataResponse(
    status: json["status"],
    success: json["success"],
    message: json["message"],
    data: WithdrawModel.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "success": success,
    "message": message,
    "data": data.toJson(),
  };
}

class WithdrawModel {
  dynamic usdtWithdrawBalance;
  dynamic btcWithdrawBalance;
  dynamic ethWithdrawBalance;
  List<Currency> currencies;
  dynamic balanceBtc;
  dynamic balanceEth;
  dynamic balanceUsdt;
  dynamic profitBalance;
  dynamic bonusBalance;
  WithdrawTypes withdrawTypes;

  WithdrawModel({
    required this.usdtWithdrawBalance,
    required this.btcWithdrawBalance,
    required this.ethWithdrawBalance,
    required this.currencies,
    required this.balanceBtc,
    required this.balanceEth,
    required this.balanceUsdt,
    required this.profitBalance,
    required this.bonusBalance,
    required this.withdrawTypes,
  });

  factory WithdrawModel.fromJson(Map<String, dynamic> json) => WithdrawModel(
    usdtWithdrawBalance: json["USDTWithdrawBalance"],
    btcWithdrawBalance: json["BTCWithdrawBalance"],
    ethWithdrawBalance: json["ETHWithdrawBalance"],
    currencies: List<Currency>.from(json["currencies"].map((x) => Currency.fromJson(x))),
    balanceBtc: json["balanceBTC"],
    balanceEth: json["balanceETH"],
    balanceUsdt: json["balanceUSDT"],
    profitBalance: json["profitBalance"],
    bonusBalance: json["bonusBalance"],
    withdrawTypes: WithdrawTypes.fromJson(json["withdraw_types"]),
  );

  Map<String, dynamic> toJson() => {
    "USDTWithdrawBalance": usdtWithdrawBalance,
    "BTCWithdrawBalance": btcWithdrawBalance,
    "ETHWithdrawBalance": ethWithdrawBalance,
    "currencies": List<dynamic>.from(currencies.map((x) => x.toJson())),
    "balanceBTC": balanceBtc,
    "balanceETH": balanceEth,
    "balanceUSDT": balanceUsdt,
    "profitBalance": profitBalance,
    "bonusBalance": bonusBalance,
    "withdraw_types": withdrawTypes.toJson(),
  };
}

class Currency {
  String name;
  String symbol;

  Currency({
    required this.name,
    required this.symbol,
  });

  factory Currency.fromJson(Map<String, dynamic> json) => Currency(
    name: json["name"],
    symbol: json["symbol"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "symbol": symbol,
  };
}

class WithdrawTypes {
  String profit;
  String bonus;
  String balance;

  WithdrawTypes({
    required this.profit,
    required this.bonus,
    required this.balance,
  });

  factory WithdrawTypes.fromJson(Map<String, dynamic> json) => WithdrawTypes(
    profit: json["profit"],
    bonus: json["bonus"],
    balance: json["balance"],
  );

  Map<String, dynamic> toJson() => {
    "profit": profit,
    "bonus": bonus,
    "balance": balance,
  };
}
