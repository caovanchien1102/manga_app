class DetailEvent {}

class InitDetailEvent extends DetailEvent {
  String? path;

  InitDetailEvent({
    this.path,
  });
}
