import 'package:dio/dio.dart';

class P2pProofUploadInput {
  int p2p_id;
  MultipartFile? prof_image;

  P2pProofUploadInput({
    required this.p2p_id,
    required this.prof_image,
  });

  Map<String, dynamic> toJson() => {
    'p2p_id': p2p_id,
    'prof_image': prof_image,
  };

  FormData toFormData() => FormData.fromMap({
    'p2p_id': p2p_id,
    'prof_image': prof_image,
  });
}
