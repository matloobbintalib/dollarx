import 'package:dio/dio.dart';

class GraphInput {
  String graph_records;

  GraphInput({
    required this.graph_records,
  });

  Map<String, dynamic> toJson() => {
    "graph_records": graph_records,
  };

  FormData toFormData() => FormData.fromMap({
    "graph_records": graph_records,
  });
}
