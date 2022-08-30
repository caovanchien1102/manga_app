abstract class StateModel {
  StateModel();

  static success<T>(T value) {
    return StateModelSuccess<T>(value);
  }

  static failed() {
    return StateModelFailed();
  }

  static loading() {
    return StateModelLoading();
  }
}

class StateModelSuccess<T> extends StateModel {
  T? value;

  StateModelSuccess(this.value);
}

class StateModelFailed extends StateModel {}

class StateModelLoading extends StateModel {}
