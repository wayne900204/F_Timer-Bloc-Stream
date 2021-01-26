import 'dart:async';

import 'package:flutter/material.dart';

import 'BlocBase.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Wenya Timer',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider<IncrementBloc>(
        bloc: IncrementBloc(),
        child: CounterPage(),
      ),
    );
  }
}

class CounterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final IncrementBloc bloc = BlocProvider.of<IncrementBloc>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Wenya Timer'),centerTitle: true,),
      body: Center(
        child: StreamBuilder<int>(
            stream: bloc.outCounter,
            initialData: 0,
            builder: (BuildContext context, AsyncSnapshot<int> snapshot){
              return Text('Look at this number ${snapshot.data}');
            }
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: (){
          bloc.incrementCounter.add(null);
        },
      ),
    );
  }
}

