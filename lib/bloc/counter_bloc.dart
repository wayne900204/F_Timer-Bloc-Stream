import 'package:rxdart/rxdart.dart';

class CounterBloc {
  int counter;

  /**
   BehaviorSubject<T> class
This one is similar to the PublishSubject. It also allows sending 
data, error and done events to the listener, but the latest item 
that has been added to the subject will be sent to any new listeners
 of the subject. But don’t you worry, after that, any new events 
 will be appropriately sent to the listeners. 
   */
  //********************************** */
  // BehaviorSubject<int> _counterController;

/*
PublishSubject<T> class
This one is pretty simple. This Subject allows sending data, 
error and done events to the listener. Here it will work with 
Sinks, which we were talking about before. 
 */
//******************************** */
  // PublishSubject<int> _counterController;

  /*
  ReplaySubject<T> class
The ReplaySubject allow us the same: sending data, 
error and done events to the listener. But with a crucial 
difference here. As items are added to the subject, the 
ReplaySubject will store them and when the stream is listened to,
 those recorded items will be emitted to the listener. 
   */

  ReplaySubject<int> _counterController;

  CounterBloc({this.counter}) {
    // _counterController = BehaviorSubject<int>.seeded(counter);
    // _counterController = PublishSubject<int>()..add(this.counter);
    _counterController = ReplaySubject<int>()..add(this.counter);
  }

  Stream<int> get counterObservable => _counterController.stream;

  void increment() {
    this.counter = counter += 1;
    _counterController.add(this.counter);
  }

  void decrement() {
    this.counter = counter -= 1;
    _counterController.add(this.counter);
  }

  close() async {
    await _counterController.close();
  }
}
