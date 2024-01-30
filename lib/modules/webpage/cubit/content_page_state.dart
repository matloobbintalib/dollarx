import '../models/content_page_response.dart';

enum ContentPageStatus {
  none,
  loading,
  success,
  failure,
}

class ContentPageState {
  final ContentPageStatus contentPageStatus;
  final List<ContentPageModel> pages;
  final String message;

  ContentPageState({
    required this.contentPageStatus,
    required this.pages,
    this.message = '',
  });


  factory ContentPageState.initial() {
    return ContentPageState(
        contentPageStatus: ContentPageStatus.none,
        message: '',
        pages: []);
  }

  ContentPageState copyWith({
    ContentPageStatus? contentPageStatus,
    String? message,
    List<ContentPageModel>? pages
  }) {
    return ContentPageState(
      contentPageStatus: contentPageStatus ?? this.contentPageStatus,
      message: message ?? this.message,
      pages: pages ?? this.pages,
    );
  }
}