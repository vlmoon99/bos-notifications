import 'package:flutter/material.dart';
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import 'backend/api_requests/api_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'flutter_flow/flutter_flow_util.dart';

class FFAppState extends ChangeNotifier {
  static final FFAppState _instance = FFAppState._internal();

  factory FFAppState() {
    return _instance;
  }

  FFAppState._internal();

  Future initializePersistedState() async {}

  void update(VoidCallback callback) {
    callback();
    notifyListeners();
  }

  List<SubscriptionStruct> _userSubscriptions = [];
  List<SubscriptionStruct> get userSubscriptions => _userSubscriptions;
  set userSubscriptions(List<SubscriptionStruct> _value) {
    _userSubscriptions = _value;
  }

  void addToUserSubscriptions(SubscriptionStruct _value) {
    _userSubscriptions.add(_value);
  }

  void removeFromUserSubscriptions(SubscriptionStruct _value) {
    _userSubscriptions.remove(_value);
  }

  void removeAtIndexFromUserSubscriptions(int _index) {
    _userSubscriptions.removeAt(_index);
  }

  void updateUserSubscriptionsAtIndex(
    int _index,
    SubscriptionStruct Function(SubscriptionStruct) updateFn,
  ) {
    _userSubscriptions[_index] = updateFn(_userSubscriptions[_index]);
  }

  int _latestBlockHeight = 0;
  int get latestBlockHeight => _latestBlockHeight;
  set latestBlockHeight(int _value) {
    _latestBlockHeight = _value;
  }
}

LatLng? _latLngFromString(String? val) {
  if (val == null) {
    return null;
  }
  final split = val.split(',');
  final lat = double.parse(split.first);
  final lng = double.parse(split.last);
  return LatLng(lat, lng);
}

void _safeInit(Function() initializeField) {
  try {
    initializeField();
  } catch (_) {}
}

Future _safeInitAsync(Function() initializeField) async {
  try {
    await initializeField();
  } catch (_) {}
}
