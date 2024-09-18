
class GoldDataModel {
  DateTime date;
  String ticker;
  double open;
  double high;
  double low;
  double close;

  GoldDataModel({
    required this.date,
    required this.ticker,
    required this.open,
    required this.high,
    required this.low,
    required this.close,
  });

  factory GoldDataModel.fromJson(Map<String, dynamic> json) => GoldDataModel(
    date: DateTime.parse(json["date"]),
    ticker: json["ticker"],
    open: json["open"]?.toDouble(),
    high: json["high"]?.toDouble(),
    low: json["low"]?.toDouble(),
    close: json["close"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "date": date.toIso8601String(),
    "ticker": ticker,
    "open": open,
    "high": high,
    "low": low,
    "close": close,
  };
}
