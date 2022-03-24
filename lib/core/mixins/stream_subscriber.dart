import 'dart:async';

mixin StreamSubscriber {
  final List<StreamSubscription> _subscriptions = [];

  void unsubscribeAll() {
    for (var sub in _subscriptions) {
      sub.cancel();
    }
  }

  void subscribe(StreamSubscription sub) => _subscriptions.add(sub);
}
