import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/exceptions/api_error.dart';
import '../models/content_page_response.dart';
import '../repo/content_page_repository.dart';
import 'content_page_state.dart';

class ContentPageCubit extends Cubit<ContentPageState> {
  final ContentPageRepository _repository;

  ContentPageCubit(this._repository) : super(ContentPageState.initial());

  Future<void> contentPages() async {
    emit(state.copyWith(contentPageStatus: ContentPageStatus.loading));
    try {
      ContentPageResponse contentPagesResponse =
      await _repository.getContentPages();
      if (contentPagesResponse.status == 200) {
        emit(state.copyWith(
            contentPageStatus: ContentPageStatus.success,
            pages: contentPagesResponse.data,
            message: contentPagesResponse.message));
      } else {
        emit(state.copyWith(
            contentPageStatus: ContentPageStatus.failure,
            message: contentPagesResponse.message));
      }
    } on ApiError catch (e) {
      emit(state.copyWith(
          contentPageStatus: ContentPageStatus.failure, message: e.message));
    }
  }
}
