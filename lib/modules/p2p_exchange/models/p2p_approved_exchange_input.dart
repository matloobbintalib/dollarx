import 'dart:async';

import 'package:dio/dio.dart';

class P2pApprovedExchangeInput {
  int p2p_id;
  String status;

  P2pApprovedExchangeInput({
    required this.p2p_id,
    required this.status,
  });

  Map<String, dynamic> toJson() => {
    'p2p_id': p2p_id,
    'status': status,
  };

  FormData toFormData() => FormData.fromMap({
    'p2p_id': p2p_id,
    'status': status,
  });
}
