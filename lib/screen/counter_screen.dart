import 'package:flutter/material.dart';
import 'package:timer_steambuilder/bloc/counter_bloc.dart';

class CounterScreenBloc extends StatefulWidget {
  @override
  _CounterPageState createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterScreenBloc> {
  CounterBloc _counterBloc;

  @override
  void initState() {
    // TODO: implement initState
    _counterBloc = CounterBloc(counter: 0);
    super.initState();
  }

  @override
  void dispose() async {
    await _counterBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Stream version of the Counter App')),
      body: Center(
        child: StreamBuilder<int>(
            stream: _counterBloc.counterObservable,
            initialData: 0,
            builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
              return Text('You hit me: ${snapshot.data} times');
            }),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            child: const Icon(Icons.add),
            onPressed: () {
              _counterBloc.increment();
            },
          ),
          SizedBox(
            height: 16.0,
          ),
          FloatingActionButton(
            child: const Icon(Icons.remove),
            onPressed: () {
              _counterBloc.decrement();
            },
          ),
        ],
      ),
    );
  }
}
