import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manga_app/base/base_bloc.dart';

typedef STF = StatefulWidget;

abstract class BaseState<B extends BaseBloc, T extends STF> extends State<T> {
  B get bloc => BlocProvider.of<B>(context);

  @override
  void dispose() {
    bloc.close();
    super.dispose();
  }
}
