import 'dart:convert';

IslamicTradItemsResponse islamicTradItemsResponseFromJson(dynamic json) => IslamicTradItemsResponse.fromJson(json);

String islamicTradItemsResponseToJson(IslamicTradItemsResponse data) => json.encode(data.toJson());

class IslamicTradItemsResponse {
  int status;
  String success;
  String message;
  List<IslamicTradeItemModel> data;

  IslamicTradItemsResponse({
    required this.status,
    required this.success,
    required this.message,
    required this.data,
  });

  factory IslamicTradItemsResponse.fromJson(Map<String, dynamic> json) => IslamicTradItemsResponse(
    status: json["status"],
    success: json["success"],
    message: json["message"],
    data: List<IslamicTradeItemModel>.from(json["data"].map((x) => IslamicTradeItemModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "success": success,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class IslamicTradeItemModel {
  int id;
  String title;
  String monthlyVolume;
  String monthly_volume_heading;
  String returnOfIncome;
  String tradeProfitPercentage;
  String tradeImage;
  String investors;
  String status;
  DateTime createdAt;
  DateTime updatedAt;

  IslamicTradeItemModel({
    required this.id,
    required this.title,
    required this.monthlyVolume,
    required this.monthly_volume_heading,
    required this.returnOfIncome,
    required this.tradeProfitPercentage,
    required this.tradeImage,
    required this.investors,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory IslamicTradeItemModel.fromJson(Map<String, dynamic> json) => IslamicTradeItemModel(
    id: json["id"],
    title: json["title"],
    monthlyVolume: json["monthly_volume"],
    monthly_volume_heading: json["monthly_volume_heading"],
    returnOfIncome: json["return_of_income"],
    tradeProfitPercentage: json["trade_profit_percentage"],
    tradeImage: json["trade_image"],
    investors: json["investors"],
    status: json["status"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "monthly_volume": monthlyVolume,
    "monthly_volume_heading": monthly_volume_heading,
    "return_of_income": returnOfIncome,
    "trade_profit_percentage": tradeProfitPercentage,
    "trade_image": tradeImage,
    "investors": investors,
    "status": status,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
