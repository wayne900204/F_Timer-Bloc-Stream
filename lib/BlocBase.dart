import 'dart:async';

import 'package:flutter/cupertino.dart';

abstract class BlocBase {
  void dispose();
}

// Generic BLoC provider
class BlocProvider<T extends BlocBase> extends StatefulWidget {
  BlocProvider({
    Key key,
    @required this.child,
    @required this.bloc,
  }): super(key: key);

  final T bloc;
  final Widget child;

  @override
  _BlocProviderState<T> createState() => _BlocProviderState<T>();

  static T of<T extends BlocBase>(BuildContext context){
    final type = _typeOf<BlocProvider<T>>();
    // ignore: deprecated_member_use
    BlocProvider<T> provider = context.ancestorWidgetOfExactType(type);
    return provider.bloc;
  }

  static Type _typeOf<T>() => T;
}

class _BlocProviderState<T> extends State<BlocProvider<BlocBase>>{
  @override
  void dispose(){
    widget.bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context){
    return widget.child;
  }
}

class IncrementBloc implements BlocBase {
  int _counter;

  //
  // Stream to handle the counter
  //
  StreamController<int> _counterController = StreamController<int>();
  StreamSink<int> get _inAdd => _counterController.sink;
  Stream<int> get outCounter => _counterController.stream;

  //
  // Stream to handle the action on the counter
  //
  StreamController _actionController = StreamController();
  StreamSink get incrementCounter => _actionController.sink;

  //
  // Constructor
  //
  IncrementBloc(){
    _counter = 0;
    _actionController.stream
        .listen(_handleLogic);
  }

  void dispose(){
    _actionController.close();
    _counterController.close();
  }

  void _handleLogic(data){
    _counter = _counter + 1;
    _inAdd.add(_counter);
  }
}