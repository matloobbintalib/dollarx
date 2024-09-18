import 'package:dio/dio.dart';

class BtcToUsdtInput {
  String interval;
  int limit;

  BtcToUsdtInput({
    required this.interval,
    required this.limit,
  });

  Map<String, dynamic> toJson() => {
    "interval": interval,
    "limit": limit,
  };

  FormData toFormData() => FormData.fromMap({
    "interval": interval,
    "limit": limit,
  });
}
