import 'package:dio/dio.dart';

class EndIslamicTradeInput {
  String trade_id;

  EndIslamicTradeInput({
    required this.trade_id,
  });

  Map<String, dynamic> toJson() => {
    'trade_id': trade_id,
  };

  FormData toFormData() => FormData.fromMap({
    'trade_id': trade_id,
  });
}
