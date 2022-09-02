class ContentEvent {}

class InitContentEvent extends ContentEvent {
  String? path;

  InitContentEvent({
    this.path,
  });
}
