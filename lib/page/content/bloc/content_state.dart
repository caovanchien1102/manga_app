import 'package:manga_app/model/content.dart';

class ContentState {}

class LoadingContentState extends ContentState {}

class SuccessContentState extends ContentState {
  Content? content;

  SuccessContentState({
    this.content,
  });
}

class FailedContentState extends ContentState {}
