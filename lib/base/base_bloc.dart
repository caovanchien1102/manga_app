import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manga_app/repository/repositories.dart';

class BaseBloc<EVENT, STATE> extends Bloc<EVENT, STATE> {
  final repo = Repositories();

  BaseBloc(
    STATE state,
  ) : super(state);
}
